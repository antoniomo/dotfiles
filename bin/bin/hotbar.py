#!/usr/bin/env python2
import subprocess
from time import sleep
from bisect import bisect
from Xlib import display

REFRESH_PERIOD = .5  # In seconds
BAR_HEIGHT = 40  # Bar height in pixels
BAR_HIDDEN = True

screen = display.Display().screen()
widths = []
heights = []


def get_resolutions(widths, heights):
    output = subprocess.Popen('xrandr | grep "\*" | cut -d" " -f4', shell=True,
                              stdout=subprocess.PIPE).communicate()[0]
    displays = output.strip().split('\n')

    for i, d in enumerate(displays):
        values = d.split('x')
        # Saving each screens right border
        if i > 0:
            widths.append(int(values[0]) + widths[-1])
        else:  # No screen to the left of the first one
            widths.append(int(values[0]))
        # Saving height minus bar
        heights.append(int(values[1]) - BAR_HEIGHT)


def get_mouse_pos():
    data = screen.root.query_pointer()._data
    return data['root_x'], data['root_y']


def hide_bar():
    subprocess.Popen('i3-msg -q bar hidden_state hide', shell=True)


def show_bar():
    subprocess.Popen('i3-msg -q bar hidden_state show', shell=True)


def cursor_in_bar(X, Y):
    _screen = bisect(widths, X)

    if Y > heights[_screen]:
        return True
    return False


if __name__ == '__main__':
    get_resolutions(widths, heights)

    while True:
        X, Y = get_mouse_pos()

        if cursor_in_bar(X, Y) and BAR_HIDDEN:
            BAR_HIDDEN = False
            show_bar()
        elif not cursor_in_bar(X, Y) and not BAR_HIDDEN:
            BAR_HIDDEN = True
            hide_bar()

        sleep(REFRESH_PERIOD)
