---------------------------
-- Default awesome theme --
---------------------------

local os = os
local gears        = require("gears")
local lain         = require("lain")
local awful        = require("awful")
local wibox        = require("wibox")
local theme_assets = require("beautiful.theme_assets")
local xresources   = require("beautiful.xresources")
local dpi          = xresources.apply_dpi
local xrdb         = xresources.get_current_theme()
local theme_path   = os.getenv("HOME") .. "/.config/awesome"

local theme = {}

theme.font          = "Roboto Mono 8"

theme.bg_dark       = xrdb.background
theme.bg_normal     = xrdb.color0
theme.bg_focus      = xrdb.color8
theme.bg_urgent     = xrdb.color8
theme.bg_minimize   = xrdb.color8
theme.bg_systray    = xrdb.color8

theme.fg_normal     = xrdb.color8
theme.fg_focus      = xrdb.color4
theme.fg_urgent     = xrdb.color3
theme.fg_minimize   = xrdb.color8

theme.useless_gap   = dpi(5)
theme.zero_width    = dpi(2)
theme.border_width  = dpi(0)
theme.notification_border_width = dpi(0)
theme.border_normal = xrdb.background 
theme.border_focus  = xrdb.background
theme.bg_tl_normal  = xrdb.color0
theme.bg_tl_focus   = xrdb.color0
theme.border_radius = dpi(6)
theme.border_marked = "#91231C"

local gray          = "#9E9C9A"

-- There are other variable sets
-- overriding the default one when
-- defined, the sets are:
-- taglist_[bg|fg]_[focus|urgent|occupied|empty|volatile]
-- tasklist_[bg|fg]_[focus|urgent]
-- titlebar_[bg|fg]_[normal|focus]
-- tooltip_[font|opacity|fg_color|bg_color|border_width|border_color]
-- mouse_finder_[color|timeout|animate_timeout|radius|factor]
-- prompt_[fg|bg|fg_cursor|bg_cursor|font]
-- hotkeys_[bg|fg|border_width|border_color|shape|opacity|modifiers_fg|label_bg|label_fg|group_margin|font|description_font]
-- Example:
-- theme.taglist_bg_focus = "#ff0000"

-- Generate taglist squares:
local taglist_square_size = dpi(3)
theme.taglist_squares_sel = theme_assets.taglist_squares_sel(
    taglist_square_size, theme.fg_normal
)
theme.taglist_squares_unsel = theme_assets.taglist_squares_unsel(
    taglist_square_size, theme.fg_normal
)

-- Variables set for theming notifications:
-- notification_font
-- notification_[bg|fg]
-- notification_[width|height|margin]
-- notification_[border_color|border_width|shape|opacity]

-- Variables set for theming the menu:
-- menu_[bg|fg]_[normal|focus]
-- menu_[border_color|border_width]
theme.menu_submenu_icon = theme_path.."/theme/submenu.png"
theme.menu_height = dpi(15)
theme.menu_width  = dpi(100)

-- You can add as many variables as
-- you wish and access them by using
-- beautiful.variable in your rc.lua
--theme.bg_widget = "#cc0000"

-- theme.wallpaper = theme_path.."/wallpapers/train-smoke-cogecha.jpg"
-- theme.wallpaper = theme_path .. "/wallpapers/in-awe-of-mountains-5120x3840.jpg"
-- theme.wallpaper = theme_path .. "/wallpapers/tokyo-4k.jpg"
theme.wallpaper = theme_path .. "/wallpapers/forest.jpg"


-- You can use your own layout icons like this:
theme.layout_floating  = theme_path.."/theme/layouts/floatingw.png"
theme.layout_max = theme_path.."/theme/layouts/maxw.png"
theme.layout_fullscreen = theme_path.."/theme/layouts/fullscreenw.png"
theme.layout_tileleft   = theme_path.."/theme/layouts/tileleftw.png"
theme.layout_centerwork = theme_path.."/theme/layouts/magnifierw.png"
theme.layout_spiral  = theme_path.."/theme/layouts/spiralw.png"

-- titlebar icons
theme.titlebar_size = dpi(32)
theme.titlebar_title_align = "center"
theme.titlebar_position = "top"
theme.titlebar_bg = xrdb.color0
theme.titlebar_fg_focus = xrdb.color4
theme.titlebar_fg_normal = xrdb.color0

theme.titlebar_close_button_normal = theme_path.."/theme/icons/close_normal.svg"
theme.titlebar_close_button_focus  = theme_path.."/theme/icons/close_focus.svg"

theme.titlebar_ontop_button_normal_inactive = theme_path.."/theme/icons/ontop_normal_inactive.svg"
theme.titlebar_ontop_button_focus_inactive  = theme_path.."/theme/icons/ontop_focus_inactive.svg"
theme.titlebar_ontop_button_normal_active = theme_path.."/theme/icons/ontop_normal_active.svg"
theme.titlebar_ontop_button_focus_active  = theme_path.."/theme/icons/ontop_focus_active.svg"

theme.titlebar_floating_button_normal_inactive = theme_path.."/theme/icons/floating_normal_inactive.svg"
theme.titlebar_floating_button_focus_inactive  = theme_path.."/theme/icons/floating_focus_inactive.svg"
theme.titlebar_floating_button_normal_active = theme_path.."/theme/icons/floating_normal_active.svg"
theme.titlebar_floating_button_focus_active  = theme_path.."/theme/icons/floating_focus_active.svg"


-- Generate Awesome icon:
theme.awesome_icon = theme_assets.awesome_icon(
    theme.menu_height, theme.bg_focus, theme.fg_focus
)

-- Define the icon theme for application icons. If not set then the icons
-- from /usr/share/icons and /usr/share/icons/hicolor will be used.
theme.icon_theme = nil


local markup = lain.util.markup
local clock = wibox.widget.textclock(markup(
    gray,
    " " .. utf8.char(0xf073) ..
    "  %d %b  " .. utf8.char(0xf017) ..
    " %H:%M "
))
clock.font = theme.font
theme.clock = clock


local kblayout = awful.widget.keyboardlayout()
if kblayout == "us" then
    kblayout = "🇬🇧"
elseif kblayout == "ua" then
    kblayout = "🇺🇦"
end
theme.keyboardlayout = kblayout

-- Calendar
theme.cal = lain.widget.cal({
    attach_to = { clock },
    notification_preset = {
        font = 'Roboto Mono 10',
        fg   = theme.fg_normal,
        bg   = theme.bg_normal
    }
})

-- Battery
local bat = lain.widget.bat({
    timeout = 5,
    settings = function()
        p = bat_now.perc
        icon = ""
        if p > 85 then
            icon = utf8.char(0xf240)
        elseif (p > 65 and p <= 85) then
            icon = utf8.char(0xf241)
        elseif (p > 35 and p <= 65) then
            icon = utf8.char(0xf242)
        elseif (p > 5 and p <= 35) then
            icon = utf8.char(0xf243)
        else
            icon = utf8.char(0xf244)
        end
        if bat_now.status == "Charging" then
            icon = utf8.char(0xf5e7)
        end
        bat_str = " " .. icon .. " " .. p .. "% "
        widget:set_markup(markup.font(theme.font, markup(gray, bat_str)))
    end,
    full_notify = "off"
})

theme.bat = bat

-- ALSA volume
theme.volume = lain.widget.alsa({
    timeout = 10,
    settings = function()
        vlevel  = volume_now.level

        if volume_now.status == "off" then
            vol = " " .. markup(gray, utf8.char(0xf6a9)) .. " "
        else
            vol = " " .. markup(gray, utf8.char(0xf028) .. " " .. vlevel .. " ")
        end

        widget:set_markup(markup.font(theme.font, vol))
    end
})

return theme

-- vim: filetype=lua:expandtab:shiftwidth=4:tabstop=8:softtabstop=4:textwidth=80
