void ETHCallback_Spawner(ETHEntity@ thisEntity)
{
	if (sef::math::isWorldSpacePointInScreenWithTolerance(thisEntity.GetPositionXY(), vector2(128.0f, 64.0f)))
    {   
		CheckDataType(@thisEntity);		
    }
	DeleteEntity(thisEntity);
}

void CheckDataType(ETHEntity@ thisEntity)
{
	GameState@ myGameScene = cast<GameState>(sef::StateManager.getCurrentState());
	
	if (myGameScene is null)
	{
		print("Erro: aparentemente a cena atual não é GameScene. Talvez seja MainMenuScene?");
		return;
	}

	if(thisEntity.GetString("EntityType") == "character")
	{
	// 	print("e um character");
		CharactersManager@ charactersManager = myGameScene.GetCharactersManager();
		Character@ newCharacter;

		//if main character
		@newCharacter = Character("warrior.ent", thisEntity.GetPositionXY(), 0);
		charactersManager.addCharacter(@newCharacter);
	}
}