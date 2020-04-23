pcall(require, "luarocks.loader")
-- Standard awesome library
local os            = os
local gears         = require("gears")
local awful         = require("awful")
local wibox         = require("wibox")
local beautiful     = require("beautiful")
local naughty       = require("naughty")
local menubar       = require("menubar")
local lain          = require("lain")
local hotkeys_popup = require("awful.hotkeys_popup")
require("awful.autofocus")

hotkeys_popup.widget.hide_without_description = true

-- {{{ Error handling
-- Check if awesome encountered an error during startup and fell back to
-- another config (This code will only ever execute for the fallback config)
if awesome.startup_errors then
    naughty.notify({ preset = naughty.config.presets.critical,
                     title = "Oops, there were errors during startup!",
                     text = awesome.startup_errors })
end

-- Handle runtime errors after startup
do
    local in_error = false
    awesome.connect_signal("debug::error", function (err)
        -- Make sure we don't go into an endless error loop
        if in_error then return end
        in_error = true

        naughty.notify({ preset = naughty.config.presets.critical,
                         title = "Oops, an error happened!",
                         text = tostring(err) })
        in_error = false
    end)
end
-- }}}

-- {{{ Variable definitions
-- Themes define colours, icons, font and wallpapers.
theme_path = os.getenv("HOME") .. "/.config/awesome"
beautiful.init(theme_path .. "/theme.lua")

-- This is used later as the default terminal and editor to run.
terminal   = "urxvt"
browser    = "firefox"
editor     = "vim"
editor_cmd = terminal .. " -e " .. editor

modkey = "Mod4"

-- Table of layouts to cover with awful.layout.inc, order matters.
awful.layout.layouts = {
    awful.layout.suit.max,
    awful.layout.suit.tile.left,
    lain.layout.centerwork,
    awful.layout.suit.floating,
}
-- }}}

-- {{{ Menu
-- Create a launcher widget and a main menu
myawesomemenu = {
   { "hotkeys", function() hotkeys_popup.show_help(nil, awful.screen.focused()) end },
   { "edit config", editor_cmd .. " " .. awesome.conffile },
   { "restart", awesome.restart },
   { "quit", function() awesome.quit() end }
}

mymainmenu = awful.menu({ items = { { "awesome", myawesomemenu  },
                                    { "open terminal", terminal }
                                  }
                        })

-- Menubar configuration
menubar.utils.terminal = terminal -- Set the terminal for applications that require it

-- Create a wibox for each screen and add it
local taglist_buttons = gears.table.join(
                    awful.button({ }, 1, function(t) t:view_only() end),
                    awful.button({ modkey }, 1, function(t)
                                              if client.focus then
                                                  client.focus:move_to_tag(t)
                                              end
                                          end),
                    awful.button({ }, 3, awful.tag.viewtoggle),
                    awful.button({ modkey }, 3, function(t)
                                              if client.focus then
                                                  client.focus:toggle_tag(t)
                                              end
                                          end),
                    awful.button({ }, 4, function(t) awful.tag.viewnext(t.screen) end),
                    awful.button({ }, 5, function(t) awful.tag.viewprev(t.screen) end)
                )

local tasklist_buttons = gears.table.join(
                     awful.button({ }, 1, function (c)
                                              if c == client.focus then
                                                  c.minimized = true
                                              else
                                                  c:emit_signal(
                                                      "request::activate",
                                                      "tasklist",
                                                      {raise = true}
                                                  )
                                              end
                                          end),
                     awful.button({ }, 3, function()
                                              awful.menu.client_list({ theme = { width = 250 } })
                                          end),
                     awful.button({ }, 4, function ()
                                              awful.client.focus.byidx(1)
                                          end),
                     awful.button({ }, 5, function ()
                                              awful.client.focus.byidx(-1)
                                          end))

local function set_wallpaper(s)
    -- Wallpaper
    if beautiful.wallpaper then
        local wallpaper = beautiful.wallpaper
        -- If wallpaper is a function, call it with the screen
        if type(wallpaper) == "function" then
            wallpaper = wallpaper(s)
        end
        gears.wallpaper.maximized(wallpaper, s)
    end
end

-- Re-set wallpaper when a screen's geometry changes (e.g. different resolution)
screen.connect_signal("property::geometry", set_wallpaper)

awful.screen.connect_for_each_screen(function(s)
    -- Wallpaper
    set_wallpaper(s)

    -- Each screen has its own tag table.
    awful.tag.add("1", {
        icon               = theme_path .. "/theme/icons/first.png",
        screen             = s,
    })
    awful.tag.add("2", {
        icon               = theme_path .. "/theme/icons/second.jpg",
        screen             = s,
    })
    awful.tag.add("3", {
        icon               = theme_path .. "/theme/icons/third.jpg",
        screen             = s,
    })
    awful.tag.add("4", {
        icon               = theme_path .. "/theme/icons/fourth.png",
        screen             = s,
    })
    awful.tag.add("5", {
        icon               = theme_path .. "/theme/icons/fifth.png",
        screen             = s,
    })
    --awful.tag({ "1", "2", "3", "4", "5" }, s, awful.layout.layouts[1])

    -- Create a promptbox for each screen
    s.mypromptbox = awful.widget.prompt()
    -- Create an imagebox widget which will contain an icon indicating which layout we're using.
    -- We need one layoutbox per screen.
    s.mylayoutbox = awful.widget.layoutbox(s)
    s.mylayoutbox:buttons(gears.table.join(
                           awful.button({ }, 1, function () awful.layout.inc( 1) end),
                           awful.button({ }, 3, function () awful.layout.inc(-1) end),
                           awful.button({ }, 4, function () awful.layout.inc( 1) end),
                           awful.button({ }, 5, function () awful.layout.inc(-1) end)))
    -- Create a taglist widget
    s.mytaglist = awful.widget.taglist {
        screen  = s,
        filter  = awful.widget.taglist.filter.all,
        buttons = taglist_buttons,

        style   = {
            shape = function(cr, width, height)
           gears.shape.powerline (cr, width, height, -10)
        end
        },
        layout   = {
            spacing_widget = {
                shape = function(cr, width, height)
                    gears.shape.powerline (cr, width, height, -10)
                end,
            },
            layout  = wibox.layout.fixed.horizontal
        },
        widget_template = {
            {
                {
                    {
                        {
                            id     = 'icon_role',
                            widget = wibox.widget.imagebox,
                        },
                        widget  = wibox.container.margin,
                    },
                    layout = wibox.layout.fixed.horizontal,
                },
                left  = 0,
                right = 0,
                widget = wibox.container.margin
            },
            id     = 'background_role',
            widget = wibox.container.background,
        },
    }

    s.mytasklist = awful.widget.tasklist {
        screen  = s,
        filter  = awful.widget.tasklist.filter.currenttags,
        buttons = tasklist_buttons,
        style = {
            tasklist_disable_icon = true
        }
    }

    -- Create the wibox
    --[ 
    s.mywibox = awful.wibar({
        position = "top",
        screen = s,
        alight = 'right',
        -- width = 1000
    })

    -- Add widgets to the wibox
    s.mywibox:setup {
        layout = wibox.layout.align.horizontal,
        { -- Left widgets
            layout = wibox.layout.fixed.horizontal,
            s.mytaglist,
            s.mylayoutbox,
            s.mypromptbox,
        },
        s.mytasklist, -- Middle widget
        { -- Right widgets
            wibox.widget.systray(),
            layout = wibox.layout.fixed.horizontal,
            beautiful.keyboardlayout,
            beautiful.volume,
            beautiful.bat,
            beautiful.clock,
        },
    }
    --]
end)
-- }}}

-- {{{ Mouse bindings
root.buttons(gears.table.join(
    awful.button({ }, 3, function () mymainmenu:toggle() end),
    awful.button({ }, 4, awful.tag.viewnext),
    awful.button({ }, 5, awful.tag.viewprev)
))
-- }}}

-- {{{ Key bindings
globalkeys = gears.table.join(
    awful.key({ modkey,           }, "s",      hotkeys_popup.show_help,
              {description="show help", group="hotkeys"}),
    awful.key({ modkey, "Shift" }, "[",   awful.tag.viewprev,
              {description = "view previous", group = "tag"}),
    awful.key({ modkey, "Shift" }, "]",  awful.tag.viewnext,
              {description = "view next", group = "tag"}),

    awful.key({ modkey,           }, "q", function () mymainmenu:show() end,
              {description = "show main menu", group = "hotkeys"}),

     awful.key({ modkey,           }, "]",
        function ()
            awful.client.focus.byidx( 1)
        end,
        {description = "focus next by index", group = "client"}
    ),
    awful.key({ modkey,           }, "[",
        function ()
            awful.client.focus.byidx(-1)
        end,
        {description = "focus previous by index", group = "client"}
    ),
    -- By direction client focus
    awful.key({ modkey }, "down",
        function()
            awful.client.focus.global_bydirection("down")
            if client.focus then client.focus:raise() end
        end,
        {description = "focus down", group = "client"}),
    awful.key({ modkey }, "up",
        function()
            awful.client.focus.global_bydirection("up")
            if client.focus then client.focus:raise() end
        end,
        {description = "focus up", group = "client"}),
    awful.key({ modkey }, "left",
        function()
            awful.client.focus.global_bydirection("left")
            if client.focus then client.focus:raise() end
        end,
        {description = "focus left", group = "client"}),
    awful.key({ modkey }, "right",
        function()
            awful.client.focus.global_bydirection("right")
            if client.focus then client.focus:raise() end
        end,
        {description = "focus right", group = "client"}),

    awful.key({ modkey, "Control" }, "space",  awful.client.floating.toggl,
        {description = "toggle floating", group = "client"}),

    -- By direction vim like
    awful.key({ modkey }, "j",
        function()
            awful.client.focus.global_bydirection("down")
            if client.focus then client.focus:raise() end
        end,
        {description = "focus down", group = "client"}),
    awful.key({ modkey }, "k",
        function()
            awful.client.focus.global_bydirection("up")
            if client.focus then client.focus:raise() end
        end,
        {description = "focus up", group = "client"}),
    awful.key({ modkey }, "h",
        function()
            awful.client.focus.global_bydirection("left")
            if client.focus then client.focus:raise() end
        end,
        {description = "focus left", group = "client"}),
    awful.key({ modkey }, "l",
        function()
            awful.client.focus.global_bydirection("right")
            if client.focus then client.focus:raise() end
        end,
        {description = "focus right", group = "client"}),



    -- Layout manipulation
    awful.key({ modkey, "Control"   }, "]", function () awful.client.swap.byidx(  1)    end,
              {description = "swap with next client by index", group = "client"}),
    awful.key({ modkey, "Control"   }, "[", function () awful.client.swap.byidx( -1)    end,
              {description = "swap with previous client by index", group = "client"}),
    awful.key({ modkey,           }, "u", awful.client.urgent.jumpto,
              {description = "jump to urgent client", group = "client"}),
    awful.key({ modkey,           }, "Tab",
        function ()
            awful.client.focus.history.previous()
            if client.focus then
                client.focus:raise()
            end
        end,
        {description = "go back", group = "client"}),

    -- Standard program
    awful.key({ modkey,           }, "`", function () awful.spawn(terminal) end,
              {description = "open a terminal", group = "hotkeys"}),
    awful.key({ modkey,           }, "/", function () awful.spawn(browser) end,
              {description = "open a browser", group = "hotkeys"}),
    awful.key({ modkey, "Control" }, "r", awesome.restart,
              {description = "reload awesome", group = "hotkeys"}),

    awful.key({ modkey, "Shift"   }, "Left",     function () awful.tag.incmwfact( 0.05)          end,
              {description = "increase master width factor", group = "client"}),
    awful.key({ modkey, "Shift"   }, "Right",     function () awful.tag.incmwfact(-0.05)          end,
              {description = "decrease master width factor", group = "client"}),
    awful.key({ modkey, "Shift"   }, "Down",     function () awful.tag.incmfact( 0.05)          end,
              {description = "increase master height factor", group = "client"}),
    awful.key({ modkey, "Shift"   }, "Up",     function () awful.tag.incmhfact(-0.05)          end,
              {description = "decrease master height factor", group = "client"}),
    awful.key({ modkey,           }, "space", function () awful.layout.inc( 1)                end,
              {description = "next layout", group = "client"}),
    awful.key({ modkey, "Shift"   }, "space", function () awful.layout.inc(-1)                end,
              {description = "previous layout", group = "client"}),

    awful.key({ modkey, "Control" }, "n",
              function ()
                  local c = awful.client.restore()
                  -- Focus restored client
                  if c then
                    c:emit_signal(
                        "request::activate", "key.unminimize", {raise = true}
                    )
                  end
              end,
              {description = "restore minimized", group = "client"}),

    -- Prompt
    awful.key({ modkey },            "\\",
              function () awful.spawn("rofi -show combi") end,
              -- function () awful.screen.focused().mypromptbox:run() end,
              {description = "run prompt", group = "hotkeys"}),

    awful.key({ modkey, "Shift" }, "p", function ()
                    awful.screen.connect_for_each_screen(function(s)
                        if s.mywibox.visible == false then
                            s.mywibox.visible = true
                        else
                            s.mywibox.visible = false
                        end
                    end)
                end,
              {description = "toggle panel", group = "hotkeys"}),
    awful.key({ modkey }, "x",
              function ()
                  awful.prompt.run {
                    prompt       = "Run Lua code: ",
                    textbox      = awful.screen.focused().mypromptbox.widget,
                    exe_callback = awful.util.eval,
                    history_path = awful.util.get_cache_dir() .. "/history_eval"
                  }
              end,
              {description = "lua execute prompt", group = "hotkeys"}),
    -- Menubar
    awful.key({ modkey }, "p", function() menubar.show() end,
              {description = "show the menubar", group = "hotkeys"}),

    -- screen locker
    awful.key({ modkey, "Shift"}, "l", function () awful.spawn("physlock") end,
              {description = "lock screen", group = "hotkeys"}),

    awful.key({ modkey }, "e", function () awful.spawn("rofi -show emoji -modi emoji") end,
              {description = "emoji catalogue", group = "hotkeys"}),

    awful.key({ modkey }, "f", function() awful.spawn("Thunar") end,
              {description = "run filemanager", group = "hotkeys"}),
    awful.key({ modkey }, "0", function()
                    awful.spawn.with_shell("sleep 0.5 && scrot /tmp/screenshot-$(date +%F_%T).png -s -e 'xclip -selection c -t image/png < $f'")
                end,
              {description = "run filemanager", group = "hotkeys"}),

    awful.key({ modkey,           }, "i", function() awful.util.spawn(terminal .. " -e vim notes/notes.org") end,
              {description = "toggle notes", group = "hotkeys"}),
    awful.key({ modkey }, ".", function()
                    local c = client.focus
                    if c ~= nill and c.name == "VVVVVVVVVVVVV" then
                        c:kill()
                    else
                        awful.spawn(terminal.." -e ipython", {name = 'VVVVVVVVVVVVV'})
                    end
                end,
              {description = "ipython in terminal", group = "hotkeys"}),
    -- brightness
    awful.key({ }, "XF86MonBrightnessUp", function () awful.spawn("xbacklight -inc 10") end,
              {description = "brightness +", group = "hotkeys"}),

    awful.key({ }, "XF86MonBrightnessDown", function () awful.spawn("xbacklight -dec 10") end,
              {description = "brithness -", group = "hotkeys"}),
    -- volume control
    awful.key({ }, "XF86AudioRaiseVolume", function ()
                    awful.spawn("amixer -q -D pulse sset Master 10%+ && sleep 0.2")
                    beautiful.volume.update()
                end,
              {description = "volume +", group = "hotkeys"}),
    awful.key({ }, "XF86AudioLowerVolume", function ()
                    awful.spawn("amixer -q -D pulse sset Master 10%- && sleep 0.2")
                    beautiful.volume.update()
                end,
              {description = "volume -", group = "hotkeys"}),
    awful.key({ }, "XF86AudioMute", function ()
                    awful.spawn("amixer -q sset Master toggle && sleep 0.2")
                    beautiful.volume.update()
                end,
              {description = "mute", group = "hotkeys"})
)



clientkeys = gears.table.join(
    awful.key({ modkey,           }, "Return",
        function (c)
            c.fullscreen = not c.fullscreen
            c:raise()
        end,
        {description = "toggle fullscreen", group = "client"}),
    awful.key({ modkey,    }, "w",      function (c) c:kill()                         end,
              {description = "close", group = "client"}),
    awful.key({ modkey, "Shift"   }, "Return", function (c) c:swap(awful.client.getmaster()) end,
              {description = "move to master", group = "client"}),
    awful.key({ modkey,           }, "o",      function (c) c:move_to_screen()               end,
              {description = "move to screen", group = "client"}),
    awful.key({ modkey,  "Shift"  }, "t",      function (c) c.ontop = not c.ontop            end,
              {description = "toggle keep on top", group = "client"}),
    awful.key({ modkey,           }, "n",
        function (c)
            -- The client currently has the input focus, so it cannot be
            -- minimized, since minimized clients can't have the focus.
            c.minimized = true
        end ,
        {description = "minimize", group = "client"}),
    awful.key({ modkey,           }, "m",
        function (c)
            c.maximized = not c.maximized
            c:raise()
        end ,
        {description = "(un)maximize", group = "client"}),

    -- Dynamic tagging
    awful.key({ modkey, "Shift" }, "n", function () lain.util.add_tag() end,
              {description = "add new tag", group = "hotkeys"})
)

-- Bind all key numbers to tags.
-- Be careful: we use keycodes to make it work on any keyboard layout.
-- This should map on the top row of your keyboard, usually 1 to 9.
for i = 1, 5 do
    globalkeys = gears.table.join(globalkeys,
        -- View tag only.
        awful.key({ modkey }, "#" .. i + 9,
                  function ()
                        local screen = awful.screen.focused()
                        local tag = screen.tags[i]
                        if tag then
                           tag:view_only()
                        end
                  end,
                  {description = "view tag #"..i, group = "tag"}),
        -- Toggle tag display.
        awful.key({ modkey, "Control" }, "#" .. i + 9,
                  function ()
                      local screen = awful.screen.focused()
                      local tag = screen.tags[i]
                      if tag then
                         awful.tag.viewtoggle(tag)
                      end
                  end,
                  {description = "toggle #" .. i, group = "tag"}),
        -- Move client to tag.
        awful.key({ modkey, "Shift" }, "#" .. i + 9,
                  function ()
                      if client.focus then
                          local tag = client.focus.screen.tags[i]
                          if tag then
                              client.focus:move_to_tag(tag)
                          end
                     end
                  end,
                  {description = "client to #"..i, group = "tag"})
    )
end

clientbuttons = gears.table.join(
    awful.button({ }, 1, function (c)
        c:emit_signal("request::activate", "mouse_click", {raise = true})
    end),
    awful.button({ modkey }, 1, function (c)
        c:emit_signal("request::activate", "mouse_click", {raise = true})
        awful.mouse.client.move(c)
    end),
    awful.button({ modkey }, 3, function (c)
        c:emit_signal("request::activate", "mouse_click", {raise = true})
        awful.mouse.client.resize(c)
    end)
)

-- Set keys
root.keys(globalkeys)
-- }}}

-- {{{ Rules
-- Rules to apply to new clients (through the "manage" signal).
awful.rules.rules = {
    -- All clients will match this rule.
    { rule = { },
      properties = {
                     border_width = beautiful.border_width,
                     border_color = beautiful.border_normal,
                     focus = awful.client.focus.filter,
                     raise = true,
                     keys = clientkeys,
                     buttons = clientbuttons,
                     screen = awful.screen.preferred,
                     placement = awful.placement.no_overlap+awful.placement.no_offscreen
     }
    },

    -- Floating clients.
    { rule_any = {
        class = {
          "Arandr",
          "Blueman-manager",
          "Gpick",
          "Kruler",
          "MessageWin",  -- kalarm.
          "Sxiv",
          "Tor Browser", -- Needs a fixed window size to avoid fingerprinting by screen size.
          "Wpa_gui",
          "veromix",
          "xtightvncviewer"},
        role = {
          "AlarmWindow",  -- Thunderbird's calendar.
          "ConfigManager",  -- Thunderbird's about:config.
          "pop-up",       -- e.g. Google Chrome's (detached) Developer Tools.
        }
      }, properties = { floating = true }
    },
    -- Add titlebars to normal clients and dialogs
    {
        rule_any = {type = { "normal", "dialog" }},
        properties = { titlebars_enabled = true }
    },
    {
        rule_any = {
           class  = {
                "code-oss",
                --"discord",
                "TelegramDesktop",
                "firefox",
                "Thunderbird",
                "discord"
            },
        },
        properties = { titlebars_enabled = false }
    }, 

    -- Set Firefox to always map on the tag named "2" on screen 1.
    { rule = { class = "Firefox" },
      properties = { screen = 1, tag = "2" }
    },
    {
        rule_any = { 
            class = {"Thunderbird", "discord", "TelegramDesktop", "protonmail-bridge"}, 
        },
        properties = { screen = 1, tag = "3" }
    }
}
-- }}}

-- {{{ Signals
-- Signal function to execute when a new client appears.
client.connect_signal("manage", function (c)
    -- Set the windows at the slave,
    -- i.e. put it at the end of others instead of setting it master.
    -- if not awesome.startup then awful.client.setslave(c) end

    if awesome.startup
      and not c.size_hints.user_position
      and not c.size_hints.program_position then
        -- Prevent clients from being unreachable after screen count changes.
        awful.placement.no_offscreen(c)
    end

    -- c.shape = gears.shape.rounded_rect
end)

-- Add a titlebar if titlebars_enabled is set to true in the rules.
client.connect_signal("request::titlebars", function(c)
    -- buttons for the titlebar
    local buttons = gears.table.join(
        awful.button({ }, 1, function()
            c:emit_signal("request::activate", "titlebar", {raise = true})
            awful.mouse.client.move(c)
        end),
        awful.button({ }, 3, function()
            c:emit_signal("request::activate", "titlebar", {raise = true})
            awful.mouse.client.resize(c)
        end)
    )

    local titlebar = awful.titlebar(c):setup {
        { -- Left
            buttons = buttons,
            layout  = wibox.layout.fixed.horizontal
        },
        { -- Middle
            { -- Title
                align  = "right",
                -- widget = awful.titlebar.widget.titlewidget(c),
                widget = wibox.widget.textbox,
                text = utf8.char(0xf7b6).." "
            },
            buttons = buttons,
            layout  = wibox.layout.flex.horizontal
        },
        { -- Right
            awful.titlebar.widget.closebutton    (c),
            awful.titlebar.widget.floatingbutton (c),
            awful.titlebar.widget.ontopbutton    (c),
            layout = wibox.layout.fixed.horizontal()
        },
        layout = wibox.layout.align.horizontal
    }
end)

-- client.connect_signal("focus", function(c) c.border_color = beautiful.border_focus end)
-- client.connect_signal("unfocus", function(c) c.border_color = beautiful.border_normal end)
-- }}}

-- Hotkeys Help

local extra_keys = {
    ['vim'] = {
        {modifiers = {}, keys = {
            ['=']="auto format", y="yank", d="delete", c="change", ["!"]='external filter', ['&lt;']='unindent',
            ['~']="toggle case", q=". record macro", r=". replace char", u="undo", p="paste after",
            gg="go to the top of file", gf="open file under cursor", x="delete char", v="visual mode",
            m=". set mark", ['.']="repeat command", ["@"]='. play macro', ["&amp;"]='repeat :s', Q='ex mode',
            Y='yank line', U='undo line', P='paste before cursor', D='delete to EOL', J='join lines',
            K='help', [':']='ex cmd line', ['"']='. register spec', ZZ='quit and save', ZQ='quit discarding changes',
            X='back-delete', V='visual lines selection', ['&gt;']='indent',
        }},
        {modifiers = {"Ctrl"}, keys = {
            -- command
            w=". window operations", r="redo", ["["]="normal mode", a="increase number",
            x="decrease number", g="file/cursor info", z="suspend", c="cancel/normal mode",
            v="visual block selection", e="scroll line up", y="scroll line down",
    }}},
    ["vim motion"] = {
        {modifiers = {}, keys = {
            -- motion
            ['`']="goto mark", ['0']='"hard" BOL', ['-']="prev line", w="next word", e="end word", ['[']=". misc",
            [']']=". misc", ["'"]=". goto mk. BOL", b="prev word", ["|"]='BOL/goto col', ["$"]='EOL',
            ["%"]='goto matching bracket', ["^"]='"soft" BOL', ["+"]='next line', W='next WORD', E='end WORD',
            ['{']="paragraph begin", ['}']="paragraph end", G='EOF/goto line', H='move cursor to screen top',
            M='move cursor to screen middle', L='move cursor to screen bottom', B='prev WORD',
            zt="scroll cursor to the top", zz="scroll cursor to the center", zb="scroll cursor to the bottom",
        }},
        {modifiers = {"Ctrl"}, keys = {
            u="half page up", d="half page down", b="page up", f="page down", o="prev mark"
    }}},
    ['vim find'] = {
        {modifiers = {}, keys = {
            -- find
            [';']="repeat t/T/f/F", [',']="reverse t/T/f/F", ['/']=". find", ['?']='. reverse find',
            n="next search match", N='prev search match', f=". find char", F='. reverse find char',
            t=". 'till char", T=". reverse 'till char", ["*"]='find word under cursor', ["#"]='reverse find under cursor',
    }}},
    ['vim insert'] = {
        {modifiers = {}, keys = {
            i="insert mode", o="new line below", a="append", s="subst char", R='replace mode', I='insert at BOL',
            O='new line above', A='append at EOL', S='subst line', C='change to EOL',
    }}},
    ['vim jedi'] = {
        {modifiers = {"leader"}, keys = {
            a="goto assignments", d="goto definition", s="show docs", e="show usage"
    }}},
    ['vimz'] = {
        {modifiers = {'leader'}, keys = {
            n="line number toggle", q="delete buffer", s="spell cheker", w="quick save", t="run pytest",
            ['[ ]']="prev/next buffer", ['1..5']="1 .. 5 buffer", r="slimux repl", f="explore buffers",
            z="goyo focus", b="nerdtree", x="toggle ale", o="argwrap"
        }},
        {modifiers = {'Crtl'}, keys = {
            ['j/k/l/h']="navigate split", p="open file"
    }}},
    -- ipythpon and jupyter!
    ['ipython'] = {
        {modifiers = {}, keys = {
            ["%history"]="show prev commands", ["%load"]="load code", ["%load_ext"]="load extension",
            ["%pdb"]="use pdb", ["%pdef"]="print signature", ["%pdoc"]="print docstring", ["%pinfo"]="object info",
            ["%pprint"]="toggle pretty print", ["%prun"]="code profiler", ["%who"]="show all variables",
            ["%time"]="execution time", ["%timeit"]="[-n -r] exec time",
            H="show shortcuts", A="insert above", B="insert below", X="cut cell", C="copy cell", V="paste cell below",
            Z="undo delete cell", Y="cell type to code", M="cell type to markdown", P="command palette",
            ["II"]="interupt kernel", ["00"]="restart kernel"
        }},
        {modifiers = {"Ctrl"}, keys = {
            s="save notebook", ["Enter"]="run cell"
        }},
        {modifiers = {"Shift"}, keys = {
            V="paste cell above",
            ["Enter"]="run cell and move"
    }}},
    ["tmux"] = {
        {modifiers = {'leader'}, keys = {
            ["|"]="split vertically", ["-"]="split horizontally", x="kill tab", c="create tab",
            z="toggle focus", ["1..9"]="goto 1..9 tab", ["?"]="show shortcuts", ["[ ]"]="resize pane left/right"
    }}},
    ["hotkeysz"] = {
        {modifiers = {modkey}, keys = {d="zeal docstrings"}}
    }
}

hotkeys_popup.widget.add_hotkeys(extra_keys)
