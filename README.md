## Telegram Builds with Patches for Arch Linux

PKGBUILDS From [archlinuxcn](https://github.com/archlinuxcn/repo/tree/master/archlinuxcn/telegram-desktop-lily)
Build with [arch repo builder](https://github.com/sakarie9/arch-repo-builder)

Patch lists can be found here: [patchs](pkgbuilds/telegram-desktop-sakari)

### Usage

`pacman -U {Link from release}`

or

Add following entry to `/etc/pacman.conf`

```conf
[sakari-tg]
SigLevel = Optional
Server = https://github.com/sakarie9/telegram-archbuild/releases/download/repo
```
