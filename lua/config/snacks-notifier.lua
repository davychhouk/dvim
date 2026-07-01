local ignore = {
  -- DeltaView messages
  ["File and Cursor synced."] = true,
  ["File synced, entering at top of file."] = true,
  -- Snacks
  ["No results found for notifications"] = true,
}

return {
  enabled = true,
  filter = function(notif)
    return not ignore[notif.msg]
  end,
}
