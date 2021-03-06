# Fedora Workstation Setup Script
Bash script to set up a fresh install of Fedora Workstation.

# This script is now being retired due to lack of use and testing. This script will no longer be maintained, although this script should still continue to function normally until at least Fedora Workstation 34. New features and fixes will no longer be made to this script.

# Documentation

Version 3.1

Supported Fedora Workstation Versions: 33

**Please Run Script After Following Instructions Here**

**The Extras folder also contains other tools you may want including font packs.**

Please install .rpm files and files using other types of installation formats using files manually (if you have them).

Please copy the Essential Font Pack from Extras at https://mega.nz/folder/cRZTkAJD#dV8CG6th0a-10Fu6yCG-5Q into `/usr/share/fonts/` Use `sudo nautilus` to open the file manager as root. This is required to perform these actions as this is modifying files on the system level. Before copying the font pack to the fonts folder, check that the folder permissions are all on “Create and delete files.”

Please add yourself to `vboxusers` using `sudo usermod -aG vboxusers $USER` and then reboot. Only do this if you have VirtualBox installed.


# Keyboard Shortcuts:

Change “Settings” to “Super+I”

Change “Toggle Fullscreen Mode” to “Super+F11”

Add shortcut to open “gnome-terminal” with “Ctrl+Alt+T”

Add shortcut to open “gnome-system-monitor” with “Super+Backspace”

Refer to image for media controls on desktop keyboards.


# Run Script:

Mark the script as executable by changing it in file properties or running `chmod +x /path/to/file`. Then run it in Terminal with `bash /path/to/file`


# Media Shortcuts Image:
![Error](https://raw.githubusercontent.com/TechnologyMan101/fedora-workstation-setup-script/main/Media%20Shortcuts%20for%20Desktop%20Keyboards.png)


# VM Users

Minimal Install is recommended. VM Tools can be found at  https://mega.nz/folder/cRZTkAJD#dV8CG6th0a-10Fu6yCG-5Q in Extras.
