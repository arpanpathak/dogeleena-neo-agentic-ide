-- ~/.config/dogeleena/init.lua
-- Leader key
vim.g.mapleader = " "

-- Options
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.termguicolors = true
vim.opt.scrolloff = 8
vim.opt.cursorline = true
vim.opt.mouse = "a"
vim.opt.clipboard = "unnamedplus"
vim.opt.swapfile = false
vim.opt.undofile = true

-- Plugin manager
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.uv.fs_stat(lazypath) then
  vim.fn.system({
    "git", "clone", "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git", "--branch=stable", lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)
require("lazy").setup("plugins", { change_detection = { notify = false } })

-- Greeting: Dogeleena bow-tie art on startup
vim.api.nvim_create_autocmd("VimEnter", {
  callback = function()
    if vim.fn.argc() ~= 0 then return end
    vim.schedule(function()
      vim.cmd([[
        echohl SpecialKey
        echo "                Y.                      _   "
        echo "                YiL                   .```.  "
        echo "                Yii;                .; .;;`.    "
        echo "                YY;ii._           .;`.;;;; :    "
        echo "                iiYYYYYYiiiii;;;;i` ;;::;;;;    "
        echo "            _.;YYYYYYiiiiiiYYYii  .;;.   ;;; "
        echo "         .YYYYYYYYYYiiYYYYYYYYYYYYii;`  ;;;;    "
        echo "       .YYYYYYY$$YYiiYY$$$$iiiYYYYYY;.ii;`..   "
        echo "      :YYY$!.  TYiiYY$$$$$YYYYYYYiiYYYYiYYii.    "
        echo "      Y$MM$:   :YYYYYY$!\"``\"4YYYYYiiiYYYYiiYY.    "
        echo "   `. :MM$$b.,dYY$$Yii\" :'   :YYYYllYiiYYYiYY    "
        echo "_.._ :`4MM$!YYYYYYYYYii,.__.diii$$YYYYYYYYYYYY"
        echo ".,._ $b`P`     \"4$$$$$iiiiiiii$$$$YY$$$$$$YiY;"
        echo "   `,.`$:       :$$$$$$$$$YYYYY$$$$$$$$$YYiiYYL"
        echo "    \"`;$$.    .;PPb$`.,.``T$$YY$$$$YYYYYYiiiYYU:  "
        echo "    ;$P$;;: ;;;;i$y$\"!Y$$$b;$$$Y$YY$$YYYiiiYYiYY "
        echo "    $Fi$$ .. ``:iii.`-\":YYYYY$$YY$$$$$YYYiiYiYYY    "
        echo "    :Y$$rb `````  `_..;;i;YYY$YY$$$$$$$YYYYYYYiYY:    "
        echo "     :$$$$$i;;iiiiidYYYYYYYYYY$$$$$$YYYYYYYiiYYYY. "
        echo "      `$$$$$$$YYYYYYYYYYYYY$$$$$$YYYYYYYYiiiYYYYYY    "
        echo "      .i!$$$$$$YYYYYYYYY$$$$$$YYY$$YYiiiiiiYYYYYYY    "
        echo "     :YYiii$$$$$$$YYYYYYY$$$$YY$$$$YYiiiiiYYYYYYi'    "
        echohl None
        echohl Title
        echo "  🎀  DOGELEENA — Neo-Agentic IDE  🎀"
        echohl None
        echo "  Press <leader>ac to summon AI. Much code. Such AI. Wow."
        echo ""
      ]])
    end)
  end,
})
