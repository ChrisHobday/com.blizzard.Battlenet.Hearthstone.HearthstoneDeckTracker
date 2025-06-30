#!/bin/sh
WINEPREFIX="$(echo ${HOME})/.var/app/com.blizzard.Battlenet/data/wine" # Required to reset the WINEPREFIX here because Wine does not like the relative path set in the manifest

echo "Updating registry"
wine regedit /app/share/WineGraphics.reg
sleep 3

# TODO: Update so that it is only copied if it is a newer version
echo "Copying Hearthstone Deck Tracker installation directory to user data directory if it doesn't already exist"
cp -nr "/app/extra/Hearthstone Deck Tracker" "/var/data/"

# dotnet48 is required to avoid crashes when starting/quitting Hearthstone
echo "Installing dotnet48 with winetricks"
winetricks dotnet48

echo "Setting up Discord rich presence"
for i in {0..9}; do
    test -S $XDG_RUNTIME_DIR/discord-ipc-$i ||
    ln -sf {app/com.discordapp.Discord,$XDG_RUNTIME_DIR}/discord-ipc-$i;
done

echo "Changing directory to /app/extra/Hearthstone Deck Tracker"
cd "/var/data/Hearthstone Deck Tracker"

echo "Launching Hearthstone Deck Tracker"
wine "/var/data/Hearthstone Deck Tracker/Hearthstone Deck Tracker.exe"
