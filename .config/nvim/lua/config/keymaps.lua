local map = vim.keymap.set

map("n", ";", ":", { desc = "Open Cmdline" })

map({ "n", "i", "v" }, "<Left>", "<Nop>", { silent = true })
map({ "n", "i", "v" }, "<Down>", "<Nop>", { silent = true })
map({ "n", "i", "v" }, "<Up>", "<Nop>", { silent = true })
map({ "n", "i", "v" }, "<Right>", "<Nop>", { silent = true })
