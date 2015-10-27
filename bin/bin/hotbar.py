import subprocess
from Xlib import display
from time import sleep

screen = display.Display().screen()

widths = []
heights = []

BAR_HEIGHT = 25  # Bar height in pixels


def get_resolutions(widths, heights):
    output = subprocess.Popen('xrandr | grep "\*" | cut -d" " -f4', shell=True,
                              stdout=subprocess.PIPE).communicate()[0]

    displays = output.strip().split('\n')

    for d in displays:
        values = d.split('x')
        widths.append(int(values[0]))
        heights.append(int(values[1]))


def get_mouse_pos():
    data = screen.root.query_pointer()._data
    return data['root_x'], data['root_y']


def hide_bar():
    subprocess.Popen('i3-msg bar hidden_state hide', shell=True)


def show_bar():
    subprocess.Popen('i3-msg bar hidden_state show', shell=True)


if __name__ == '__main__':
    get_resolutions(widths, heights)

    while True:
        X, Y = get_mouse_pos()

        if X < widths[0] and Y > heights[0] - BAR_HEIGHT:
            show_bar()
        elif X > widths[0] and Y > heights[1] - BAR_HEIGHT:
            show_bar()
        else:
            hide_bar()
        sleep(1)
