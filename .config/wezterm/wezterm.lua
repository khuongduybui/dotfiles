local table = require 'table'
local wezterm = require 'wezterm'
local action = wezterm.action
local gui = wezterm.gui

function scheme_for_appearance()
  local appearance = gui.get_appearance()
  if appearance:find 'Dark' then
    -- return "Ivory Dark (terminal.sexy)"
    -- return "nightfox"
    return "Catppuccin Mocha"
  else
    -- return "Ivory Light (terminal.sexy)"
    -- return "dayfox"
    return "Catppuccin Latte"
  end
end

return {
  mouse_bindings = {
    { event={Down={streak=3, button="Left"}},
      action=wezterm.action.SelectTextAtMouseCursor("SemanticZone"),
      mods="NONE",
    },
  },

  keys = {
    {key="UpArrow", mods="CTRL", action=action.ScrollToPrompt(-1)},
    {key="DownArrow", mods="CTRL", action=action.ScrollToPrompt(1)},
    {key="d", mods="ALT|SHIFT", action=action.SplitHorizontal { domain = 'CurrentPaneDomain' }}
  },

  font = wezterm.font("Cascadia Code PL"),

  color_scheme = scheme_for_appearance(),
}
