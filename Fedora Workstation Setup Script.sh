#!/bin/bash
# Start of Function Cluster
mainmenu () {
	clear
 	tput setaf 3
	echo "============================================="
	echo " --- Fedora Workstation Setup Script 3.1 ---"
	echo "============================================="
	echo "Supported Fedora Workstation Versions: 33"
	echo "Script may prompt you or ask you for your password once in a while. Please monitor your computer until the script is done."
	echo "This script will show terminal output. This is normal."
	echo "You can open this script in a text editor to see packages to be installed in detail."
	tput setaf 10
	echo "You are encouraged to modify this script for your own needs."
	tput setaf 9
	echo "System will automatically reboot after the script is run!!!"
	echo "It is not recommended to run this script more than once!!!"
	echo "Make sure you have a stable and fast Internet connection before proceeding!!!"
	tput setaf 3
	echo "Press 1 to perform a Full Install (All User Packages)"
	echo "Press 2 to perform a Minimal Install (Essentials)"
	tput setaf 9
	echo "Press Q to quit"
	tput sgr0
	echo "Enter your selection followed by <return>:"
	read answer
	case "$answer" in
		1) full;;
		2) minimal;;
		q) quitscript;;
		Q) quitscript;;
	esac
	badoption
}
quitscript () {
	tput sgr0
	clear
	exit
}
badoption () {
	clear
	tput setaf 9
	echo "Invalid Option!"
	tput setaf 3
	echo "Returning to Main Menu..."
	tput sgr0
	sleep 3
	mainmenu
}
finish () {
	clear
	tput setaf 10
	echo "Done..."
	tput setaf 9
	echo "Rebooting..."
	tput sgr0
	sleep 3
	clear
	sudo reboot
}
full () {
	clear
	tput setaf 3
	echo "Full Install/All User Packages..."
	tput sgr0
	sleep 3
	clear
	sudo dnf install -y https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm
	sudo dnf groupupdate -y core
	sudo dnf groupupdate -y multimedia --setop="install_weak_deps=False" --exclude=PackageKit-gstreamer-plugin
	sudo dnf groupupdate -y sound-and-video
	sudo dnf install -y rpmfusion-free-release-tainted
	sudo dnf install -y libdvdcss
	sudo dnf install -y rpmfusion-nonfree-release-tainted
	flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
	sudo dnf install -y curl cabextract xorg-x11-font-utils fontconfig
	sudo rpm -i https://downloads.sourceforge.net/project/mscorefonts2/rpms/msttcore-fonts-installer-2.6-1.noarch.rpm
	sudo dnf install -y ibus-mozc alien youtube-dl remmina bleachbit frozen-bubble asunder brasero k3b pavucontrol pulseeffects rhythmbox rhythmbox-alternative-toolbar shotwell solaar gnome-boxes gparted vlc p7zip* gnome-tweaks gnome-extensions-app chrome-gnome-shell lame gpart python3-speedtest-cli neofetch ffmpeg httrack tree audacity telegram-desktop easytag android-tools gnome-sound-recorder cheese supertux dconf-editor deja-dup gnome-todo pitivi sushi unoconv ffmpegthumbs gnome-books krita gnome-clocks gimp htop transmission curl git handbrake-gui minetest obs-studio VirtualBox discord menulibre libreoffice-draw java-latest-openjdk gstreamer-plugins* gstreamer1-plugins*
	javamenu
	sudo dnf upgrade -y
	sudo dnf autoremove -y
	flatpak install -y com.system76.Popsicle org.musescore.MuseScore com.spotify.Client  org.geogebra.GeoGebra us.zoom.Zoom com.mattermost.Desktop com.mojang.Minecraft
	flatpak update -y
	flatpak uninstall -y --unused --delete-data
	echo "Adding current user to cdrom group..."
	sudo usermod -aG cdrom $USER
	gio mime text/calendar org.gnome.Calendar.desktop
	echo "Adding enviromnent variable to fix functionality in Wayland..."
	echo "export QT_QPA_PLATFORM=xcb" | sudo tee /etc/environment
	finish
}
minimal () {
	clear
	tput setaf 3
	echo "Minimal Install/Essentials..."
	tput sgr0
	sleep 3
	clear
	sudo dnf install -y https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm
	sudo dnf groupupdate -y core
	sudo dnf groupupdate -y multimedia --setop="install_weak_deps=False" --exclude=PackageKit-gstreamer-plugin
	sudo dnf groupupdate -y sound-and-video
	sudo dnf install -y rpmfusion-free-release-tainted
	sudo dnf install -y libdvdcss
	sudo dnf install -y rpmfusion-nonfree-release-tainted
	flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
	sudo dnf install -y curl cabextract xorg-x11-font-utils fontconfig
	sudo rpm -i https://downloads.sourceforge.net/project/mscorefonts2/rpms/msttcore-fonts-installer-2.6-1.noarch.rpm
	sudo dnf install -y ibus-mozc alien pavucontrol rhythmbox rhythmbox-alternative-toolbar gparted p7zip* gnome-tweaks gnome-extensions-app gpart ffmpeg dconf-editor deja-dup sushi unoconv ffmpegthumbs htop curl git menulibre gstreamer-plugins* gstreamer1-plugins*
	sudo dnf upgrade -y
	sudo dnf autoremove -y
	flatpak update -y
	flatpak uninstall -y --unused --delete-data
	gio mime text/calendar org.gnome.Calendar.desktop
	echo "Adding enviromnent variable to fix functionality in Wayland..."
	echo "export QT_QPA_PLATFORM=xcb" | sudo tee /etc/environment
	finish
}
javamenu () {
	clear
 	tput setaf 3
	echo "============================"
	echo " --- Java Configuration ---"
	echo "============================"
	echo "On the next screen, you will be prompted to select the default Java version. Please select the option with java-latest-openjdk."
	tput sgr0
	echo "Press <return> to continue"
	read answer
	clear
	sudo alternatives --config java
	clear
	java --version
	sleep 3
	clear
}
# End of Function Cluster
# Start of Main Script
while true
do
	mainmenu
done
# End of Main Script
