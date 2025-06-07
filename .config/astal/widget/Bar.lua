local Widget = require("astal.gtk3.widget")
local MyButton = require("widget.MyButton")
local Anchor = require("astal.gtk3").Astal.WindowAnchor

return function(monitor)
	return Widget.Window({
		monitor = monitor,
		anchor = Anchor.TOP + Anchor.LEFT + Anchor.RIGHT,
		exclusivity = "EXCLUSIVE",
		Widget.Box({
			Widget.Label({
				label = "Click the button",
			}),
			MyButton("hi, im a button"),
		}),
	})
end
