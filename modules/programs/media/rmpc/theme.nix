{vars, ...}: let
	c = {
		bg = vars.theme.style.ui.bg;
		fg = vars.theme.style.text.main;
		accent = vars.theme.style.accent;
		muted = vars.theme.style.text.comment;
	};
in {
	home-manager = {
		extraSpecialArgs = {inherit vars;};
		users.${vars.user.name} = {...}: {
			xdg.configFile."rmpc/themes/theme.ron".text = ''
				#![enable(implicit_some)]
				#![enable(unwrap_newtypes)]
				#![enable(unwrap_variant_newtypes)]
				(
					background_color: "${c.bg}",
					modal_backdrop: true,
					text_color: "${c.fg}",
					header_background_color: "${c.bg}",
					modal_background_color: "${c.bg}",
					preview_label_style: (fg: "#c696f6"),
					preview_metadata_group_style: (fg: "${c.fg}"),
					song_table_album_separator: None,
					tab_bar: (
					    active_style: (fg: "${c.bg}", bg: "${c.accent}", modifiers: "Bold"),
					    inactive_style: (fg: "${c.fg}", bg: "${c.bg}"),
					),
					highlighted_item_style: (fg: "${c.accent}", modifiers: "Bold"),
					current_item_style: (fg: "${c.bg}", bg: "${c.accent}", modifiers: "Bold"),
					borders_style: (fg: "${c.fg}", modifiers: "Bold"),
					highlight_border_style: (fg: "${c.accent}"),
					symbols: (song: "󰝚 ", dir: "󱍙 ", playlist: "󰲸 ", marker: "* ", ellipsis: "...",
					    song_style: (fg: "${c.fg}"),
					    song_highlighted_style: None,
					    song_current_style: (fg: "#660606"),
					    dir_style: (fg: "${c.fg}"),
					    dir_highlighted_style: None,
					    dir_current_style: (fg: "#660606"),
					    playlist_style: (fg: "${c.fg}"),
					    playlist_highlighted_style: None,
					    playlist_current_style: (fg: "#660606"),
					    marker_style: (fg: "#f6f696"),
					    marker_highlighted_style: (fg: "#f6f696"),
					    marker_current_style: (fg: "${c.bg}", bg: "#f6f696" ),
					),
					progress_bar: (
					    symbols: ["█", "█", "█", "█", "█" ],
					    track_style: (fg: "${c.bg}", bg: "${c.bg}"),
					    elapsed_style: (fg: "${c.accent}", bg: "${c.bg}"),
					    thumb_style: (fg: "${c.accent}", bg: "${c.bg}"),
					    use_track_when_empty: false,
					),
					scrollbar: (
					    symbols: ["┋", "█", "󰄿", "󰄼"],
					    track_style: (fg: "${c.fg}"),
					    ends_style: (fg: "${c.fg}"),
					    thumb_style: (fg: "${c.fg}"),
					),
					song_table_format: [
					    (prop: (kind: Transform(Replace(content: (kind: Sticker("rating")), replacements: [
					        (match:  "0", replace: (kind: Group([(kind: Text("󰎡"),style: (fg: "${c.fg}"))]))),
					        (match:  "1", replace: (kind: Group([(kind: Text("󰎤"),style: (fg: "${c.fg}"))]))),
					        (match:  "2", replace: (kind: Group([(kind: Text("󰎧"),style: (fg: "${c.fg}"))]))),
					        (match:  "3", replace: (kind: Group([(kind: Text("󰎪"),style: (fg: "${c.fg}"))]))),
					        (match:  "4", replace: (kind: Group([(kind: Text("󰎭"),style: (fg: "${c.fg}"))]))),
					        (match:  "5", replace: (kind: Group([(kind: Text("󰎱"),style: (fg: "${c.fg}"))]))),
					        (match:  "6", replace: (kind: Group([(kind: Text("󰎳"),style: (fg: "${c.fg}"))]))),
					        (match:  "7", replace: (kind: Group([(kind: Text("󰎶"),style: (fg: "${c.fg}"))]))),
					        (match:  "8", replace: (kind: Group([(kind: Text("󰎹"),style: (fg: "${c.fg}"))]))),
					        (match:  "9", replace: (kind: Group([(kind: Text("󰎼"),style: (fg: "${c.fg}"))]))),
					        (match: "10", replace: (kind: Group([(kind: Text("󰽽"),style: (fg: "${c.fg}"))]))),
					    ])), default: (kind: Text(""), style: (fg: "${c.fg}"))),
					    width: "3",
					    label: "Rating",
					    alignment: Center,
					        label_prop: (kind: Group([
					            (kind: Text("󰩳"), style: (fg: "${c.fg}")),
					        ]))
					    ),
					    (prop: (kind: Sticker("playCount"),style: (fg: "${c.fg}"),
					        default: (kind: Text(""), style: (fg: "${c.fg}"))),
					        width: "3",
					        alignment: Left,
					        label: "Playcount",
					        label_prop: (kind: Group([
					            (kind: Text("󰆙"), style: (fg: "${c.fg}")),
					        ]))
					    ),
					    (prop:(kind: Text("│"), style: (fg: "${c.fg}")),
					        width: "1",
					        alignment: Center,
					        label: "",
					        label_prop: (kind: Group([
					            (kind: Text("│"), style: (fg: "${c.fg}")),
					        ]))
					    ),
					    (prop: (kind: Property(Artist), style: (fg: "${c.fg}"),
					        current_style: (fg: "#f6f6f6"),
					        highlighted_style: (fg: "#f6f6f6"),
					        default: (kind: Text("Unknown Artist"), style: (fg: "#666666"))),
					        width: "23%",
					        label_prop: (kind: Group([
					            (kind: Text("Artist "), style: (fg: "#e6e6e6")),
					            (kind: Text(""), style: (fg: "${c.fg}"))
					        ]))
					    ),
					    (prop: (kind: Property(Title), style: (fg: "${c.fg}"),
					        current_style: (fg: "${c.accent}"),
					        highlighted_style: (fg: "#f6f6f6"),
					        default: (kind: Property(Filename), style: (fg: "#e6e6e6"),
					            default: (kind: Text("Unknown Title"), style: (fg: "#e6e6e6")))),
					        width: "36%",
					        label_prop: (kind: Group([
					            (kind: Text("Title "), style: (fg: "#e6e6e6")),
					            (kind: Text(""), style: (fg: "${c.fg}"))
					        ]))
					    ),
					    (prop: (kind: Property(Album), style: (fg: "${c.fg}"),
					        current_style: (fg: "#f6f6f6"),
					        highlighted_style: (fg: "#f6f6f6"),
					        default: (kind: Text("Unknown Album"), style: (fg: "#565656"))),
					        width: "33%",
					        label_prop: (kind: Group([
					            (kind: Text("Album "), style: (fg: "#e6e6e6")),
					            (kind: Text("󰀥"), style: (fg: "${c.fg}"))
					        ]))
					    ),
					    (prop: (kind: Property(Duration), style: (fg: "${c.fg}"),
					        current_style: (fg: "#f6f6f6"),
					        highlighted_style: (fg: "#f6f6f6"),
					        default: (kind: Text("-"))),
					        width: "8%",
					        alignment: Right,
					        label_prop: (kind: Group([
					            (kind: Text("Length "), style: (fg: "#e6e6e6")),
					            (kind: Text(" "), style: (fg: "${c.fg}"))
					        ]))
					    ),
					],
					layout: Split(direction: Vertical, panes: [
					    (size: "7", borders: "NONE", pane: Component("header")),
					    (size: "100%", borders: "NONE", pane: Pane(TabContent)),
					    (size: "3", borders: "NONE", pane: Component("progress_bar")),
					]),
					browser_song_format: [
					    (kind: Group([
					        (kind: Property(Track)),
					        (kind: Text(" ")),
					    ])),
					    (kind: Group([
					        (kind: Property(Artist)),
					        (kind: Text(" - ")),
					        (kind: Property(Title)),
					    ]), default: (kind: Property(Filename)))
					],
					level_styles: (
					    info:  (fg: "#b6f696", bg: "${c.bg}"),
					    warn:  (fg: "#f6f696", bg: "${c.bg}"),
					    error: (fg: "#f69696", bg: "${c.bg}"),
					    debug: (fg: "#f6c696", bg: "${c.bg}"),
					    trace: (fg: "#c696f6", bg: "${c.bg}"),
					),
					components: {
					    "header_tab_bar": Split(direction: Horizontal, panes: [
					        (size: "11%", borders: "NONE", pane: Component("tab_bar_left")),
					        (size: "78%", borders: "NONE", pane: Pane(Tabs)),
					        (size: "11%", borders: "NONE", pane: Component("tab_bar_right")),
					    ]),
					    "header_line_1": Split(direction: Horizontal, panes: [
					        (size: "22%", pane: Component("header_element_1")),
					        (size: "1", pane: Component("header_element_space")),
					        (size: "56%", pane: Component("header_element_2")),
					        (size: "1", pane: Component("header_element_space")),
					        (size: "22%", pane: Component("header_element_3")),
					        (size: "2", pane: Component("header_element_right_end")),
					    ]),
					    "header_line_2": Split(direction: Horizontal, panes: [
					        (size: "22%", pane: Component("header_element_4")),
					        (size: "1", pane: Component("header_element_space")),
					        (size: "56%", pane: Component("header_element_5")),
					        (size: "1", pane: Component("header_element_space")),
					        (size: "22%", pane: Component("header_element_6")),
					        (size: "2", pane: Component("header_element_right_end")),
					    ]),
					    "header_line_3": Split(direction: Horizontal, panes: [
					        (size: "25%", pane: Component("header_element_7")),
					        (size: "1", pane: Component("header_element_space")),
					        (size: "50%", pane: Component("header_element_8")),
					        (size: "1", pane: Component("header_element_space")),
					        (size: "25%", pane: Component("header_element_9")),
					        (size: "2", pane: Component("header_element_right_end")),
					    ]),
					    "header": Split(direction: Vertical, panes: [
					        (size: "2", borders: "TOP | RIGHT | LEFT", border_symbols: Plain,
					            pane: Split(direction: Horizontal, panes: [
					                (size: "100%", borders: "NONE", pane: Component("header_tab_bar")),
					            ])
					        ),
					        (size: "5", borders: "ALL", border_symbols: Plain,
					            border_title: [
					                (kind: Text("─"), style: (fg: "${c.fg}")),
					                (kind: Transform(Replace(content: (kind: Sticker("rating")), replacements: [
					                    (match:  "0", replace: (kind: Group([(kind: Text("["), style: (fg: "${c.fg}")), (kind: Text("     "), style: (fg: "${c.fg}")), (kind: Text("]"), style: (fg: "${c.fg}"))]))),
					                    (match:  "1", replace: (kind: Group([(kind: Text("["), style: (fg: "${c.fg}")), (kind: Text(" "),         style: (fg: "${c.fg}")), (kind: Text("    "), style: (fg: "${c.fg}")), (kind: Text("]"), style: (fg: "${c.fg}"))]))),
					                    (match:  "2", replace: (kind: Group([(kind: Text("["), style: (fg: "${c.fg}")), (kind: Text(" "),         style: (fg: "${c.fg}")), (kind: Text("    "), style: (fg: "${c.fg}")), (kind: Text("]"), style: (fg: "${c.fg}"))]))),
					                    (match:  "3", replace: (kind: Group([(kind: Text("["), style: (fg: "${c.fg}")), (kind: Text("  "),       style: (fg: "${c.fg}")), (kind: Text("   "), style: (fg: "${c.fg}")), (kind: Text("]"), style: (fg: "${c.fg}"))]))),
					                    (match:  "4", replace: (kind: Group([(kind: Text("["), style: (fg: "${c.fg}")), (kind: Text("  "),       style: (fg: "${c.fg}")), (kind: Text("   "), style: (fg: "${c.fg}")), (kind: Text("]"), style: (fg: "${c.fg}"))]))),
					                    (match:  "5", replace: (kind: Group([(kind: Text("["), style: (fg: "${c.fg}")), (kind: Text("   "),     style: (fg: "${c.fg}")), (kind: Text("  "), style: (fg: "${c.fg}")), (kind: Text("]"), style: (fg: "${c.fg}"))]))),
					                    (match:  "6", replace: (kind: Group([(kind: Text("["), style: (fg: "${c.fg}")), (kind: Text("   "),     style: (fg: "${c.fg}")), (kind: Text("  "), style: (fg: "${c.fg}")), (kind: Text("]"), style: (fg: "${c.fg}"))]))),
					                    (match:  "7", replace: (kind: Group([(kind: Text("["), style: (fg: "${c.fg}")), (kind: Text("    "),   style: (fg: "${c.fg}")), (kind: Text(" "), style: (fg: "${c.fg}")), (kind: Text("]"), style: (fg: "${c.fg}"))]))),
					                    (match:  "8", replace: (kind: Group([(kind: Text("["), style: (fg: "${c.fg}")), (kind: Text("    "),   style: (fg: "${c.fg}")), (kind: Text(" "), style: (fg: "${c.fg}")), (kind: Text("]"), style: (fg: "${c.fg}"))]))),
					                    (match:  "9", replace: (kind: Group([(kind: Text("["), style: (fg: "${c.fg}")), (kind: Text("     "), style: (fg: "${c.fg}")), (kind: Text("]"), style: (fg: "${c.fg}"))]))),
					                    (match: "10", replace: (kind: Group([(kind: Text("["), style: (fg: "${c.fg}")), (kind: Text("     "), style: (fg: "${c.fg}")), (kind: Text("]"), style: (fg: "${c.fg}"))]))),
					                ])), default: (kind: Text("─"),style: (fg: "${c.fg}"))),
					                (kind: Text("─"), style: (fg: "${c.fg}")),
					            ],
					            border_title_position: Bottom,
					            border_title_alignment: Right,
					            pane: Split(direction: Vertical, panes: [
					                (size: "100%", borders: "NONE", pane: Component("header_line_1")),
					                (size: "100%", borders: "NONE", pane: Component("header_line_2")),
					                (size: "100%", borders: "NONE", pane: Component("header_line_3")),
					            ])
					        ),
					    ]),
					    "progress_bar": Split(direction: Vertical, panes: [
					        (size: "3", borders: "ALL", border_symbols: Plain,
					            border_title: [
					                (kind: Property(Status(Elapsed)),style: (fg: "${c.accent}")),
					                (kind: Property(Status(StateV2(playing_label: "─󱦟─", paused_label: "  ", stopped_label: "  "))),
					                    style: (fg: "${c.accent}", modifiers: "Bold")),
					                (kind: Property(Status(Duration)),style: (fg: "${c.accent}")),
					            ],
					            border_title_position: Top,
					            border_title_alignment: Center,
					            pane: Split(direction: Vertical, panes: [
					                (size: "100%", borders: "NONE", pane: Pane(ProgressBar)),
					            ])
					        ),
					    ]),
					    "tab_bar_left": Split(direction: Horizontal, panes: [
					        (size: "100%", pane: Pane(Property(content: [
					            (kind: Text(" "), style: (fg: "${c.fg}", modifiers: "Bold")),
					            (kind: Property(Status(StateV2(playing_label: "", paused_label: "", stopped_label: ""))),
					                style: (fg: "#e6e6e6")),
					            (kind: Text("  "), style: (fg: "${c.fg}", modifiers: "Bold")),
					            (kind: Property(Song(FileExtension)), style: (fg: "${c.fg}")),
					            (kind: Text(" ")),
					            (kind: Property(Widget(ScanStatus)), style: (fg: "#e6e6e6", modifiers: "Bold")),
					            (kind: Text(" ")),
					            (kind: Property(Status(InputBuffer())), style: (fg: "${c.fg}")),
					        ], align: Left))),
					    ]),
					    "tab_bar_right": Split(direction: Horizontal, panes: [
					        (size: "100%", pane: Pane(Property(content: [
					            (kind: Transform(Replace(content: (kind: Property(Status(Partition)), style: (fg: "${c.fg}")), replacements: [
					                (match:  "default", replace: (kind: Group([(kind: Text(""))]))),
					            ]))),
					            (kind: Text(" ")),
					            (kind: Property(Song(Channels())), style: (fg: "${c.fg}"),
					                default: (kind: Text("0"), style: (fg: "${c.fg}"))),
					            (kind: Text(" 󱡫 "),style: (fg: "${c.fg}")),
					            (kind: Text(" 󱡬"), style: (fg: "${c.fg}", modifiers: "Bold")),
					            (kind: Property(Status(Volume)), style: (fg: "#e6e6e6")),
					            (kind: Text("% "), style: (fg: "${c.fg}", modifiers: "Bold"))
					        ], align: Right))),
					    ]),
					    "header_element_1": Split(direction: Horizontal, panes: [
					        (size: "100%", pane: Pane(Property(content: [
					            (kind: Text("[ "),style: (fg: "${c.fg}", modifiers: "Bold")),
					            (kind: Property(Status(Elapsed)),style: (fg: "#e6e6e6")),
					            (kind: Text(" / "),style: (fg: "${c.fg}", modifiers: "Bold")),
					            (kind: Property(Status(Duration)),style: (fg: "#e6e6e6")),
					            (kind: Text(" 󱦟"),style: (fg: "${c.fg}", modifiers: "Bold")),
					            (kind: Text(" ]"),style: (fg: "${c.fg}", modifiers: "Bold")),
					        ], align: Left))),
					    ]),
					    "header_element_2": Split(direction: Horizontal, panes: [
					        (size: "100%", pane: Pane(Property(content: [
					            (kind: Property(Song(Title)), style: (fg: "${c.accent}",modifiers: "Bold"),
					                default: (kind: Property(Song(Filename)), style: (fg: "${c.accent}",modifiers: "Bold"),
					                default: (kind: Text("Unknown Title"), style: (fg: "${c.accent}",modifiers: "Bold"))))
					        ], align: Center, scroll_speed: 6))),
					    ]),
					    "header_element_3": Split(direction: Horizontal, panes: [
					        (size: "100%", pane: Pane(Property(content: [
					            (kind: Text("[ "),style: (fg: "${c.fg}", modifiers: "Bold")),
					            (kind: Property(Status(RepeatV2(on_label: "", off_label: "",
					                on_style: (fg: "#f6f6f6", modifiers: "Bold"),
					                off_style: (fg: "#565656"))))
					            ),
					            (kind: Text(" | "),style: (fg: "${c.fg}", modifiers: "Bold")),
					            (kind: Property(Status(RandomV2(on_label: "", off_label: "",
					                on_style: (fg: "#f6f6f6", modifiers: "Bold"),
					                off_style: (fg: "#565656", modifiers: "Bold"))))
					            ),
					            (kind: Text(" | "),style: (fg: "${c.fg}", modifiers: "Bold")),
					            (kind: Property(Status(ConsumeV2(on_label: "󰮯", off_label: "󰮯", oneshot_label: "󰮯󰇊",
					                on_style: (fg: "#f6f6f6", modifiers: "Bold"),
					                off_style: (fg: "#565656", modifiers: "Bold"))))
					            ),
					            (kind: Text(" | "),style: (fg: "${c.fg}", modifiers: "Bold")),
					            (kind: Property(Status(SingleV2(on_label: "󰎤", off_label: "󰎦", oneshot_label: "󰇊", off_oneshot_label: "󱅊",
					                on_style: (fg: "#e6e6e6", modifiers: "Bold"),
					                off_style: (fg: "#a6a6a6", modifiers: "Bold"))))
					            ),
					            (kind: Text(" | "),style: (fg: "${c.fg}", modifiers: "Bold")),
					            (kind: Property(Status(Crossfade)),style: (fg: "${c.fg}"),
					                default: (kind: Text("󰴽"), style: (fg: "${c.fg}"))
					            ),
					            (kind: Text(" | "),style: (fg: "${c.fg}", modifiers: "Bold")),
					            (kind: Transform(Replace(content: (kind: Property(Status(InputMode()))), replacements: [
					                (match:  "Normal", replace: (kind: Group([(kind: Text("N"),style: (fg: "#a6a6a6", modifiers: "Bold"))]))),
					                (match:  "Insert", replace: (kind: Group([(kind: Text("I"),style: (fg: "${c.fg}", modifiers: "Bold"))]))),
					            ]))),
					        ], align: Right))),
					    ]),
					    "header_element_4": Split(direction: Horizontal, panes: [
					        (size: "100%", pane: Pane(Property(content: [
					            (kind: Text("[ "),style: (fg: "${c.fg}", modifiers: "Bold")),
					            (kind: Property(Song(Bits())),default: (kind: Text(" "), style: (fg: "#e6e6e6")), style: (fg: "#e6e6e6")),
					            (kind: Text(" bit"),style: (fg: "${c.fg}")),
					            (kind: Text(" | "),style: (fg: "${c.fg}", modifiers: "Bold")),
					            (kind: Property(Status(Bitrate)),default: (kind: Text(" "), style: (fg: "#e6e6e6")),style: (fg: "#e6e6e6")),
					            (kind: Text(" kbps"),style: (fg: "${c.fg}")),
					            (kind: Text(" ]"),style: (fg: "${c.fg}", modifiers: "Bold"))
					        ], align: Left))),
					    ]),
					    "header_element_5": Split(direction: Horizontal, panes: [
					        (size: "100%", pane: Pane(Property(content: [
					            (kind: Transform(Replace(content:
					                (kind: Property(Song(Artist)), style: (fg: "${c.fg}"),
					                    default: (kind: Text("Unknown Artist"), style: (fg: "${c.fg}"))
					                ), replacements: [(match:  "", replace: (kind: Group([(kind: Text("Unknown Artist"), style: (fg: "${c.fg}"))])))]
					            ))),
					            (kind: Text(" - "), style: (fg: "${c.fg}")),
					            (kind: Transform(Replace(content:
					                (kind: Property(Song(Album)),style: (fg: "${c.fg}" ),
					                    default: (kind: Text("Unknown Album"), style: (fg: "${c.fg}"))
					                ), replacements: [(match:  "", replace: (kind: Group([(kind: Text("Unknown Album"), style: (fg: "${c.fg}"))])))]
					            ))),
					        ], align: Center, scroll_speed: 6))),
					    ]),
					    "header_element_6": Split(direction: Horizontal, panes: [
					        (size: "100%", pane: Pane(Property(content: [
					            (kind: Text("[ "),style: (fg: "${c.fg}", modifiers: "Bold")),
					            (kind: Property(Status(QueueTimeRemaining(separator: " "))),style: (fg: "#e6e6e6")),
					            (kind: Text(" / "),style: (fg: "${c.fg}", modifiers: "Bold")),
					            (kind: Property(Status(QueueTimeTotal(separator: " "))),style: (fg: "#e6e6e6")),
					            (kind: Text(" 󱎫"),style: (fg: "${c.fg}", modifiers: "Bold")),
					        ], align: Right))),
					    ]),
					    "header_element_7": Split(direction: Horizontal, panes: [
					        (size: "100%", pane: Pane(Property(content: [
					        (kind: Text("[ "),style: (fg: "${c.fg}", modifiers: "Bold")),
					        (kind: Property(Song(SampleRate())),default: (kind: Text(" "), style: (fg: "#e6e6e6")), style: (fg: "#e6e6e6")),
					        (kind: Text(" Hz"),style: (fg: "${c.fg}")),
					        (kind: Text(" | "),style: (fg: "${c.fg}", modifiers: "Bold")),
					        (kind: Property(Song(Position)), style: (fg: "#e6e6e6"),
					            default: (kind: Text("0"), style: (fg: "#e6e6e6"))),
					        (kind: Text(" / "),style: (fg: "${c.fg}", modifiers: "Bold")),
					        (kind: Property(Status(QueueLength())),style: (fg: "#e6e6e6")),
					        (kind: Text(" 󰴍"),style: (fg: "${c.fg}", modifiers: "Bold")),
					        (kind: Text(" ]"),style: (fg: "${c.fg}", modifiers: "Bold"))
					        ], align: Left))),
					    ]),
					    "header_element_8": Split(direction: Horizontal, panes: [
					        (size: "100%", pane: Pane(Property(content: [
					            (kind: Transform(Replace(content:
					                (kind: Property(Song(Other("albumartist"))),style: (fg: "${c.fg}"),
					                    default: (kind: Text("Unknown Albumartist"), style: (fg: "${c.fg}"))
					                ), replacements: [(match:  "", replace: (kind: Group([(kind: Text("Unknown Albumartist"), style: (fg: "${c.fg}"))])))]
					            ))),
					            (kind: Text(" - "), style: (fg: "${c.fg}")),
					            (kind: Transform(Replace(content:
					                (kind: Property(Song(Other("composer"))),style: (fg: "${c.fg}"),
					                    default: (kind: Text("Unknown Composer"), style: (fg: "${c.fg}"))
					                ), replacements: [(match:  "", replace: (kind: Group([(kind: Text("Unknown Composer"), style: (fg: "${c.fg}"))])))]
					            ))),
					        ], align: Center, scroll_speed: 6))),
					    ]),
					    "header_element_9": Split(direction: Horizontal, panes: [
					        (size: "100%", pane: Pane(Property(content: [
					            (kind: Text("[ "),style: (fg: "${c.fg}", modifiers: "Bold")),
					            (kind: Transform(Replace(content:
					                (kind: Property(Song(Other("date"))),style: (fg: "#e6e6e6"),
					                    default: (kind: Text("Unknown Date"), style: (fg: "#666666"))
					                ), replacements: [(match:  "", replace: (kind: Group([(kind: Text("Unknown Date"), style: (fg: "#666666"))])))]
					            ))),
					            (kind: Text(" | "),style: (fg: "${c.fg}", modifiers: "Bold")),
					            (kind: Transform(Replace(content:
					                (kind: Property(Song(Track)),style: (fg: "#e6e6e6"),
					                    default: (kind: Text("0"), style: (fg: "#666666"))
					                ), replacements: [(match:  "", replace: (kind: Group([(kind: Text("0"), style: (fg: "#666666"))])))]
					            ))),
					            (kind: Text(" / "),style: (fg: "${c.fg}", modifiers: "Bold")),
					            (kind: Transform(Replace(content:
					                (kind: Property(Song(Disc)),style: (fg: "#e6e6e6"),
					                    default: (kind: Text("0"), style: (fg: "#666666"))
					                ), replacements: [(match:  "", replace: (kind: Group([(kind: Text("0"), style: (fg: "#666666"))])))]
					            ))),
					            (kind: Text(" 󰥠 | "),style: (fg: "${c.fg}", modifiers: "Bold")),
					            (kind: Transform(Replace(content:
					                (kind: Property(Song(Other("genre"))),style: (fg: "#e6e6e6"),
					                    default: (kind: Text("Unknown Genre"), style: (fg: "#666666"))
					                ), replacements: [(match:  "", replace: (kind: Group([(kind: Text("Unknown Genre"), style: (fg: "#666666"))])))]
					            ))),
					        ], align: Right))),
					    ]),
					    "header_element_right_end": Split(direction: Horizontal, panes: [
					        (size: "100%", pane: Pane(Property(content: [
					            (kind: Text(" ]"),style: (fg: "${c.fg}", modifiers: "Bold")),
					        ], align: Right))),
					    ]),
					    "header_element_space": Split(direction: Horizontal, panes: [
					        (size: "100%", pane: Pane(Property(content: [
					            (kind: Text(" ")),
					        ], align: Right))),
					    ]),
					},
					cava: (
					    bar_symbols: ['▁', '▂', '▃', '▄', '▅', '▆', '▇', '█'],
					    bar_width: 1, bar_spacing: 1,
					    bg_color: "${c.bg}",
					    bar_color: Gradient({
					        50:   "${c.accent}",
					        100: "#f6f6f6"
					    })
					),
					lyrics:(
					    timestamp: false,
					    alignment: Center,
					),
					border_symbol_sets: {
					    "plain_collapsed_top": (
					        parent: Plain,
					        top_left: "├",
					        top_right: "┤",
					    ),
					},
				)
			'';
		};
	};
}
