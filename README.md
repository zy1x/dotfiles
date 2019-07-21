# Post installation steps

### Installing packages
'''
sudo pacman -S - < package_list
'''

### Installing YAY package manager
'''
git clone https://aur.archlinux.org/yay.git
cd yay
makepkg-si
'''

### Enable services
'''
systemctl enable NetworkManager.service
systemctl enable fstrim.timer
'''
