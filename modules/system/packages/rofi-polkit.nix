{ pkgs }:
pkgs.writeShellScriptBin "rofi-polkit-agent" ''
  #!${pkgs.bash}/bin/bash
  set -eu
 
  # Use built-in command to explicitly disable history
  (builtin unset HISTFILE) 2>/dev/null || true
 
  # Main function to encapsulate the entire script in a local scope
  main() {
      # Use a secure, user-specific lock directory in runtime directory
      local RUNTIME_DIR
      local LOCK_FILE
      local LOCK_TIMEOUT
 
      RUNTIME_DIR="/run/user/$(id -u)"
      if [ ! -d "$RUNTIME_DIR" ]; then
          # Fallback to secure temporary directory
          RUNTIME_DIR="$(mktemp -d)"
          trap 'rm -rf "$RUNTIME_DIR"' EXIT
      fi
 
      LOCK_FILE="$RUNTIME_DIR/rofi-polkit-agent.lock"
      LOCK_TIMEOUT=30 # Maximum lock time in seconds (prevent deadlocks)
 
      # Process help options
      if [ $# -gt 0 ]; then
          local all_args
          all_args="$*"
          case "$all_args" in
          'h'|'help'|'-h'|'-help'|'--help')
              echo 'Usage: rofi-polkit-agent [ROFI_OPTIONS]... Polkit agent using rofi for GUI.
    Start the polkit agent, with default options:
    rofi-polkit-agent
    Start the polkit agent, with any additional argument passed directly to rofi:
    rofi-polkit-agent -theme PATH -monitor NUM '
              return 0
              ;;
          esac
      fi
 
      # Function to securely acquire lock with timeout
      acquire_lock() {
          local start_time
          local current_time
          local lock_time
          local lock_pid
 
          start_time=$(date +%s)
 
          # Try to create lock directory - mkdir is atomic on most systems
          while ! mkdir "$LOCK_FILE" 2>/dev/null; do
              # Check if existing lock is stale (older than LOCK_TIMEOUT)
              if [ -f "$LOCK_FILE/timestamp" ] && [ -f "$LOCK_FILE/pid" ]; then
                  lock_time=$(cat "$LOCK_FILE/timestamp")
                  lock_pid=$(cat "$LOCK_FILE/pid")
                  current_time=$(date +%s)
 
                  # Check if process still exists
                  if ! kill -0 "$lock_pid" 2>/dev/null; then
                      # Process doesn't exist, remove stale lock
                      rm -rf "$LOCK_FILE"
                      continue
                  fi
 
                  # Check if lock timed out
                  if [ $((current_time - lock_time)) -gt "$LOCK_TIMEOUT" ]; then
                      # Lock timed out, remove it
                      rm -rf "$LOCK_FILE"
                      continue
                  fi
              fi
 
              # Check our own timeout
              current_time=$(date +%s)
              if [ $((current_time - start_time)) -gt 5 ]; then
                  return 1 # Failed to acquire lock within timeout
              fi
 
              # Sleep briefly before retrying
              sleep 0.1
          done
 
          # Successfully acquired lock, set up lock information
          echo "$$" > "$LOCK_FILE/pid"
          date +%s > "$LOCK_FILE/timestamp"
 
          # Make lock directory accessible only to current user
          chmod 700 "$LOCK_FILE"
 
          return 0
      }
 
      # Function to release lock
      release_lock() {
          if [ -d "$LOCK_FILE" ]; then
              # Only remove if we own the lock
              if [ -f "$LOCK_FILE/pid" ] && [ "$(cat "$LOCK_FILE/pid")" = "$$" ]; then
                  rm -rf "$LOCK_FILE"
              fi
          fi
      }
 
      # Setup cleanup trap
      cleanup() {
          release_lock
      }
 
      if [ "$#" -gt 0 ] && [ "$1" = "_CALLED_INTERNALLY" ]; then
          # Remove $1 (_CALLED_INTERNALLY) from parameter array
          shift 1
 
          # Read incoming messages one by one (line by line)
          local msg
          while IFS= read -r msg; do
              if echo "$msg" | jq -e '.action == "request password"' >/dev/null 2>&1; then
                  # Try to acquire lock with timeout
                  if ! acquire_lock; then
                      printf '{"action":"cancel","reason":"Authentication already in progress or system busy"}\n'
                      continue
                  fi
 
                  # Set trap to cleanup lock on exit
                  trap cleanup EXIT INT TERM HUP QUIT
 
                  # Parse msg fields safely
                  local prompt
                  local message
                  local response
                  local timeout_cmd
 
                  prompt="$(printf '%s' "$msg" | jq -r '.prompt // "Password:"')"
                  message="$(printf '%s' "$msg" | jq -r '.message // "No message given!"')"
 
                  # Request a password prompt from rofi with timeout
                  # Timeout prevents hanging if rofi crashes
                  response=""
                  timeout_cmd=""
                  if command -v timeout >/dev/null 2>&1; then
                      timeout_cmd="timeout $LOCK_TIMEOUT"
                  fi
 
                  if [ -n "$timeout_cmd" ]; then
                      response="$(printf '''' | $timeout_cmd rofi -dmenu -p "󰌆 " \
                          -mesg "$message" -password -no-fixed-num-lines "$@" || true)"
                  else
                      response="$(printf '''' | rofi -dmenu -p "󰌆 " \
                          -mesg "$message" -password -no-fixed-num-lines "$@" || true)"
                  fi
 
                  # Cancel authentication if no password was given,
                  # otherwise respond with given password
                  if [ -z "$response" ]; then
                      printf '{"action":"cancel"}\n'
                  else
                      # Use jq to properly escape the password to avoid JSON injection
                      printf '{"action":"authenticate","password":%s}\n' "$(printf '%s' "$response" | jq -R .)"
 
                      # Clear the password from memory immediately
                      response="$(dd if=/dev/urandom bs=64 count=1 2>/dev/null | base64 || echo "XXXXXXXXXXXXXXXXXXXX")"
                      unset response
                  fi
 
                  # Remove the lock
                  release_lock
                  trap - EXIT INT TERM HUP QUIT
              fi
          done
      else
          # Quote parameters properly to avoid injection
          local quoted_args
          quoted_args=""
          local arg
          for arg in "$@"; do
              quoted_args="$quoted_args $(printf '%q' "$arg")"
          done
 
          # Use exec to replace the current process
          exec ${pkgs.cmd-polkit}/bin/cmd-polkit-agent -s -q -c "$0 _CALLED_INTERNALLY$quoted_args"
      fi
  }
 
  # Run the main function with all arguments
  main "$@"
''
