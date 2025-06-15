from ignis import widgets
from .widgets import Clock


class Notch(widgets.Window):
    __gtype_name__ = "Notch"

    def __init__(self, monitor: int):
        super().__init__(
            anchor=["top"],
            exclusivity="exclusive",
            monitor=monitor,
            namespace=f"NOTCH_{monitor}",
            layer="top",
            child=widgets.CenterBox(
                css_classes=["notch-widget"],
                start_widget=widgets.Box(child=[]),
                center_widget=widgets.Box(child=[Clock()]),
                end_widget=widgets.Box(child=[]),
            ),
        )
