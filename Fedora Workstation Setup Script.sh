#!/bin/bash
clear
# Start of Function Cluster
tput setaf 3
echo "Initializing functions..."
sleep 1.5
tput setaf 10
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

	# Check for 36
	if ! echo $VERSION_ID | grep -qi "36"
	then
		sysreqfail
	fi
	
	# Check kernel architecture
	if ! uname -m | grep -qi "x86_64"
	then
		sysreqfail
	fi
}
echo "Loaded checkcompatibility."
sysreqfail () {
	clear
	tput setaf 9
	echo "System requirements not met. This script supports the x86_64 version of Fedora 36 Workstation!!!"
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
echo "Loaded sysreqfail."
mainmenu () {
	clear
 	tput setaf 3
	echo "============================================="
	echo " --- Fedora Workstation Setup Script 5.0 ---"
	echo "============================================="
	echo "Supported Fedora Workstation Versions (x86_64): 36"
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
	echo "You may run this script again after a failure, an upgrade, or to get your system up-to-date with the latest version of my script."
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
echo "Loaded mainmenu."
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
echo "Loaded multiusermenu."
quitscript () {
	tput sgr0
	clear
	exit
}
echo "Loaded quitscript."
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
echo "Loaded badoption."
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
echo "Loaded finish."
full () {
	clear
	tput setaf 3
	echo "Full Install/All User Packages..."
	tput sgr0
	sleep 3
	clear
	runcheck sudo dnf install -y https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm
	runcheck sudo dnf groupupdate -y core
	runcheck sudo dnf groupupdate -y multimedia --setop="install_weak_deps=False" --exclude=PackageKit-gstreamer-plugin
	runcheck sudo dnf groupupdate -y sound-and-video
	runcheck sudo dnf install -y rpmfusion-free-release-tainted
	runcheck sudo dnf install -y libdvdcss
	runcheck sudo dnf install -y rpmfusion-nonfree-release-tainted
	runcheck sudo dnf mark -y install libfreeaptx pipewire-codec-aptx
	runcheck flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
	runcheck sudo dnf install -y curl cabextract xorg-x11-font-utils fontconfig
	runcheck sudo dnf install -y "https://downloads.sourceforge.net/project/mscorefonts2/rpms/msttcore-fonts-installer-2.6-1.noarch.rpm"
	runcheck sudo dnf install -y alien remmina bleachbit frozen-bubble asunder brasero k3b libburn cdrskin pavucontrol easyeffects rhythmbox rhythmbox-alternative-toolbar shotwell solaar gnome-boxes gparted vlc p7zip* gnome-tweaks gnome-extensions-app chrome-gnome-shell lame gpart neofetch ffmpeg httrack tree telegram-desktop easytag android-tools gnome-sound-recorder cheese supertux dconf-editor deja-dup gnome-todo sushi unoconv ffmpegthumbs gnome-books krita gnome-clocks gimp htop fragments curl git handbrake-gui minetest obs-studio discord menulibre libreoffice-draw java-latest-openjdk gstreamer-plugins* gstreamer1-plugins* pip shotcut google-chrome-stable kernel-headers kernel-devel gcc glibc-headers make dkms file-roller file-roller-nautilus cpu-x gucharmap gnome-power-manager bijiben libheif libquicktime gdk-pixbuf2 mcomix3 VirtualBox gscan2pdf supertuxkart unzip
	javamenu
	runcheck sudo dnf update -y --refresh
	runcheck sudo dnf autoremove -y
	runcheck flatpak install -y flathub com.system76.Popsicle
	runcheck flatpak install -y flathub org.audacityteam.Audacity
	runcheck flatpak install -y flathub org.musescore.MuseScore
	runcheck flatpak install -y flathub com.mojang.Minecraft
	runcheck flatpak install -y flathub org.inkscape.Inkscape
	runcheck flatpak install -y flathub ar.xjuan.Cambalache
	runcheck flatpak install -y flathub com.github.jeromerobert.pdfarranger
	runcheck flatpak install -y flathub com.github.muriloventuroso.pdftricks
	runcheck flatpak install -y flathub org.kde.okular
	runcheck flatpak install -y flathub com.github.flxzt.rnote
	runcheck flatpak install -y flathub com.github.tchx84.Flatseal
	runcheck flatpak install -y flathub com.mattjakeman.ExtensionManager
	runcheck flatpak install -y flathub com.wps.Office
	runcheck flatpak install -y flathub app.drey.EarTag
	runcheck flatpak update -y
	runcheck flatpak uninstall -y --unused --delete-data
	runcheck pip install pip wheel youtube-dl yt-dlp speedtest-cli mangadex-downloader pillow py7zr animdl -U
    runcheck pip cache purge
	echo "Adding current user to cdrom group..."
	runcheck sudo usermod -aG cdrom $USER
	echo "Adding current user to vboxusers group..."
	runcheck sudo usermod -aG vboxusers $USER
	autofontinstall
	installadwtheme
	finish
}
echo "Loaded full."
minimal () {
	clear
	tput setaf 3
	echo "Minimal Install/Essentials..."
	tput sgr0
	sleep 3
	clear
	runcheck sudo dnf install -y https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm
	runcheck sudo dnf groupupdate -y core
	runcheck sudo dnf groupupdate -y multimedia --setop="install_weak_deps=False" --exclude=PackageKit-gstreamer-plugin
	runcheck sudo dnf groupupdate -y sound-and-video
	runcheck sudo dnf install -y rpmfusion-free-release-tainted
	runcheck sudo dnf install -y libdvdcss
	runcheck sudo dnf install -y rpmfusion-nonfree-release-tainted
	runcheck sudo dnf mark -y install libfreeaptx pipewire-codec-aptx
	runcheck flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
	runcheck sudo dnf install -y curl cabextract xorg-x11-font-utils fontconfig
	runcheck sudo dnf install -y "https://downloads.sourceforge.net/project/mscorefonts2/rpms/msttcore-fonts-installer-2.6-1.noarch.rpm"
	runcheck sudo dnf install -y alien pavucontrol rhythmbox rhythmbox-alternative-toolbar gparted p7zip* gnome-tweaks gnome-extensions-app gpart ffmpeg dconf-editor deja-dup sushi unoconv ffmpegthumbs htop curl git menulibre gstreamer-plugins* gstreamer1-plugins* pip google-chrome-stable kernel-headers kernel-devel gcc glibc-headers make dkms file-roller file-roller-nautilus easyeffects cpu-x gucharmap gnome-power-manager bijiben libheif libquicktime gdk-pixbuf2 mcomix3 gscan2pdf unzip
	runcheck sudo dnf update -y --refresh
	runcheck sudo dnf autoremove -y
	runcheck flatpak install -y flathub com.github.jeromerobert.pdfarranger
	runcheck flatpak install -y flathub com.github.muriloventuroso.pdftricks
	runcheck flatpak install -y flathub org.kde.okular
	runcheck flatpak install -y flathub com.github.tchx84.Flatseal
	runcheck flatpak install -y flathub com.mattjakeman.ExtensionManager
	runcheck flatpak install -y flathub com.wps.Office
	runcheck flatpak update -y
	runcheck flatpak uninstall -y --unused --delete-data
	runcheck pip install pip wheel speedtest-cli -U
    runcheck pip cache purge
    autofontinstall
    installadwtheme
	finish
}
echo "Loaded minimal."
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
	runcheck sudo alternatives --config java
	clear
	java --version
	sleep 3
	clear
}
echo "Loaded javamenu."
autofontinstall () {
	echo "Installing the Essential Font Pack..."
	runcheck sudo wget -O "/tmp/fontinstall.zip" "https://github.com/TechnologyMan101/script-extras/releases/download/20220822-0943/Essential.Font.Pack.zip"
	runcheck sudo unzip -o "/tmp/fontinstall.zip" -d "/usr/share/fonts"
	runcheck sudo chmod -R 755 "/usr/share/fonts/Essential Font Pack"
	runcheck sudo rm "/tmp/fontinstall.zip"
}
echo "Loaded autofontinstall."
installadwtheme () {
	echo "Installing the Adwaita theme set..."
	runcheck flatpak install -y flathub com.github.GradienceTeam.Gradience
	runcheck sudo dnf copr enable -y nickavem/adw-gtk3
	runcheck sudo dnf install -y adw-gtk3
	runcheck flatpak install -y org.gtk.Gtk3theme.adw-gtk3 org.gtk.Gtk3theme.adw-gtk3-dark
	# Set default light theme
	runcheck gsettings set org.gnome.desktop.interface gtk-theme 'adw-gtk3'
	runcheck gsettings set org.gnome.desktop.interface color-scheme 'default'
}
echo "Loaded installadwtheme."
runcheck () {
	IFS=$'\n'
	command="$*"
	retval=1
	attempt=1
	until [[ $retval -eq 0 ]] || [[ $attempt -gt 5 ]]; do
		(
			set +e
			$command
		)
		retval=$?
		attempt=$(( $attempt + 1 ))
		if [[ $retval -ne 0 ]]; then
			clear
			tput setaf 9
			echo "Oops! Something went wrong! Retrying in 3 seconds..."
			tput sgr0
			sleep 3
			clear
		fi
	done
	if [[ $retval -ne 0 ]] && [[ $attempt -gt 5 ]]; then
		clear
		tput setaf 9
		echo "Oops! A fatal error has occurred and the program cannot continue. Returning to the main menu in 10 seconds..."
		tput setaf 3
		echo "Please try again later or if the problem persists, create an issue on GitHub."
		tput sgr0
		sleep 10
		clear
		mainmenu
	fi
	IFS=""
}
echo "Loaded runcheck."
tput setaf 3
echo "Continuing..."
tput sgr0
sleep 1.5
# End of Function Cluster
# Start of Main Script
while true
do
	checkcompatibility
	mainmenu
done
# End of Main Script
