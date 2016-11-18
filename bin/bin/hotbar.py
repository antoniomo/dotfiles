#!/usr/bin/env python3
import subprocess
import sys
import os
from time import sleep
from bisect import bisect
from Xlib import display

REFRESH_PERIOD = .5  # In seconds
BAR_HEIGHT = 30  # Bar height in pixels
BAR_HIDDEN = True

screen = display.Display().screen()
widhts, heights = None, None


def get_resolutions():
    output = subprocess.Popen('xrandr | grep " connected" | grep -o -e "[0-9]\+x[0-9]\++[0-9]\+"',
                              shell=True, stdout=subprocess.PIPE).communicate()[0]
    displays = output.strip().split(b'\n')

    # Saving each screen's right border and height
    displays = [d.split(b'x') for d in displays]
    displays = [(int(d[0]), d[1].split(b'+')) for d in displays]
    displays = [(d[0] + int(d[1][1]), int(d[1][0]) - BAR_HEIGHT) for d in displays]

    # Sorting left to right
    displays.sort()
    return zip(*displays)


def get_mouse_pos():
    data = screen.root.query_pointer()._data
    return data['root_x'], data['root_y']


def hide_bar():
    subprocess.Popen('i3-msg -q bar hidden_state hide', shell=True)
    # subprocess.Popen('i3-msg -q bar mode hide', shell=True)
    os.system('killall -USR1 py3status')  # Trigger a refresh


def show_bar():
    subprocess.Popen('i3-msg -q bar hidden_state show', shell=True)
    # subprocess.Popen('i3-msg -q bar mode dock', shell=True)
    os.system('killall -USR1 py3status')  # Trigger a refresh


def cursor_in_bar(X, Y):
    _screen = bisect(widths, X)

    if Y > heights[_screen]:
        return True
    return False


if __name__ == '__main__':
    widths, heights = get_resolutions()

    while True:
        X, Y = get_mouse_pos()

        if cursor_in_bar(X, Y) and BAR_HIDDEN:
            BAR_HIDDEN = False
            show_bar()
        elif not cursor_in_bar(X, Y) and not BAR_HIDDEN:
            BAR_HIDDEN = True
            hide_bar()

        sleep(REFRESH_PERIOD)
