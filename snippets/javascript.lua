local ls = require("luasnip")
local s = ls.snippet
local i = ls.insert_node
local f = ls.function_node
local fmt = require("luasnip.extras.fmt").fmt

-- "my-component" / "my_component" / "myComponent" → "MyComponent"
local function filename_pascal()
  local name = vim.fn.expand("%:t:r")
  if name == "" then
    return "Component"
  end
  name = name:gsub("[-_]+(%w)", function(c)
    return c:upper()
  end)
  name = name:gsub("^%l", string.upper)
  return name
end

return {
  -- clg → console.log('<var>:', <var>); — label mirrors the value as you type
  s(
    "clg",
    fmt("console.log('{}:', {});", {
      f(function(args)
        return args[1][1] or ""
      end, { 1 }),
      i(1, "value"),
    })
  ),

  -- clgs → console.log with JSON.stringify for object inspection
  s(
    "clgs",
    fmt("console.log('{}', JSON.stringify({}, null, 2))", {
      i(1),
      i(2),
    })
  ),

  -- today → inserts current date, recomputed each expansion
  s(
    "today",
    f(function()
      return os.date("%Y-%m-%d")
    end)
  ),

  -- time → inserts current time (HH:MM:SS), recomputed each expansion
  s(
    "time",
    f(function()
      return os.date("%H:%M:%S")
    end)
  ),

  -- fc → React functional component, name derived from filename
  s(
    "fc",
    fmt(
      [[
export default function {}() {{
	return (
		<div>{}</div>
	);
}}
]],
      {
        f(filename_pascal),
        i(1),
      }
    )
  ),

  -- wlog → wraps the visually-selected text in console.log()
  -- Usage: visually select code, press <Tab>, type "wlog", press <Tab>
  s(
    "wlog",
    fmt("console.log({})", {
      f(function(_, snip)
        return snip.env.LS_SELECT_RAW
      end, {}),
    })
  ),

  -- tc → wraps the visually-selected text in try/catch
  s(
    "tc",
    fmt(
      [[
try {{
	{}
}} catch (err) {{
	console.error(err);
}}]],
      {
        f(function(_, snip)
          return snip.env.LS_SELECT_DEDENT
        end, {}),
      }
    )
  ),
}
