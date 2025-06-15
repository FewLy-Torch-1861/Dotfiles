from ignis import widgets
from ignis import utils
from ignis.services.hyprland import HyprlandService, HyprlandWorkspace

def left(monitor_name: str) -> widgets.Box:
    return widgets.Box(
        child=[

        ]
    )

def center() -> widgets.Box:
    return widgets.Box(
        child=[

        ]
    )

def right() -> widgets.Box:
    return widgets.Box(
        child=[

        ]
    )

def bar(monitor_id:int = 0) -> widgets.Window:
    monitor_name = utils.get_monitor(monitor_id).get_connector()
    return widgets.Window(
        namespace=f"ignis_bar_{monitor_id}",
        monitor=monitor_id,
        anchor=["top"],
        exclusivity="exclusive",
        child=widgets.CenterBox(
            css_classes=["bar"],
            start_widget=left(monitor_name),
            center_widget=center(),
            end_widget=right(),
        )
    )

    for i in range(utils.get_n_monitors()):
        bar(i)
