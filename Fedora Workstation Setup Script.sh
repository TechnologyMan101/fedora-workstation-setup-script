#!/bin/bash
# Start of Function Cluster
checkcompatibility () {
	# Set variables
	. /etc/os-release
	isfedora="false"
	kernelarch=$(uname -m)
	
	# Check distro
	if ! echo $PRETTY_NAME | grep -qi "Fedora"
	then
		sysreqfail
	fi
	isfedora="true"
	isworkstation="false"
	
	# Check workstation
	if ! echo $PRETTY_NAME | grep -qi "Workstation"
	then
		sysreqfail
	fi
	isworkstation="true"

	# Check for 35
	if ! echo $VERSION_ID | grep -qi "35"
	then
		sysreqfail
	fi
	
	# Check kernel architecture
	if ! uname -m | grep -qi "x86_64"
	then
		sysreqfail
	fi
}
sysreqfail () {
	clear
	tput setaf 9
	echo "System requirements not met. This script supports the x86_64 version of Fedora 35 Workstation!!!"
	tput setaf 3
	echo "If your error is not caused by a wrong Fedora version or OS architecture, please check to see if I have published a script for your system."
	tput setaf 10
	echo "Your current distro is $PRETTY_NAME."
	# Display Fedora codename if Fedora
	if echo $isfedora | grep -qi "true"
	then
		echo "Your current Fedora version is $VERSION_ID."
		echo "Fedora Edition is Workstation: $isworkstation"
	fi
	echo "Your current OS architecture is $kernelarch."
	tput sgr0
	echo "Hit any key to exit:"
	IFS=""
	read -sN1 answer
	quitscript
}
mainmenu () {
	clear
 	tput setaf 3
	echo "=============================================="
	echo " --- Fedora Workstation Setup Script 4.14 ---"
	echo "=============================================="
	echo "Supported Fedora Workstation Versions (x86_64): 35"
	tput setaf 10
	echo "Your current distro is $PRETTY_NAME."
	echo "Your current Fedora version is $VERSION_ID."
	echo "Fedora Edition is Workstation: $isworkstation"
	echo "Your current OS architecture is $kernelarch."
tput setaf 3
	echo "Script may prompt you or ask you for your password once in a while. Please monitor your computer until the script is done."
	echo "This script will show terminal output. This is normal."
	echo "You can open this script in a text editor to view all functions."
	tput setaf 10
	echo "You are encouraged to modify this script for your own needs."
	tput setaf 9
	echo "System will automatically reboot after the script is run!!!"
	echo "It is not recommended to run this script more than once!!!"
	tput setaf 10
	echo "You may run this script again after an upgrade or to get your system up-to-date with the latest version of my script."
	tput setaf 9
	echo "Make sure you have a stable and fast Internet connection before proceeding!!!"
	tput setaf 3
	echo "Press 1 to perform a Full Install (All User Packages)"
	echo "Press 2 to perform a Minimal Install (Essentials)"
	echo "Press 3 to view instructions for setting up a multi-user system"
	tput setaf 9
	echo "Press Q to quit"
	tput sgr0
	echo "Enter your selection:"
	IFS=""
	read -sN1 answer
	case $(echo "$answer" | tr A-Z a-z) in
		1)	full;;
		2)	minimal;;
		3)	multiusermenu;;
		q)	quitscript;;
		*)	badoption;;
	esac
}
multiusermenu () {
	clear
 	tput setaf 3
	echo "==========================================="
	echo " --- Instructions for Multi-User Setup ---"
	echo "==========================================="
	tput setaf 9
	echo "If you want to set up multiple user accounts on your computer, please run the script again on each new user account. Make sure that additional user accounts are set to Administrator. You can set accounts back to Standard after completing setup."
	tput sgr0
	echo "Hit any key to return to the main menu:"
	IFS=""
	read -sN1 answer
	mainmenu
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
	sudo dnf mark -y install libfreeaptx pipewire-codec-aptx
	flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
	sudo dnf install -y curl cabextract xorg-x11-font-utils fontconfig
	sudo rpm -i https://downloads.sourceforge.net/project/mscorefonts2/rpms/msttcore-fonts-installer-2.6-1.noarch.rpm
	sudo dnf install -y alien remmina bleachbit frozen-bubble asunder brasero k3b libburn cdrskin pavucontrol easyeffects rhythmbox rhythmbox-alternative-toolbar shotwell solaar gnome-boxes gparted vlc p7zip* gnome-tweaks gnome-extensions-app chrome-gnome-shell lame gpart neofetch ffmpeg httrack tree telegram-desktop easytag android-tools gnome-sound-recorder cheese supertux dconf-editor deja-dup gnome-todo sushi unoconv ffmpegthumbs gnome-books krita gnome-clocks gimp htop transmission curl git handbrake-gui minetest obs-studio discord menulibre libreoffice-draw java-latest-openjdk gstreamer-plugins* gstreamer1-plugins* pip shotcut google-chrome-stable kernel-headers kernel-devel gcc glibc-headers make dkms file-roller file-roller-nautilus cpu-x gucharmap gnome-power-manager bijiben epiphany
	javamenu
	sudo dnf update -y --refresh
	sudo dnf autoremove -y
	flatpak install -y flathub com.system76.Popsicle
	flatpak install -y flathub org.audacityteam.Audacity
	flatpak install -y flathub org.musescore.MuseScore
	flatpak install -y flathub com.mojang.Minecraft
	flatpak install -y flathub org.inkscape.Inkscape
	flatpak install -y flathub ar.xjuan.Cambalache
	flatpak install -y flathub com.github.jeromerobert.pdfarranger
	flatpak install -y flathub com.github.muriloventuroso.pdftricks
	flatpak install -y flathub org.kde.okular
	flatpak update -y
	flatpak uninstall -y --unused --delete-data
	pip install pip youtube-dl yt-dlp speedtest-cli -U
	echo "Adding current user to cdrom group..."
	sudo usermod -aG cdrom $USER
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
	sudo dnf mark -y install libfreeaptx pipewire-codec-aptx
	flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
	sudo dnf install -y curl cabextract xorg-x11-font-utils fontconfig
	sudo rpm -i https://downloads.sourceforge.net/project/mscorefonts2/rpms/msttcore-fonts-installer-2.6-1.noarch.rpm
	sudo dnf install -y alien pavucontrol rhythmbox rhythmbox-alternative-toolbar gparted p7zip* gnome-tweaks gnome-extensions-app gpart ffmpeg dconf-editor deja-dup sushi unoconv ffmpegthumbs htop curl git menulibre gstreamer-plugins* gstreamer1-plugins* pip google-chrome-stable kernel-headers kernel-devel gcc glibc-headers make dkms file-roller file-roller-nautilus easyeffects cpu-x gucharmap gnome-power-manager bijiben epiphany
	sudo dnf update -y --refresh
	sudo dnf autoremove -y
	flatpak install -y flathub com.github.jeromerobert.pdfarranger
	flatpak install -y flathub com.github.muriloventuroso.pdftricks
	flatpak install -y flathub org.kde.okular
	flatpak update -y
	flatpak uninstall -y --unused --delete-data
	pip install pip speedtest-cli -U
	finish
}
javamenu () {
	clear
 	tput setaf 3
	echo "============================"
	echo " --- Java Configuration ---"
	echo "============================"
	echo "On the next screen, you will be prompted to select the default Java version. Please select the option with java-latest-openjdk. This is usually option 2."
	tput sgr0
	echo "Press any key to continue"
	IFS=""
	read -sN1 answer
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
	checkcompatibility
	mainmenu
done
# End of Main Script
