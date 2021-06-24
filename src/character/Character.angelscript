class Character
{
	private ETHEntity@ m_entity;
	ETHPhysicsController@ physicsController;
	MoveVelocity@ moveVelocity = MoveVelocity();

	private sef::FrameTimer m_frameTimer;

	Character(const string &in entityName, const vector2 pos)
	{
		// add character entity and rename it to "character" for matching character-
		// specific entity callback functions
		AddEntity(entityName, vector3(pos, -2.0f), 0.0f /*rotation*/, m_entity, "Character", 1.0f /*scale*/);
		LoadSoundEffect("soundfx/explosion_small.mp3");
		@physicsController = m_entity.GetPhysicsController();
		moveVelocity.SetPhysicsController(@physicsController);
	}

	vector2 GetPositionXY()
	{
		return m_entity.GetPositionXY();
	}

	void update ()
	{
		moveVelocity.update();
	}
}	