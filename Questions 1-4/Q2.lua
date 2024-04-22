-- Fixes
-- added a check to ensure resultId was valid
-- used a lopp to ensire it prints name of all guilds


function printSmallGuildNames(memberCount)
  local selectGuildQuery = string.format("SELECT name FROM guilds WHERE max_members < %d;", memberCount)
  local resultId = db.storeQuery(selectGuildQuery)
  if not resultId then
      print("Failed to execute query")
      return
  end
  repeat
      local guildName = result.getString(resultId, "name")
      print(guildName)
  until not result.next(resultId)

  result.free(resultId)
end