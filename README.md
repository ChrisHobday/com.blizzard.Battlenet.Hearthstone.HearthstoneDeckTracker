flatpak run org.flatpak.Builder build-dir --repo=repo --force-clean com.blizzard.Battlenet.HearthstoneDeckTracker.yml

flatpak install --user ./repo com.blizzard.Battlenet.HearthstoneDeckTracker

flatpak remove com.blizzard.Battlenet.HearthstoneDeckTracker