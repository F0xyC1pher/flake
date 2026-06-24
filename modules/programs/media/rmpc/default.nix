{
	inputs,
	vars,
	...
}:
# let
# keybinds = import ./keybinds.nix {};
# in
{
	home-manager = {
		extraSpecialArgs = {inherit inputs vars;};
		users.${vars.user.name} = {pkgs, ...}: {
			programs.rmpc = {
				enable = true;
				package = inputs.rmpc.packages.${pkgs.stdenv.hostPlatform.system}.default;
				config = ''
										#![enable(implicit_some)]
					#![enable(unwrap_newtypes)]
					#![enable(unwrap_variant_newtypes)]
					(
											address: "/home/f/.local/share/mpd/socket",
											cache_dir: "/home/f/Music",
											on_song_change: None,
											volume_step: 5,
											max_fps: 60,
											scrolloff: 0,
											enable_mouse: true,
											enable_config_hot_reload: true,
											select_current_song_on_change: true,
											theme: "theme",
					tabs: [
											    (name: "Home", pane: Split(direction: Horizontal, panes: [
											        (size: "65%", borders: "NONE", pane: Split(direction: Vertical, panes: [
											            (size: "3", borders: "ALL", border_symbols: Plain , pane: Pane(QueueHeader())),
											            (size: "100%", borders: "ALL", border_symbols: Plain ,pane: Pane(Queue)),
											        ])),
											        (size: "35%", borders: "NONE", border_symbols: Plain ,pane: Split(direction: Vertical, panes: [
											            (size: "0.47r", borders: "TOP | RIGHT | LEFT",
											                border_symbols: Plain,
											                pane: Pane(AlbumArt)
											            ),
											            (size: "100%", borders: "ALL",
											                border_symbols: Library("plain_collapsed_top"),
											                border_title: [
											                    (kind: Text("┐"), style: (fg: "#81a1c1")),
											                    (kind: Text("Lyrics"), style: (fg: "#81a1c1")),
											                    (kind: Text("┌"), style: (fg: "#81a1c1")),
											                ],
											                border_title_position: Top,
											                border_title_alignment: Right,
											                pane: Pane(Lyrics)
											            ),
											        ])),
											    ])),
											    (name: "Directories", pane: Split(direction: Horizontal,panes: [
											        (size: "100%", borders: "ALL", border_symbols: Plain, pane: Pane(Directories)),
											    ])),
											    (name: "Playlists", pane: Split(direction: Horizontal, panes: [
											        (size: "100%", borders: "ALL", border_symbols: Plain, pane: Pane(Playlists)),
											    ])),
											    (name: "Artists", pane: Split(direction: Horizontal, panes: [
											        (size: "100%", borders: "ALL", border_symbols: Plain, pane: Pane(Browser(
											            levels: [
											                (group_by: [[Artist]],
											                    skip: SingleEmpty,
											                ),
											                (group_by: [[Album], [Other("date"), Other("originaldate")]],
											                    format: [
											                        (kind: Group([
											                            (kind: Text("(")),
											                            (kind: Property(Other("date"))),
											                            (kind: Text(") ")),
											                        ])),
											                        (kind: Property(Album)),
											                    ],
											                ),
											            ],
											        ))),
											    ])),
											    (name: "Albums", pane: Split(direction: Horizontal, panes: [
											        (size: "100%", borders: "ALL", border_symbols: Plain, pane: Pane(Browser(
											            levels: [
											                (group_by: [[Album]]),
											            ],
											        ))),
											    ])),
											    (name: "Album Artists", pane: Split(direction: Horizontal, panes: [
											        (size: "100%", borders: "ALL", border_symbols: Plain, pane: Pane(Browser(
											            levels: [
											                (group_by: [[AlbumArtist]]),
											                (
											                    group_by: [[Album], [Other("date"), Other("originaldate")]],
											                    format: [
											                        (kind: Group([
											                            (kind: Text("(")),
											                            (kind: Property(Other("date"))),
											                            (kind: Text(") ")),
											                        ])),
											                        (kind: Property(Album)),
											                    ],
											                    skip: UnpackEmpty,
											                ),
											            ],
											        ))),
											    ])),
											    (name: "Composer", pane: Split(direction: Horizontal, panes: [
											        (size: "100%", borders: "ALL", border_symbols: Plain, pane: Pane(Browser(
											            levels: [
											                (group_by: [[Other("composer")]]),
											                (group_by: [[Album], [Other("date"), Other("originaldate")]],
											                    format: [
											                        (kind: Group([
											                            (kind: Text("(")),
											                            (kind: Property(Other("date"))),
											                            (kind: Text(") ")),
											                        ])),
											                        (kind: Property(Album)),
											                    ],
											                ),
											            ],
											        ))),
											    ])),
											    (name: "Genre", pane: Split(direction: Horizontal, panes: [
											        (size: "100%", borders: "ALL", border_symbols: Plain, pane: Pane(Browser(
											            levels: [
											                (group_by: [[Other("genre")]]),
											                (group_by: [[AlbumArtist, Artist]],
											                    sort_by: [[AlbumArtist, Artist]],
											                    format: [
											                        (kind: Property(AlbumArtist), default: (kind: Property(Artist), default: (kind: Text("no artist")))),
											                    ],
											                    skip: SingleEmpty,
											                ),
											                (group_by: [[Album], [Other("date"), Other("originaldate")]],
											                    format: [
											                        (kind: Group([
											                            (kind: Text("(")),
											                            (kind: Property(Other("date"))),
											                            (kind: Text(") ")),
											                        ])),
											                        (kind: Property(Album)),
											                    ],
											                    skip: UnpackEmpty,
											                ),
											            ],
											        ))),
											    ])),
											    (name: "Queue", pane: Split(direction: Vertical, panes: [
											        (size: "2", borders: "TOP | RIGHT | LEFT", border_symbols: Plain, pane: Pane(QueueHeader())),
											        (size: "100%", borders: "ALL", border_symbols: Library("plain_collapsed_top"),
											            border_title: [
											                (kind: Text("● "), style: (fg: "#81a1c1")),
											                (kind: Property(Song(File)), style: (fg: "#4c566a")),
											                (kind: Text(" ●─"), style: (fg: "#81a1c1")),
											            ],
											            border_title_position: Bottom,
											            border_title_alignment: Right,
											            pane: Pane(Queue)
											        ),
											    ])),
											    (name: "Cava",pane: Split(direction: Vertical, panes: [
											        (size: "50%", pane: Split(direction: Horizontal, panes: [
											            (size: "39%", borders: "ALL", border_symbols: Plain, pane: Pane(Queue)),
											            (size: "22%", borders: "ALL", border_symbols: Plain, pane: Pane(AlbumArt)),
											            (size: "39%", borders: "ALL",
											                border_title: [
											                    (kind: Text("┐"), style: (fg: "#81a1c1")),
											                    (kind: Text("Lyrics"), style: (fg: "#81a1c1")),
											                    (kind: Text("┌─"), style: (fg: "#81a1c1")),
											                ],
											                border_title_position: Top,
											                border_title_alignment: Right,
											                border_symbols: Plain,
											                pane: Pane(Lyrics)
											            ),
											        ])),
											        (size: "50%", borders: "ALL", border_symbols: Plain, pane: Pane(Cava)),
											    ])),
											    (name: "Search", pane: Split(direction: Horizontal, panes: [
											        (size: "100%", borders: "ALL", border_symbols: Plain, pane: Pane(Search)),
											    ])),
											],
					)

				'';
				#  ${keybinds}
			};
		};
	};
}
