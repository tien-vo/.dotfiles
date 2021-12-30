#!/usr/bin/python


import argparse
import dbus
import sys


def truncate(name, trunclen):
    """ Truncate lengthy song names """
    if len(name) > trunclen:
        name = f"{name[:trunclen]}..."
        if ("(" in name) and (")" not in name): name += ")"

    return name


def add_font(label, font):
    return "%{{T{font}}}{label}%{{T-}}".format(font=font, label=label)


parser = argparse.ArgumentParser()
parser.add_argument("-t", "--trunclen", type=int, default=35)
parser.add_argument("--font", type=str)


# Parse
args = parser.parse_args()
# Unpack
trunclen = args.trunclen
font = args.font


try:

    session_bus = dbus.SessionBus()
    spotify_bus = session_bus.get_object(
        "org.mpris.MediaPlayer2.spotify",
        "/org/mpris/MediaPlayer2",
    )
    spotify_properties = dbus.Interface(
        spotify_bus,
        "org.freedesktop.DBus.Properties",
    )
    metadata = spotify_properties.Get(
        "org.mpris.MediaPlayer2.Player",
        "Metadata"
    )
    status = spotify_properties.Get(
        "org.mpris.MediaPlayer2.Player",
        "PlaybackStatus",
    )

    # Main labels
    artist = metadata["xesam:artist"][0] if metadata["xesam:artist"] else ""
    title = metadata["xesam:title"] if metadata["xesam:title"] else ""

    if (status == "Paused") or (not artist and not title):
        print("")
    else:
        if font:
            artist = add_font(artist, font)
            title = add_font(title, font)

        output = "{artist}: {title}".format(artist=artist, title=title)
        print(truncate(output, trunclen + 4))

except Exception as e:
    if isinstance(e, dbus.exceptions.DBusException):
        print("")
    else:
        print(e)


