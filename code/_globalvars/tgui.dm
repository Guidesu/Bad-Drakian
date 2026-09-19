GLOBAL_DATUM(changelog_tgui, /datum/changelog)
GLOBAL_LIST_INIT(tgui_themes, list(
	"azure_default" = "Ascendant",
	"azure_ascendant" = "New Ascendant",
	"azure_green" = "Oaken",
	"azure_lane" = "Noccite",
	"azure_purple" = "Raneshen",
	"azure_gilbranze" = "Gilbranze",
	"azure_psydonic" = "Psydonic",
	"azure_lingyue" = "Lingyue",
	"trey_liam" = "Trey Liam"
))

GLOBAL_LIST_INIT(parchment_skins, list(
	"vellum" = "Vellum",
	"parchment" = "Parchment",
	"leatherbound" = "Leatherbound",
))

GLOBAL_LIST_INIT(statbrowser_themes, list(
	"dark" = "Matte Black",
	"light" = "Leatherbound",
))

/// Fonts shipped with or expected by the client. Restricting this list keeps
/// per-client maptext rendering deterministic and prevents markup injection.
GLOBAL_LIST_INIT(interface_fonts, list(
	"Mookmania" = "Mookmania",
	"Arial" = "Arial",
	"Verdana" = "Verdana",
	"Georgia" = "Georgia",
	"Times New Roman" = "Times New Roman",
	"Courier New" = "Courier New",
))
