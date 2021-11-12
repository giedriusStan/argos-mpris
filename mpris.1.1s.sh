#!/usr/bin/env bash

COMMAND_BASE='dbus-send --print-reply --dest=org.mpris.MediaPlayer2.spotify /org/mpris/MediaPlayer2'

PLAY_PAUSE="$COMMAND_BASE org.mpris.MediaPlayer2.Player.PlayPause"
NEXT="$COMMAND_BASE org.mpris.MediaPlayer2.Player.Next"
PREVIOUS="$COMMAND_BASE org.mpris.MediaPlayer2.Player.Previous"

MPRIS_META=$($COMMAND_BASE org.freedesktop.DBus.Properties.Get string:org.mpris.MediaPlayer2.Player string:Metadata)
ARTIST=$(echo "$MPRIS_META" | sed -n '/artist/{n;n;p}' | cut -d '"' -f 2)
SONG_TITLE=$(echo "$MPRIS_META" | sed -n '/title/{n;p}' | cut -d '"' -f 2)
ALBUM=$(echo "$MPRIS_META" | sed -n '/album/{n;p}' | cut -d '"' -f 2 | head -1)

PLAYBACK_STATUS=$($COMMAND_BASE org.freedesktop.DBus.Properties.Get string:org.mpris.MediaPlayer2.Player string:PlaybackStatus)

if [[ $PLAYBACK_STATUS == *"Playing"* ]]; then
  PLAY_PAUSE_TOGGLE="Pause | iconName=media-playback-pause bash='$PLAY_PAUSE' terminal=false refresh=true"
else
  PLAY_PAUSE_TOGGLE="Play | iconName=media-playback-start bash='$PLAY_PAUSE' terminal=false refresh=true"
fi

if [[ $ARTIST == "" ]]; then
	TITLE="$ALBUM - $SONG_TITLE | iconName=media-tape"
else
	TITLE="$ARTIST - $SONG_TITLE | iconName=media-playback-pause"
fi

echo "$TITLE"
echo "---"
echo "$SONG_TITLE | iconName=folder-music-symbolic"

if [[ $ARTIST == "" ]]; then
	echo "$ALBUM | iconName=media-tape"
else
	echo "$ARTIST | iconName=contact-new"
	echo "$ALBUM | iconName=media-optical"
fi

echo "---"
echo "Previous | iconName=media-skip-backward bash='$PREVIOUS' terminal=false refresh=true"
echo "Next | iconName=media-skip-forward bash='$NEXT' terminal=false refresh=true"
echo "$PLAY_PAUSE_TOGGLE"

