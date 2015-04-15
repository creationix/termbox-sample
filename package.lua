return {
  name = "rainbows",
  version = "0.0.0",
  private = true,
  luvi = {
    flavor = "tiny",
    version = "1.1.0"
  },
  dependencies = {
    "luvit/require",
    "luvit/pretty-print",
    "creationix/termbox",
  },
  files = {
  "*.lua",
  }
}
