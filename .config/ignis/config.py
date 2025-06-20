from ignis import utils
from ignis.app import IgnisApp
from widgets import Notch

app = IgnisApp.get_default()
app.add_icons(f"{utils.get_current_dir()}/icons")
app.apply_css(utils.get_current_dir() + "/style.scss")

# utils.exec_sh("/home/torch/.config/hypr/scripts/reload.sh")


for m in range(utils.get_n_monitors()):
    Notch(m)
