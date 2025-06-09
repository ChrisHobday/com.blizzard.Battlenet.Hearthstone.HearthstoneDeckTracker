#!/bin/sh
WINEPREFIX="$(echo ${HOME})/.var/app/com.blizzard.Battlenet/data/wine" # Required to reset the WINEPREFIX here because Wine does not like the relative path set in the manifest

echo "Running Wineboot"
wineboot

echo "Updating registry"
wine regedit /app/share/WineGraphics.reg
sleep 3

echo "Installing dotnet48 with winetricks"
winetricks dotnet48

echo "Setting up Discord rich presence"
for i in {0..9}; do
    test -S $XDG_RUNTIME_DIR/discord-ipc-$i ||
    ln -sf {app/com.discordapp.Discord,$XDG_RUNTIME_DIR}/discord-ipc-$i;
done

echo "Checking if Hearthstone Deck Tracker is already installed"
if [ -d "${WINEPREFIX}/drive_c/users/chris/AppData/Local/Hearthstone Deck Tracker/" ]; then
  echo "Hearthstone Deck Tracker is installed"

  echo "Changing directory to ${WINEPREFIX}/drive_c/users/chris/AppData/Local/Hearthstone Deck Tracker/"
  cd "${WINEPREFIX}/drive_c/users/chris/AppData/Local/Hearthstone Deck Tracker/"

  echo "Launching Hearthstone Deck Tracker"
  wine "${WINEPREFIX}/drive_c/users/chris/AppData/Local/Hearthstone Deck Tracker/Hearthstone Deck Tracker.exe"
else
  echo "Hearthstone Deck Tracker is not installed"

  echo "Changing directory to /app/bin/"
  cd "/app/bin/"

  echo "Launching Hearthstone Deck Tracker Installer"
  wine "/app/bin/HDT-Installer.exe"
fi
