#!/bin/sh
WINEPREFIX="$(echo ${HOME})/.var/app/com.blizzard.Battlenet/data/wine" # Required to reset the WINEPREFIX here because Wine does not like the relative path set in the manifest

echo "Running Wineboot"
wineboot

echo "Updating registry"
wine regedit /app/share/WineGraphics.reg
sleep 3

echo "Copying Hearthstone Deck Tracker installation directory into Wine prefix if it doesn't already exist"
cp -nr "/app/extra/Hearthstone Deck Tracker" "${WINEPREFIX}/drive_c/Program Files (x86)/"

echo "Installing dotnet48 with winetricks"
winetricks dotnet48

echo "Setting up Discord rich presence"
for i in {0..9}; do
    test -S $XDG_RUNTIME_DIR/discord-ipc-$i ||
    ln -sf {app/com.discordapp.Discord,$XDG_RUNTIME_DIR}/discord-ipc-$i;
done

echo "Changing directory to /var/data/wine/drive_c/Program Files (x86)/Hearthstone Deck Tracker"
cd "${WINEPREFIX}/drive_c/Program Files (x86)/Hearthstone Deck Tracker"

WINESYNC=1

echo "Launching Hearthstone Deck Tracker"
wine "${WINEPREFIX}/drive_c/Program Files (x86)/Hearthstone Deck Tracker/Hearthstone Deck Tracker.exe"
