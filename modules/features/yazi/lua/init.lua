-- Get readable size of files.
function ya.readable_size(size)
  local units = {
    "B", "KiB", "MiB", "GiB", "TiB", "PiB",
    "EiB", "ZiB", "YiB", "RiB", "QiB",
  }
  -- Iterate until we found the appropriate units for the input `size`.
  local i = 1
	while size > 1000.0 and i < #units do
    size = size / 1000.0
    i = i + 1
	end
  -- Return the formatted size with the units.
  if size % 1 == 0 then
    return string.format("%.f %s", size, units[i])
  else
    return string.format("%.1f %s", size, units[i])
  end
end

-- Linemode:
function Linemode:size_and_mtime()
	local time = math.floor(self._file.cha.mtime or 0)
  if time == 0 then
		time = ""
	else
		time = os.date("%y/%m/%d  %H:%M", time)
	end

	local size = self._file:size()
	return string.format("%s -- %s",
    size and ya.readable_size(size) or "",
    time
  )
end
