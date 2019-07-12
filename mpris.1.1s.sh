#!/usr/bin/env bash

MPRIS_META=$(dbus-send --print-reply --dest=org.mpris.MediaPlayer2.spotify /org/mpris/MediaPlayer2 org.freedesktop.DBus.Properties.Get string:org.mpris.MediaPlayer2.Player string:Metadata)
ARTIST=$(echo "$MPRIS_META" | sed -n '/artist/{n;n;p}' | cut -d '"' -f 2)
SONG_TITLE=$(echo "$MPRIS_META" | sed -n '/title/{n;p}' | cut -d '"' -f 2)

if [ "$MPRIS_META" = "" ]; then
	echo "| iconName=spotify"
	echo "---"
	echo "Open Spotify | bash=spotify terminal=false"
else
	echo "$ARTIST - $SONG_TITLE | iconName=spotify"
	echo "---"
	echo "Restore Spotify | bash=~/.config/argos/.restorespotify.sh terminal=false"
	echo "Minimize Spotify | bash=~/.config/argos/.minimizespotify.sh terminal=false"
	echo "Kill Spotify | bash=~/.config/argos/.killspotify.sh terminal=false"
fi
