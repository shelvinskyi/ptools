---------------------------
-- Default awesome theme --
---------------------------

local os = os
local theme_assets = require("beautiful.theme_assets")
local gears = require("gears")
local lain  = require("lain")
local awful = require("awful")
local wibox = require("wibox")
local dpi   = require("beautiful.xresources").apply_dpi
local theme_path = os.getenv("HOME") .. "/.config/awesome"

local theme = {}

theme.font          = "Roboto Light 8"

theme.bg_normal     = "#4D5C63"
theme.bg_focus      = "#698298"
theme.bg_urgent     = "#ff0000"
theme.bg_minimize   = "#444444"
theme.bg_systray    = theme.bg_normal

theme.fg_normal     = "#aaaaaa"
theme.fg_focus      = "#ffffff"
theme.fg_urgent     = "#ffffff"
theme.fg_minimize   = "#ffffff"

theme.useless_gap   = dpi(7)
theme.zero_width    = dpi(0)
theme.border_width  = dpi(0)
theme.border_normal = "#C5967C"
theme.border_focus  = "#A49F89"
theme.bg_tl_normal  = theme.border_normal
theme.bg_tl_focus   = theme.border_focus
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
theme.wallpaper = theme_path .. "/wallpapers/in-awe-of-mountains-5120x3840.jpg"

-- You can use your own layout icons like this:
theme.layout_floating  = theme_path.."/theme/layouts/floatingw.png"
theme.layout_max = theme_path.."/theme/layouts/maxw.png"
theme.layout_fullscreen = theme_path.."/theme/layouts/fullscreenw.png"
theme.layout_tileleft   = theme_path.."/theme/layouts/tileleftw.png"
theme.layout_centerwork = theme_path.."/theme/layouts/magnifierw.png"
theme.layout_spiral  = theme_path.."/theme/layouts/spiralw.png"

-- Generate Awesome icon:
theme.awesome_icon = theme_assets.awesome_icon(
    theme.menu_height, theme.bg_focus, theme.fg_focus
)

-- Define the icon theme for application icons. If not set then the icons
-- from /usr/share/icons and /usr/share/icons/hicolor will be used.
theme.icon_theme = nil


local markup = lain.util.markup
local clock = wibox.widget.textclock(
   " " .. utf8.char(0xf073) .. "  %d %b  " .. utf8.char(0xf017) .. " %H:%M "
)
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

-- Mail IMAP check
--[[ commented because it needs to be set before use
theme.mail = lain.widget.imap({
    timeout  = 180,
    server   = "server",
    mail     = "mail",
    password = "keyring get mail",
    notification_preset = { fg = white }
    settings = function()
        mail  = ""
        count = ""
        if mailcount > 0 then
            mail = "Mail "
            count = mailcount .. " "
        end
        widget:set_markup(markup.font(theme.font, markup(gray, mail) .. count))
    end
})
--]]

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
            vol = " " .. markup(gray, utf8.char(0xf028)) .. " " .. vlevel .. " "
        end

        widget:set_markup(markup.font(theme.font, vol))
    end
})

return theme

-- vim: filetype=lua:expandtab:shiftwidth=4:tabstop=8:softtabstop=4:textwidth=80
