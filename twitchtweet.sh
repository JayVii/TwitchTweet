#!/bin/bash
####################################################################
# JayVii - https://www.jayvii.de                                   #
# TwitchTweet - https://git.jayvii.de/Scripts/TwitchTweet          #
####################################################################

# check for curl
if [ ! -f /usr/bin/curl ]; then
  echo "curl doesn\'t seem to be installed..."
  echo "or is not accessible in /usr/bin/curl"
  echo "# apt install curl"
  exit 1;
fi
# check for jshon
if [ ! -f /usr/bin/jshon ]; then
  echo "jshon doesn\'t seem to be installed..."
  echo "or is not accessible in /usr/bin/jshon"
  echo "# apt install jshon"
  exit 1;
fi
# check for t
if [ ! -f /usr/local/bin/t ]; then
  echo "t doesn\'t seem to be installed..."
  echo "or is not accessible in /usr/local/bin/t"
  echo "see https://github.com/sferik/t"
  sleep 2;
  xdg-open "https://github.com/sferik/t"
  exit 1;
fi

# Load config-file (0auth)
CONFIGDIR="$HOME/.config/twitchtweet"
mkdir -p "$CONFIGDIR"
touch "$CONFIGDIR/config"
source "$CONFIGDIR/config"
if [ -z "$OAUTH" ]; then
  echo "No OAUTH found in your config."
  echo "Get one here: https://www.twitch.tv/kraken/oauth2/clients/new"
  echo "and place it in \"$CONFIGDIR/config\"."
  echo "OAUTH=\"your-oauth-goes-here\""
  sleep 2;
  xdg-open "https://www.twitch.tv/kraken/oauth2/clients/new"
  exit 1;
fi

ISPLAYER=$(curl -H "Authorization: OAuth $OAUTH" -s https://api.twitch.tv/kraken/streams/"$1" | jshon -e stream -e channel -e name)
ISPLAYING=$(curl -H "Authorization: OAuth $OAUTH" -s https://api.twitch.tv/kraken/streams/"$1" | jshon -e stream -e channel -e game)

if [ -z "$ISPLAYER" ]; then
  echo "$1 is currently offline :("
else
  if [ -z "$COMPTWEET" ]; then
    echo "No custom tweet-template found. Will use default."
    COMPTWEET="$ISPLAYER is currently streaming $ISPLAYING. Join now! https://twitch.tv/$ISPLAYER"
  fi
  echo "Tweet will look like so:"
  echo ""
  echo "$COMPTWEET"
  pause 5
  t update "$COMPTWEET"
fi
