import datetime
from ignis import widgets
from ignis import utils
from ignis.variable import Variable
from ignis.services import hyprland

current_time = Variable(
    value=utils.Poll(1000, lambda x: datetime.datetime.now().strftime("%H:%M")).bind(
        "output"
    )
)


class Notch(widgets.Window):
    __gtype_name__ = "Notch"

    def __init__(self, monitor: int):
        super().__init__(
            anchor=["top", "left", "right"],
            exclusivity="exclusive",
            monitor=monitor,
            namespace=f"NOTCH_{monitor}",
            layer="top",
            child=widgets.CenterBox(
                start_widget=widgets.Box(
                    css_classes=["left"],
                    child=[],
                ),
                center_widget=widgets.Box(
                    css_classes=["center"],
                    child=[
                        widgets.Box(
                            css_classes=["clock"],
                            child=[
                                widgets.Icon(
                                    image="clock",
                                    pixel_size=13,
                                ),
                                widgets.Label(
                                    label=current_time.bind("value"),
                                ),
                            ],
                        )
                    ],
                ),
                end_widget=widgets.Box(
                    css_classes=["right"],
                    child=[],
                ),
            ),
        )
