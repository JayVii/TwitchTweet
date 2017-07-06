# TwitchTweet

## Requirements

- curl

- jshon

- [t](https://github.com/sferik/t)

## Usage

```
# first run
./twitchtweet.sh

# as soon as you grabbed your OAUTH
./twitchtweet.sh meldrian # or any other streamer on twitch
```

## Custom tweet-template

Edit `~/.config/twitchtweet/config` and append in a new line:
```
COMPTWEET="#OMG $ISPLAYER is streaming my #FavoriteGame $ISPLAYING. https://twitch.tv/$ISPLAYER"
```
`$ISPLAYER` will be automatically replaced with the streamer's name by this script.
`$ISPLAYING` will be automatically replaced with the currently played game by this script.

**Keep in mind, Twitter only allows for up to 140 characters.**
