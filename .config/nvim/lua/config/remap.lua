vim.g.mapleader = " "
vim.keymap.set("n","<leader>q", vim.cmd.Ex)

vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

vim.keymap.set("n", "J", "mzJ`z")
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

-- greatest remap ever
vim.keymap.set("x", "<leader>p", [["_dP]])

-- next greatest remap ever : asbjornHaland
vim.keymap.set({"n", "v"}, "<leader>y", [["+y]])
vim.keymap.set("n", "<leader>Y", [["+Y]])

vim.keymap.set({"n", "v"}, "<leader>d", [["_d]])

vim.keymap.set("n", "Q", "<nop>")
vim.keymap.set("n", "<C-f>", "<cmd>silent !tmux neww tmux-sessionizer<CR>")
vim.keymap.set("n", "<leader>f", vim.lsp.buf.format)

vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])

vim.keymap.set(
    "n",
    "<leader>ee",
    "oif err != nil {<CR>}<Esc>Oreturn err<Esc>"
)

vim.keymap.set("n", "<leader><leader>", function()
    vim.cmd("so")
end)

vim.keymap.set("n", "<C-t>", function()
    local cwd = vim.fn.expand("%:p:h")
    vim.cmd(string.format("silent !tmux split-window -h -c %s", cwd))
end)


vim.keymap.set("n", "<leader>h", function()
    local registers = {}
    for _, reg in ipairs({'"', '0', '1', '2', '3', '4', '5', '6', '7', '8', '9', '-', ':', '.', '/', '%', '#', '_'}) do
        local content = vim.fn.getreg(reg)
        if content ~= "" then
            table.insert(registers, string.format('%s: %s', reg, content:gsub("\n", "\\n")))
        end
    end

    local fzf = require("fzf-lua")
    fzf.fzf_exec(registers, {
        prompt = 'Select register: ',
        actions = {
            -- Callback to paste selected register
            ['default'] = function(selected)
                if selected[1] then
                    -- Extract the register name (first character before ':')
                    local reg = selected[1]:sub(1, 1)
                    -- Insert the selected register's content into the buffer
                    vim.api.nvim_put({vim.fn.getreg(reg)}, 'c', true, true)
                end
            end,
        },
    })
end)
