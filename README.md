# unix-feelkit

The appearance parts for [unix-toolkit](https://github.com/bluestero/unix-toolkit), as a toolkit
layer: everything that is only about looks, so the toolkit itself stays about work.

| Part | What it gives you |
|---|---|
| `k-bg` | Kitty background picker: live preview, brightness, opacity, accent colours taken from the image |
| `k-theme` | Kitty colour themes with live preview: your short list plus kitty's 400+ |
| `k-icon` | Extra kitty app icons to pick from |
| `k-rofi` | Writes rofi's colours from the kitty theme and background in use |
| kitty accents, centered windows | Prompt, pickers, cursor and selection follow the background; new windows open in the middle |
| GNOME presets | Dash to Panel (one bar) or Dash2Dock, Vitals (+ chip icons), Blur my Shell, rounded corners, no window animations |

The toolkit works without it: rofi and btop just keep their default colours.

Dash to Panel and Dash2Dock both sit on the bottom edge of the screen, so installing both gives
two bars on top of each other. Pick one (`fk install` leaves Dash2Dock unticked when the panel
is already in, and asks once when both are ticked); the other can be added or removed any time.

## Install

You need the toolkit first (see its README), then:

```bash
tk layer add https://github.com/bluestero/unix-feelkit.git   # clones into layers/feelkit, offers to set it up
```

feelkit is set up on its own (the file `standalone`), never by `tk install`:

```bash
fk install            # a tab each for Kitty looks and GNOME looks, then a summary; enter sets it up
fk install kitty-theme   # just that part (fk install ls lists them)
fk uninstall          # remove parts, your own settings put back
```

`tk update` keeps it current (and says when `fk install` has something new), `tk status` and
`tk doctor` show one line on how much of it is set up. Everything asks first.

## Parts

What `fk install <part>` sets up, and what `fk uninstall <part>` puts back.

| Part | What it sets up |
|---|---|
| `kitty-bg` | apt `imagemagick` (and fzf if there's none) for the `k-bg` picker, then a first pick (live preview; Esc = no background). Uninstall: background off, resized copies removed |
| `kitty-theme` | kitty's theme collection (about 0.6 MB from GitHub), a current fzf if yours is older than 0.60, then an optional first pick with `k-theme`. Uninstall: back to kitty's colours (your Mine list stays) |
| `kitty-accents` | `k-bg accents on`: a vivid colour from the background (always readable against it, never red) for the prompt's directory, `❯` and git branch, the toolkit's pickers and highlights, and kitty's cursor, selection, links, active tab and border. Terminal colours and red prod warnings stay put |
| `kitty-icons` | `feelkit/kitty-icons/install-kitty-icons.sh` (icons + desktop entry for `k-icon`) |
| `kitty-centered` | GNOME setting `org.gnome.mutter center-new-windows`, so new windows (kitty included) open in the middle of the screen; the old value is put back on uninstall |
| `dash-to-panel` | Dash to Panel (GNOME extension) from extensions.gnome.org: the dock and the top bar merged into one bar (app icons with window previews on the left; clock, Vitals and system menu on the right; no Activities button). Preset look from `feelkit/gnome/dash-to-panel/` (bottom, 35 px, dark, own apps-button icon). Your choice: on its own or together with `dash2dock`; asked separately, default No; `fk install dash-to-panel` on an installed one opens the same settings menu as `vitals`; the uninstall asks whether to put your old settings back or go to the app's defaults; log out once after installing |
| `dash2dock` | Dash2Dock Animated (macOS-style GNOME dock at the bottom) from extensions.gnome.org, with the toolkit's patches in `feelkit/gnome/dash2dock/`: a click on an app with several windows shows window previews, calm drag-to-reorder, no gap above the dock; plus a preset look. Replaces Ubuntu's dock; your choice, alone or together with Dash to Panel; asked separately, default No; the uninstall puts that back; log out once after installing |
| `vitals` | Vitals (GNOME extension) from extensions.gnome.org: CPU, memory and temperature in the top bar. Asks whether to use the toolkit's look (`feelkit/gnome/vitals/`: which sensors show, fixed widths). Your earlier settings are kept once; the uninstall asks whether to put them back or go to the app's defaults. `fk install vitals` on an installed one opens a menu: keep your settings, re-apply the look, reset to the app's defaults, or undo the last change (the settings from just before it are kept once); log out once after installing |
| `vitals-icons` | Two SVGs in `feelkit/gnome/vitals-icons` (CPU chip with a solid core, RAM chip with pins) copied over the Vitals extension's `icons/original` icons, and its dropdown is centred under the pill (`menu-centered`, old value put back on uninstall); stock ones kept as `*.toolkit-orig` for the uninstall. An extension update restores the stock icons, so run it again after one |
| `blur-my-shell` | Blur my Shell (GNOME extension) from extensions.gnome.org with an optional look from `feelkit/gnome/blur-my-shell/` (blurred overview in Liquid Glass and Alt+Tab, applications untouched). Same settings menu as `vitals`; log out once after installing |
| `rounded-corners` | Rounded Window Corners Reborn (GNOME extension) from extensions.gnome.org with an optional look from `feelkit/gnome/rounded-window-corners/` (15 px, off for maximized and fullscreen windows). Same settings menu as `vitals`; log out once after installing |
| `no-animations` | GNOME setting `org.gnome.desktop.interface enable-animations = false`: no window zoom animations (snappier, and no blurry flash when the rofi launcher opens and closes fast); unticked by default and asked with default No: browsers then reduce motion too (websites drop their CSS animations); old value put back on uninstall |

## What's in the folder

```
components.sh     the installer components (kitty-bg, kitty-theme, ..., rounded-corners)
bin/              k-bg, k-theme, k-icon, k-rofi, fk (`fk looks`, `fk doctor`)
shell/            init.sh (loaded by every shell) and the tab-completion hooks
tools             what `tk ls` shows for these commands
backgrounds/      the images k-bg offers (licences in backgrounds/SOURCES.md)
themes/           team themes for k-theme (yours go in ~/.config/kitty/themes)
kitty-icons/      the kitty icon installer and cleanup
gnome/            one folder per GNOME extension: the preset look (settings.dconf), patches
                  (dash2dock/check-patch.sh tries the patch against the newest release: `fk doctor`)
```

How a layer is laid out is described in the toolkit's README, under Layers.

## Licences

The background photos each have their own licence (some CC BY-SA, which means changed copies are
shared under the same licence): see `backgrounds/SOURCES.md`.
