local system = {}

-- Return the specific path of the specified command
function system.get_shell_path(cmd)
  -- 'command -v' is a POSIX standard, generally better than 'which'
  local handle = io.popen(string.format("command -v %s", cmd))
  if handle then
    local result = handle:read("*a")
    handle:close()
    -- Trim whitespace/newlines from the result
    result = result:gsub("%s+", "")
    if result ~= "" then
      return result
    end
  end
  -- Fallback if the requested command isn't found
  return nil
end

return system
