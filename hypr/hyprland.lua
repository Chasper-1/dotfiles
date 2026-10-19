-- —— MONITORS ————————————————————————————————————————————————————————————————————————————————————

hl.monitor({
    output = "DP-3",
    mode = "1920x1080@165",
    position = "0x0",
    scale = "1",
    reserved_area = { top = 0, bottom = 26, left = 0, right = 0 },
})

-- —— MY PROGRAMS —————————————————————————————————————————————————————————————————————————————————

local zed = "zeditor"
local terminal = "kitty --start-as minimized"
local fileManager = "thunar"
local menu = "rofi -show drun"
local menu_calc = "rofi -show calc -theme-str 'listview { columns: 1; }' | wl-copy"
local menu_clip = "~/.config/rofi/rofi-clip.py"
local menu_galery = "~/.config/rofi/rofi-galery.sh"
local menu_translate = "~/.config/rofi/rofi-trans.py"
local menu_power = "~/.config/rofi/rofi-power.sh"
local keepass = "cat -u ~/Документы/Secrets/Mypass-local.txt | wl-copy -n && ~/Документы/code/скрипты/timedead.sh & ~/.config/rofi/rofi-kpxc.sh"
local cleaner = "~/.local/bin/cleaner"

-- —— AUTOSTART ———————————————————————————————————————————————————————————————————————————————————

hl.on("hyprland.start", function ()

    -- —— System settings —————————————————————————————————————————————————————
    hl.exec_cmd("dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP")
    hl.exec_cmd("systemctl --user import-environment WAYLAND_DISPLAY XDG_CURRENT_DESKTOP")
    hl.exec_cmd("/usr/lib/xdg-desktop-portal")
    hl.exec_cmd("/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1")

    -- —— Cliphist ————————————————————————————————————————————————————————————
    hl.exec_cmd("wl-paste --type text --watch cliphist store # Stores only text data")
    hl.exec_cmd("wl-paste --type image --watch cliphist store # Stores only image data")

    -- —— Utilits —————————————————————————————————————————————————————————————
    hl.exec_cmd("awww-daemon & waybar & mako & hypridle")

    -- —— Programs ————————————————————————————————————————————————————————————
    hl.exec_cmd("[workspace 1 silent] zen-browser")
    hl.exec_cmd("[workspace special:terminal silent]" .. terminal)
end)

-- —— ENVIRONMENT VARIABLES ———————————————————————————————————————————————————————————————————————

hl.env("XCURSOR_THEME", "GoogleDot-White")
hl.env("XCURSOR_SIZE", "20")
hl.env("HYPRCURSOR_SIZE", "20")
hl.env("TERMINAL", "kitty")

-- —— PERMISSIONS —————————————————————————————————————————————————————————————————————————————————


-- See https://wiki.hypr.land/Configuring/Permissions/
-- Please note permission changes here require a Hyprland restart and are not applied on-the-fly
-- for security reasons

-- ecosystem {
--   enforce_permissions = 1
-- }

-- permission = /usr/(bin|local/bin)/grim, screencopy, allow
-- permission = /usr/(lib|libexec|lib64)/xdg-desktop-portal-hyprland, screencopy, allow
-- permission = /usr/(bin|local/bin)/hyprpm, plugin, allow

-- Refer to https://wiki.hypr.land/Configuring/Variables/

-- https://wiki.hypr.land/Configuring/Variables/general
-- —— CURVE ———————————————————————————————————————————————————————————————————————————————————————

hl.curve("easeOutQuint", { type = "bezier", points = { { 0.23, 1 }, { 0.32, 1 } } })
hl.curve("easeInOutCubic", { type = "bezier", points = { { 0.65, 0.05 }, { 0.36, 1 } } })
hl.curve("linear", { type = "bezier", points = { { 0, 0 }, { 1, 1 } } })
hl.curve("almostLinear", { type = "bezier", points = { { 0.5, 0.5 }, { 0.75, 1 } } })
hl.curve("quick", { type = "bezier", points = { { 0.15, 0 }, { 0.1, 1 } } })
hl.curve("nk", { type = "bezier", points = { { 0, 1 }, { 1, 1 } } })   -- My curve settings

-- —— ANIMATION ———————————————————————————————————————————————————————————————————————————————————

hl.animation({ leaf = "global", enabled = true, speed = 10, bezier = "default",})
hl.animation({ leaf = "border", enabled = true, speed = 5.39, bezier = "easeOutQuint",})
hl.animation({ leaf = "windows", enabled = true, speed = 4.79, bezier = "easeOutQuint", style = "slide",})
hl.animation({ leaf = "windowsIn", enabled = true, speed = 4.1, bezier = "easeOutQuint", style = "slide",})
hl.animation({ leaf = "windowsOut", enabled = true, speed = 1.49, bezier = "linear", style = "popin",})
hl.animation({ leaf = "windowsMove", enabled = true, speed = 2.49, bezier = "nk",})
hl.animation({ leaf = "fadeIn", enabled = true, speed = 1.73, bezier = "almostLinear",})
hl.animation({ leaf = "fadeOut", enabled = true, speed = 1.46, bezier = "almostLinear",})
hl.animation({ leaf = "fade", enabled = true, speed = 3.03, bezier = "quick",})
hl.animation({ leaf = "layers", enabled = true, speed = 3.81, bezier = "easeOutQuint",})
hl.animation({ leaf = "layersIn", enabled = true, speed = 3.5, bezier = "easeOutQuint", style = "slidefade",})
hl.animation({ leaf = "layersOut", enabled = true, speed = 1.5, bezier = "linear", style = "popin",})
hl.animation({ leaf = "fadeLayersIn", enabled = true, speed = 1.79, bezier = "almostLinear",})
hl.animation({ leaf = "fadeLayersOut", enabled = true, speed = 1.39, bezier = "almostLinear",})
hl.animation({ leaf = "workspaces", enabled = true, speed = 2.54, bezier = "nk",})
hl.animation({ leaf = "workspacesIn", enabled = true, speed = 1.81, bezier = "nk", style = "slidefade",})
hl.animation({ leaf = "workspacesOut", enabled = true, speed = 2.14, bezier = "nk", style = "slide",})
hl.animation({ leaf = "specialWorkspaceIn", enabled = true, speed = 1.81, bezier = "nk", style = "slidefadevert",})
hl.animation({ leaf = "specialWorkspaceOut", enabled = true, speed = 2.14, bezier = "linear", style = "slidevert",})
hl.animation({ leaf = "zoomFactor", enabled = true, speed = 7, bezier = "quick",})

-- —— RULES HYPRLAND ——————————————————————————————————————————————————————————————————————————————

-- —— Workspace ———————————————————————————————————————————————————————————————
hl.workspace_rule({ workspace = "f[1]", gaps_out = 0, gaps_in = 0 })

-- —— Create special workspace ———————————————————————————————————————————————————————
hl.workspace_rule({ workspace = "special:music",})
hl.workspace_rule({ workspace = "special:terminal",})
hl.workspace_rule({ workspace = "special:games",})
hl.workspace_rule({ workspace = "special:easyeffects",})


-- —— Windows —————————————————————————————————————————————————————————————————
hl.window_rule({
    match = { float = true, class = "(clipse)", },
})

hl.window_rule({
    match = { class = "(clipse)", },
    size = "622 652",
})

hl.window_rule({
    match = { class = "io.github.elyprismlauncher.ElyPrismLauncher", },
    center = true,
})

hl.window_rule({
    match = { class = "io.github.elyprismlauncher.ElyPrismLauncher", title = ".*", },
    float = true,
})

hl.window_rule({
    match = { class = "io.github.elyprismlauncher.ElyPrismLauncher", },
    size = "1200 600",
})

hl.window_rule({
    match = { class = "swayimg", },
    float = true,
})

hl.window_rule({
    match = { class = "org.pulseaudio.pavucontrol", },
    size = "700 500",
    float = true,
})

hl.window_rule({
    match = { class = "flameshot", },
    float = true,
})

hl.window_rule({
    match = { class = "PortProton", },
    float = true,
})

hl.window_rule({
    match = { class = "thunar", title = "^(Переименовать).*", },
    float = true,
    size = "600 100",
})

-- —— Start window in workspace ———————————————————————————
hl.window_rule({
    match = { class = "md.obsidian.Obsidian", },
    workspace = "6",
})

hl.window_rule({
    match = { class = "zen", },
    workspace = "1",
})

hl.window_rule({
    match = { class = "dev.zed.Zed", },
    workspace = "10",
})

hl.window_rule({
    match = { class = "spotify", },
    workspace = "special:music silent",
})

hl.window_rule({
    match = { class = "YandexMusic", },
    workspace = "special:music silent",
})

hl.window_rule({
    match = { class = "kitty", },
    workspace = "special:terminal",
})

hl.window_rule({
    match = { class = "com.github.wwmm.easyeffects",},
    workspace = "special:easyeffects silent",
})

-- —— Layer ———————————————————————————————————————————————————————————————————
--hl.layer_rule({
--    match = { namespace = "waybar", },
--    blur = true,
--    ignore_alpha = 0,
--    })

-- hl.layer_rule({
--    match = { namespace = "rofi", },
--    blur = true,
--    ignore_alpha = 0,
--})

-- ——
hl.gesture({
    fingers = 3,
    direction = "horizontal",
    action = "workspace",
})
hl.device({
    name = "epic-mouse-v1",
    sensitivity = 0,
})

-- —— HOTKEYS —————————————————————————————————————————————————————————————————————————————————

-- —— Keybinds ————————————————————————————————————————————————————————————————

-- —— Basic ———————————————————————————————————————————————
hl.bind("ALT + Q", hl.dsp.exec_cmd(terminal))
hl.bind("SUPER + C", hl.dsp.window.close())
hl.bind("SUPER + SHIFT + R", hl.dsp.window.kill())
hl.bind("SUPER + M", hl.dsp.exit())
hl.bind("SUPER + E", hl.dsp.exec_cmd(fileManager))
hl.bind("SUPER + SHIFT + V", hl.dsp.window.float({ action = "toggle" }))
hl.bind("SUPER + P", hl.dsp.window.pseudo())
hl.bind("SUPER + F11", hl.dsp.window.fullscreen({ mode = "maximized", action = "toggle" }))
hl.bind("SUPER + SHIFT + F11", hl.dsp.window.fullscreen({ mode = "fullscreen", action = "toggle" }))

-- —— Basic utilits ———————————————————————————————————————
hl.bind("SUPER + U", hl.dsp.exec_cmd("hyprpicker -a -f rgb"))
hl.bind("SUPER + SHIFT + P", hl.dsp.exec_cmd(keepass))
hl.bind("SUPER + SHIFT + End", hl.dsp.exec_cmd("~/Документы/code/скрипты/safe_shutdown.sh"))
hl.bind("CTRL + ALT + D", hl.dsp.exec_cmd(cleaner))
hl.bind("Print", hl.dsp.exec_cmd("flameshot gui"))
hl.bind("SHIFT + Print", hl.dsp.exec_cmd("flameshot screen"))

-- —— Rofi menu ———————————————————————————————————————————
hl.bind("SUPER + D", hl.dsp.exec_cmd(menu))
hl.bind("SUPER + B", hl.dsp.exec_cmd(menu_galery))
hl.bind("SUPER + V", hl.dsp.exec_cmd(menu_clip))
hl.bind("SUPER + A", hl.dsp.exec_cmd(menu_translate))
hl.bind("SUPER + CTRL + A", hl.dsp.exec_cmd(menu_translate .. " --copy"))
hl.bind("SUPER + SHIFT + D", hl.dsp.exec_cmd(menu_calc))
hl.bind("SUPER + End", hl.dsp.exec_cmd(menu_power))

-- —— Start programs ——————————————————————————————————————
hl.bind("SUPER + Z", hl.dsp.exec_cmd(zed))

-- —— Move window focus ———————————————————————————————————
hl.bind("ALT + left", hl.dsp.focus({ direction = "left" }))
hl.bind("ALT + right", hl.dsp.focus({ direction = "right" }))
hl.bind("ALT + up", hl.dsp.focus({ direction = "up" }))
hl.bind("ALT + down", hl.dsp.focus({ direction = "down" }))

-- —— Move window position ————————————————————————————————
hl.bind("SHIFT + left", hl.dsp.window.move({ direction = "l" }))
hl.bind("SHIFT + right", hl.dsp.window.move({ direction = "r" }))
hl.bind("SHIFT + up", hl.dsp.window.move({ direction = "u" }))
hl.bind("SHIFT + down", hl.dsp.window.move({ direction = "d" }))

-- —— WORKSPACES ——————————————————————————————————————————————————————————————————————————————————

-- —— Focus 1-10 ——————————————————————————————————————————————————————————————
hl.bind("SUPER + 1", hl.dsp.focus({ workspace = 1 }))
hl.bind("SUPER + 2", hl.dsp.focus({ workspace = 2 }))
hl.bind("SUPER + 3", hl.dsp.focus({ workspace = 3 }))
hl.bind("SUPER + 4", hl.dsp.focus({ workspace = 4 }))
hl.bind("SUPER + 5", hl.dsp.focus({ workspace = 5 }))
hl.bind("SUPER + 6", hl.dsp.focus({ workspace = 6 }))
hl.bind("SUPER + 7", hl.dsp.focus({ workspace = 7 }))
hl.bind("SUPER + 8", hl.dsp.focus({ workspace = 8 }))
hl.bind("SUPER + 9", hl.dsp.focus({ workspace = 9 }))
hl.bind("SUPER + 0", hl.dsp.focus({ workspace = 10 }))

-- —— Focus 11-20 —————————————————————————————————————————————————————————————
hl.bind("SUPER + CTRL + 1", hl.dsp.focus({ workspace = 11 }))
hl.bind("SUPER + CTRL + 2", hl.dsp.focus({ workspace = 12 }))
hl.bind("SUPER + CTRL + 3", hl.dsp.focus({ workspace = 13 }))
hl.bind("SUPER + CTRL + 4", hl.dsp.focus({ workspace = 14 }))
hl.bind("SUPER + CTRL + 5", hl.dsp.focus({ workspace = 15 }))
hl.bind("SUPER + CTRL + 6", hl.dsp.focus({ workspace = 16 }))
hl.bind("SUPER + CTRL + 7", hl.dsp.focus({ workspace = 17 }))
hl.bind("SUPER + CTRL + 8", hl.dsp.focus({ workspace = 18 }))
hl.bind("SUPER + CTRL + 9", hl.dsp.focus({ workspace = 19 }))
hl.bind("SUPER + CTRL + 0", hl.dsp.focus({ workspace = 20 }))

-- —— Focus input —————————————————————————————————————————————————————————————

-- —— Mouse ———————————————————————————————————————————————
hl.bind("SUPER + mouse_down", hl.dsp.focus({ workspace = "e+1" }))
hl.bind("SUPER + mouse_up", hl.dsp.focus({ workspace = "e-1" }))

-- —— Keys ————————————————————————————————————————————————
hl.bind("SUPER + left", hl.dsp.focus({ workspace = "e-1" }))
hl.bind("SUPER + right", hl.dsp.focus({ workspace = "e+1" }))

-- —— Move 1-10 ———————————————————————————————————————————————————————————————
hl.bind("SUPER + SHIFT + 1", hl.dsp.window.move({ workspace = 1 }))
hl.bind("SUPER + SHIFT + 2", hl.dsp.window.move({ workspace = 2 }))
hl.bind("SUPER + SHIFT + 3", hl.dsp.window.move({ workspace = 3 }))
hl.bind("SUPER + SHIFT + 4", hl.dsp.window.move({ workspace = 4 }))
hl.bind("SUPER + SHIFT + 5", hl.dsp.window.move({ workspace = 5 }))
hl.bind("SUPER + SHIFT + 6", hl.dsp.window.move({ workspace = 6 }))
hl.bind("SUPER + SHIFT + 7", hl.dsp.window.move({ workspace = 7 }))
hl.bind("SUPER + SHIFT + 8", hl.dsp.window.move({ workspace = 8 }))
hl.bind("SUPER + SHIFT + 9", hl.dsp.window.move({ workspace = 9 }))
hl.bind("SUPER + SHIFT + 0", hl.dsp.window.move({ workspace = 10 }))

-- —— Move 11-20 ——————————————————————————————————————————————————————————————
hl.bind("SUPER + CTRL + SHIFT + 1", hl.dsp.window.move({ workspace = 11 }))
hl.bind("SUPER + CTRL + SHIFT + 2", hl.dsp.window.move({ workspace = 12 }))
hl.bind("SUPER + CTRL + SHIFT + 3", hl.dsp.window.move({ workspace = 13 }))
hl.bind("SUPER + CTRL + SHIFT + 4", hl.dsp.window.move({ workspace = 14 }))
hl.bind("SUPER + CTRL + SHIFT + 5", hl.dsp.window.move({ workspace = 15 }))
hl.bind("SUPER + CTRL + SHIFT + 6", hl.dsp.window.move({ workspace = 16 }))
hl.bind("SUPER + CTRL + SHIFT + 7", hl.dsp.window.move({ workspace = 17 }))
hl.bind("SUPER + CTRL + SHIFT + 8", hl.dsp.window.move({ workspace = 18 }))
hl.bind("SUPER + CTRL + SHIFT + 9", hl.dsp.window.move({ workspace = 19 }))
hl.bind("SUPER + CTRL + SHIFT + 0", hl.dsp.window.move({ workspace = 20 }))

-- —— INTERACTION THE WINDOW —————————————————————————————————————————————————————————————————————

-- —— Mouse ———————————————————————————————————————————————————————————————————
hl.bind("SUPER + mouse:272", hl.dsp.window.drag())
hl.bind("SUPER + mouse:273", hl.dsp.window.resize())

-- —— WORKSPACES SPECIAL ——————————————————————————————————————————————————————————————————————————

hl.bind("SUPER + S", hl.dsp.workspace.toggle_special("magic"))
hl.bind("SUPER + SHIFT + S", hl.dsp.window.move({ workspace = "special:magic" }))
hl.bind("SUPER + CTRL + S", hl.dsp.window.move({ workspace = "+0" }))

-- —— Music ———————————————————————————————————————————————
hl.bind("SUPER + X", hl.dsp.workspace.toggle_special("music"))
hl.bind("SUPER + SHIFT + X", hl.dsp.window.move({ workspace = "special:music" }))

-- —— Terminal ————————————————————————————————————————————
hl.bind("SUPER + Q", hl.dsp.workspace.toggle_special("terminal"))
hl.bind("SUPER + SHIFT + Q", hl.dsp.window.move({ workspace = "special:terminal" }))

-- —— Games ———————————————————————————————————————————————
hl.bind("SUPER + G", hl.dsp.workspace.toggle_special("games"))
hl.bind("SUPER + SHIFT + G", hl.dsp.window.move({ workspace = "special:games" }))

-- —— EasyEffects —————————————————————————————————————————
hl.bind("SUPER + H", hl.dsp.workspace.toggle_special("easyeffects"))
hl.bind("SUPER + SHIFT + H", hl.dsp.window.move({ workspace = "special:easyeffects" }))

-- —— HOTKEY VOLUME ———————————————————————————————————————————————————————————————————————————————

-- —— Volume/Microphone ———————————————————————————————————————————————————————
hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd("wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"), { locked = true, repeating = true })
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"), { locked = true, repeating = true })
hl.bind("XF86AudioMute", hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"), { locked = true, repeating = true })
hl.bind("XF86AudioMicMute", hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"), { locked = true, repeating = true })

-- —— Brightness ——————————————————————————————————————————————————————————————
hl.bind("XF86MonBrightnessUp", hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%+"), { locked = true, repeating = true })
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%-"), { locked = true, repeating = true })

-- —— Management playback —————————————————————————————————————————————————————
hl.bind("XF86AudioNext", hl.dsp.exec_cmd("playerctl next"), { locked = true })
hl.bind("XF86AudioPause", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPlay", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPrev", hl.dsp.exec_cmd("playerctl previous"), { locked = true })


hl.config({
    general = {
        gaps_in = 4,
        gaps_out = 10,
        border_size = 2,
        col = {
            active_border = "rgba(d3c6aaff)",
            inactive_border = "rgba(595959aa)",
        },
        resize_on_border = false,
        allow_tearing = false,
        layout = "dwindle",
    },
    decoration = {
        rounding = 10,
        rounding_power = 2,
        active_opacity = 1.0,
        inactive_opacity = 0.9,
        shadow = {
            enabled = true,
            range = 4,
            render_power = 3,
            color = "rgba(1a1a1aee)",
        },
        blur = {
            enabled = true,
            size = 3,
            passes = 1,
            vibrancy = 0.1696,
        },
    },
    animations = {
        enabled = true,
        --        NAME,           X0,   Y0,   X1,   Y1
        --           NAME,                ONOFF, SPEED, CURVE,        [STYLE]
    },

    -- LAYERRULE

    dwindle = {
        --pseudotile = true  Master switch for pseudotiling. Enabling is bound to mainMod + P in the keybinds section below
        preserve_split = true, -- You probably want this
    },
    master = {
        new_status = "master",
    },
    misc = {
        force_default_wallpaper = -1, -- Set to 0 or 1 to disable the anime mascot wallpapers
        disable_hyprland_logo = false, -- If true disables the random hyprland logo / anime girl background. :(
    },

    -- —— INPUT ———————————————————————————————————————————————————————————————————————————————————

    input = {
        kb_layout = "us,ru",
        kb_variant = ",",
        kb_model = "",
        kb_options = "grp:caps_toggle,compose:rctrl",
        kb_rules = "",
        -- Настройки мыши
        sensitivity = 0, -- -1.0 - 1.0, 0 means no modification.
        accel_profile = "flat",
        follow_mouse = 1,
        -- настройка курсора
        touchpad = {
            natural_scroll = false,
        },
    },
    -- Example per-device config
    --
    -- WORKSPACES
    --
    --
    -- KEYBINDINGS
    --
    -- See https://wiki.hypr.land/Configuring/Keywords/
    -- Example binds, see https://wiki.hypr.land/Configuring/Binds/ for more
    --bind = mainMod, J, togglesplit,  dwindle
    --bind = mainMod, Tab, hyprexpo:expo, toggle
    --bind = mainA, right, layoutmsg, focus r
    --bind = mainA, left, layoutmsg, focus l
    -- Move focus with mainMod + arrow keys
    -- Switch workspaces with mainMod + [0-9]
    -- Move active window to a workspace with mainMod + SHIFT + [0-9]
    -- Example special workspace (scratchpad)
    -- Scroll through existing workspaces with mainMod + scroll
    --Move/resize windows with mainMod + LMB/RMB and dragging
    -- Laptop multimedia keys for volume and LCD brightness
    -- Requires playerctl
    --
    -- WINDOWS AND WORKSPACES
    --
    -- See https://wiki.hypr.land/Configuring/Window-Rules/ for more
    -- See https://wiki.hypr.land/Configuring/Workspace-Rules/ for workspace rules
    -- Example windowrule
    --windowrule = float,class:^(kitty),title:^(kitty)
    -- Ignore maximize requests from apps. You'll probably like this.
    --windowrule = suppressevent maximize, class:.*
    -- Fix some dragging issues with XWayland
    --windowrule = nofocus,class:^,title:^,xwayland:1,floating:1,fullscreen:0,pinned:0
})
