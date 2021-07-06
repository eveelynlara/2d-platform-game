class Character
{
	private ETHEntity@ m_entity;
	private ETHPhysicsController@ physicsController;
	private MoveVelocity@ moveVelocity = MoveVelocity();
	private PlayAnim@ playAnim = PlayAnim();

	Character(const string &in entityName, const vector2 pos)
	{
		// add character entity and rename it to "Character" for matching character-
		// specific entity callback functions
		AddEntity(entityName, vector3(pos, -2.0f), 0.0f /*rotation*/, m_entity, "Character", 1.0f /*scale*/);
		LoadSoundEffect("soundfx/explosion_small.mp3");
		@physicsController = m_entity.GetPhysicsController();
		moveVelocity.SetPhysicsController(@physicsController);
		playAnim.SetCharacterToBeAnimated(@this);
	}

	void update ()
	{
		moveVelocity.update();
		playAnim.update();
	}

	vector2 GetPositionXY()
	{
		return m_entity.GetPositionXY();
	}

	ETHEntity@ GetEntity()
	{
		return @m_entity;
	}

	MoveVelocity@ GetMoveVelocity()
	{
		return @moveVelocity;
	}

	bool isTouchingGround()
	{
		// if the last time a ground touch had been detected was over a few
		// milliseconds ago, we assume it is no longer touching the ground 
		bool isTouchingGround = ((GetTime() - m_entity.GetUInt("touchingGroundTime")) < 120);
		return isTouchingGround;
	}
}	

void ETHPreSolveContactCallback_Character(
	ETHEntity@ body,
	ETHEntity@ other,
	vector2 contactPointA,
	vector2 contactPointB,
	vector2 contactNormal)
{
	const float charBodyHeight = body.GetCollisionBox().size.y * body.GetScale().y;
	const float halfCharBodyHeight = charBodyHeight / 2.0f;

	// if the contact is near the bottom of the character's body,
	// we can assume it's their feet so he might be touching ground
	if (contactPointA.y > body.GetPositionY() + (halfCharBodyHeight * 0.8f))
	{
		body.SetUInt("touchingGroundTime", GetTime());
	}
}