local function paste()
  if vim.opt.paste:get() then
    return "PASTE"
  else
    return ""
  end
end

local function readonly()
  if vim.opt.readonly:get() then
    return "%R"
  else
    return ""
  end
end

local function modified()
  if vim.opt.modified:get() or not vim.opt.modifiable:get() then
    return "%M"
  else
    return ""
  end
end

require("lualine").setup({
  options = {
    icons_enabled = false,
    component_separators = "|",
    section_separators = "",
    globalstatus = true,
  },
  sections = {
    lualine_a = { "mode", paste },
    lualine_b = { "diagnostics" },
    lualine_c = {
      readonly,
      {
        "filename",
        file_status = false,
      },
      modified,
    },
    lualine_x = { "fileformat", "encoding", "filetype" },
    lualine_y = { "%3p%%" },
    lualine_z = { "location" },
  },
  inactive_sections = {},
})
