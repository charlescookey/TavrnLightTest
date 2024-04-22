-- Fixes
-- added checks to ensure player and party were valid
-- added variable memberToRemove to avoid creating a new player instance -> Player(membername)
-- used  for _, v in ..  to use 1 less varibale



function do_sth_with_PlayerParty(playerId, membername)
  local player = Player(playerId)
  
  if not player then
    print("Player not found")
    return
  end
  
  local party = player:getParty()

  if not party then
    print("Party not found")
    return
  end

  local members = party:getMembers()
  local memberToRemove = Player(membername)
  
  for _, v in pairs(members) do
    if v == memberToRemove then
      party:removeMember(v)
      break
    end
  end
end