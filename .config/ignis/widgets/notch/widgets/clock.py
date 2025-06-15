import datetime
from ignis import widgets
from ignis import utils


def update_label(label: widgets.Label) -> None:
    text = datetime.datetime.now().strftime("%H:%M")
    tooltip = datetime.datetime.now().strftime("%H:%M:%S")
    label.set_label(text)
    label.set_tooltip_text(tooltip)


clock_label = widgets.Label()

utils.Poll(1000, lambda x: update_label(clock_label))


class Clock(widgets.Button):
    def __init__(self):
        super().__init__(
            css_classes=["clock", "widget"],
            child=clock_label,
        )
