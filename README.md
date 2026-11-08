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

## Install

You need the toolkit first (see its README), then:

```bash
tk layer add https://github.com/bluestero/unix-feelkit.git   # clones into layers/feelkit, offers to set it up
```

`tk install --layer=feelkit` sets up just its parts later, `tk update` keeps it current, and
`tk uninstall` shows its parts in the same checklist as the toolkit's. Everything asks first.

## What's in the folder

```
components.sh     the installer components (kitty-bg, kitty-theme, ..., rounded-corners)
bin/              k-bg, k-theme, k-icon, k-rofi
shell/            init.sh (loaded by every shell) and the tab-completion hooks
tools             what `tk ls` shows for these commands
backgrounds/      the images k-bg offers (licences in backgrounds/SOURCES.md)
themes/           team themes for k-theme (yours go in ~/.config/kitty/themes)
kitty-icons/      the kitty icon installer and cleanup
gnome/            one folder per GNOME extension: the preset look (settings.dconf), patches
```

How a layer is laid out is described in the toolkit's README, under Layers.

## Licences

The background photos each have their own licence (some CC BY-SA, which means changed copies are
shared under the same licence): see `backgrounds/SOURCES.md`.
