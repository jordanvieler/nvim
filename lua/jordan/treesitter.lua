local status_ok, configs = pcall(require, 'nvim-treesitter.configs')
if not status_ok then
  return
end

configs.setup {
  ensure_install = {'bash', 'lua', 'python', 'yaml'},
  sync_install = true,
  ignore_install = { '' },
  highlight = {
    enable = true,
    disable = { '' }
  },
  indent = {
    enable = true,
    disable = { '' }
  },
  rainbow = {
    enable = true,
    extended_mode = true,
    max_file_lines = nil
  }
}
