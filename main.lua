local ffi = require('ffi')
local tb = require('termbox')
tb.tb_init()


local function write(string, x, y, fg, bg)
  local i, l = 1, #string
  local uni = ffi.new("uint32_t[1]")
  local char = ffi.new("char[1]")
  while i <= l do
    char[0] = string:byte(i)
    i = i + tb.tb_utf8_char_to_unicode(uni, char)
    tb.tb_change_cell(x, y, uni[0], fg, bg)
    x = x + 1
  end
end

tb.tb_select_output_mode(tb.TB_OUTPUT_216)
local event = ffi.new("struct tb_event")
local j = 0
local space  = "                   "
local banner = " Press ESC to Exit "
repeat
  local width, height = tb.tb_width(), tb.tb_height()
  tb.tb_clear()
  for y = 0, height - 1 do
    for x = 0, width - 1 do
      local color = (j + x + y * width) % 216 + 0x10
      tb.tb_change_cell(x, y, 48, color, 0)
    end
  end
  local ox = math.floor((width - #banner) / 2)
  local oy = math.floor((height - 3) / 2)
  write(space,  ox, oy, 8, j)
  write(banner, ox, oy + 1, 8, j)
  write(space,  ox, oy + 2, 8, j)
  tb.tb_present()
  tb.tb_peek_event(event, 13)
  j = (j + 1) % 216
until event.key == 27 and event.type == 1


tb.tb_shutdown()


