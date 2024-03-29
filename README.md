# Post installation steps

### Installing packages
```
sudo pacman -S - < package_list
```

### Clone this repo
```
alias config='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
echo ".dotfiles">>.gitignore
git clone --bare git@github.com:zy1x/dotfiles.git $HOME/.dotfiles
config checkout
```
### Overwriting existing files ERROR
```
mkdir -p .config-backup && \
config checkout 2>&1 | egrep "\s+\." | awk {'print $1'} | \
xargs -I{} mv {} .config-backup/{}

config checkout
```
### Set flag showUntrackedFiles
```
config config --local status.showUntrackedFiles no
```

### Installing YAY package manager
```
git clone https://aur.archlinux.org/yay.git
cd yay
makepkg-si
```

### Enable services
```
systemctl enable NetworkManager.service
systemctl enable fstrim.timer
```

### Settings timezone and time
```
timedatectl set-timezone Asia/Kolkata
```
#### Uncomment locale in /etc/locale.gen
```
locale-gen
unset LANG
source /etc/profile.d/locale.sh
```

### Setting dns using nmcli
```
nmcli connection modify Wired\ connection\ 1 ipv4.dns "8.8.8.8,8.8.4.4"
```