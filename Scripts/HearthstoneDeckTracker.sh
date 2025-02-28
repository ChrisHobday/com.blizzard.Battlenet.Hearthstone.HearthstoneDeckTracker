#!/bin/sh
WINEPREFIX="$(echo ${HOME})/.var/app/com.blizzard.Battle.net/data/wine" # Required to reset the WINEPREFIX here because wine does not like the relative path set in the manifest

echo "Checking if Battle.net is already installed"
if [ -d "${WINEPREFIX}/drive_c/Program Files (x86)/Battle.net/" ]; then
  echo "Battle.net is installed"

  echo "Setting up Discord rich presence"
  for i in {0..9}; do
      test -S $XDG_RUNTIME_DIR/discord-ipc-$i ||
      ln -sf {app/com.discordapp.Discord,$XDG_RUNTIME_DIR}/discord-ipc-$i;
  done

  # echo "Installing dotnet472 with winetricks"
  # winetricks dotnet472

  # echo "Installing corefonts with winetricks"
  # winetricks corefonts

  # echo "Turning off crash dialogs with winetricks"
  # winetricks nocrashdialog

  # echo "Updating Windows registry with Wine graphics keys"
  # wine regedit /app/share/WineGraphics.reg

  echo "Changing directory to /app/bin/HearthstoneDeckTracker"
  cd "/app/bin/HearthstoneDeckTracker"

  echo "Launching Hearthstone Deck Tracker"
  wine "/app/bin/HearthstoneDeckTracker/Hearthstone Deck Tracker.exe"
  # wine "${WINEPREFIX}/drive_c/Program Files (x86)/Battle.net/Battle.net.exe" --exec="launch WTCG"
else
  echo "Battle.net is not installed"

  echo "Launching Battle.net Flatpak"
  flatpak-spawn --host flatpak run com.blizzard.Battle.net
fi