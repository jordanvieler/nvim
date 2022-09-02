-- bootstrap packer
local fn = vim.fn
local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
  PACKER_BOOTSTRAP = fn.system(
      {'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path}
    )
  print "Installing packer close and reopen Neovim"
  vim.cmd [[packadd packer.nvim]]
end

-- protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
  return
end

-- custom packer init functions
packer.init{
  display = {
    open_fn = function()
      return require("packer.util").float { border = "double" }
    end
  }

}

return packer.startup(function(use)
  -- have packer manage itself
  use "wbthomason/packer.nvim"

  -- catpuccin colorscheme
  use { "catppuccin/nvim", as = "catppuccin" }

  -- lsp
  use "neovim/nvim-lspconfig"

  -- completions
  use "hrsh7th/nvim-cmp"
  use "hrsh7th/cmp-nvim-lsp"
  use "hrsh7th/cmp-buffer"
  use "hrsh7th/cmp-path"
  use "L3MON4D3/LuaSnip"
  use "saadparwaiz1/cmp_luasnip"

  -- treesitter
  use {
    "nvim-treesitter/nvim-treesitter",
    run = ":TSUpdate"
  }
  use "p00f/nvim-ts-rainbow"
  -- Automatically set up your configuration after cloning packer.nvim
  if PACKER_BOOTSTRAP then
    require('packer').sync()
  end
end)
