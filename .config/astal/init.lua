local App = require("astal.gtk3.app")
local Bar = require("widget.Bar")

App:apply_css("/home/torch/.config/astal/style.css")

App:start({
	main = function()
		Bar(0)
	end,
})
