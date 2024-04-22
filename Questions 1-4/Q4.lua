--Fixes
-- a good practice is using Unique pointers as it would deallocate the associated memoory
-- hence avoiding a data leak

void Game::addItemToPlayer(const std::string& recipient, uint16_t itemId)
{
	std::unique_ptr<Player> player = g_game.getPlayerByName(recipient);
	if (!player) {
		player.reset( new Player(nullptr));
		if (!IOLoginData::loadPlayerByName(player.get(), recipient)) {
			return;
		}
	}

	std::unique_ptr<Item> item (Item::CreateItem(itemId));
	if (!item) {
		return;
	}

	g_game.internalAddItem(player->getInbox(), item.get(), INDEX_WHEREEVER, FLAG_NOLIMIT);

	if (player->isOffline()) {
		IOLoginData::savePlayer(player.get());
	}
}