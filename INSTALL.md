# `sudo` for user
```bash
su -
usermod -aG sudo $USER
reboot
```

# APT Packages

## utilities
git
curl
wget
htop
tmux
vim
vim-nox
ca-certificates
gnupg
lm-sensors
radeontop
amd64-microcode
silversearcher-ag

## development
build-essential
gcc
clang
clang-format
clangd
cmake
cmake-curses-gui
valgrind
pkg-config
nodejs
python-is-python3
python3-virtualenv
sqlite3
minicom

# customization
kde-plasma-desktop
plasma-nm
dolphin-plugins
papirus-icon-theme
grub-customizer         (https://github.com/vinceliuice/grub2-themes)
plymouth-theme-*
plymouth-themes
kde-config-plymouth
kde-config-systemd
qt5-style-kvantum
qt5-style-kvantum-themes
plasma-workspace-wayland
pinentry-qt             # for gpg
arc-theme               # for gtk theming
ark
firefox
freefilesync
qbittorent
okular
gwenview
kde-spectable
telegram-desktop

## latex
latexmk
texlive
texlive-luatex
texlive-latex-extra
texlive-fonts-recommended
texlive-fonts-extra

# Desktop Theme
wget -qO- https://raw.githubusercontent.com/PapirusDevelopmentTeam/arc-kde/master/install.sh | sh

# Sublime Merge
wget -qO - https://download.sublimetext.com/sublimehq-pub.gpg | gpg --dearmor | sudo tee /etc/apt/trusted.gpg.d/sublimehq-archive.gpg > /dev/null
sudo apt install apt-transport-https
echo "deb https://download.sublimetext.com/ apt/stable/" | sudo tee /etc/apt/sources.list.d/sublime-text.list
sudo apt install sublime-merge

# Docker
```bash
curl -fsSL https://download.docker.com/linux/debian/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/debian \
  bookwork stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
```
## packages
docker-ce
docker-ce-cli
containerd.io
docker-compose-plugin
```bash
sudo usermod -aG docker $USER
```

# Steam
```bash
sudo dpkg --add-architecture i386
sudo apt update && sudo apt install steam-installer
```


# `/etc/fstab`
```
UUID=55A0ED12241B54D4                       /home/mrota/Data   ntfs          uid=mrota,gid=mrota,umask=0077     0 0 
```

# Pipewire
```bash
systemctl --user --now enable wireplumber
sudo apt install pipewire libspa-0.2-bluetooth
```

# AMDGPU
To enable overclocking and hopefully fix high idle clocks:
```bash
printf 'amdgpu.ppfeaturemask=0x%x\n' "$(($(cat /sys/module/amdgpu/parameters/ppfeaturemask) | 0x4000))"
```
Put that as a kernel parameter in /etc/default/grub - GRUB_CMD_LINUX_DEFAULT:
`amdgpu.ppfeaturemask=0xffffffff`

Add file `/etc/X11/xorg.conf.d/20-amdgpu.conf`:
```
Section "Screen"
	Identifier "LG_27"
	# Fuck Steam
	# DefaultDepth 30
	DefaultDepth 24
EndSection

Section "Device"
	Identifier "AMD"
	Driver "amdgpu"
	Option "TearFree" "true"
	Option "VariableRefresh" "true"
EndSection
```
