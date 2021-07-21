class Character
{
	private PlayAnim@ playAnim;

	Character(const string &in entityName, const vector2 pos, int movementType = 0)
	{
		// add character entity and rename it to "Character" for matching character-
		// specific entity callback functions
		LoadSoundEffect("soundfx/explosion_small.mp3");
		@playAnim = PlayAnim(entityName, pos, movementType);
	}

	void update ()
	{
		playAnim.update();
	}

	vector2 GetPositionXY()
	{
		return playAnim.GetMoveVelocity().GetEntity().GetPositionXY();
	}

	PlayAnim@ GetPlayAnim()
	{
		return @playAnim;
	}

	bool IsDead() const
	{
		return (playAnim.GetMoveVelocity().GetEntity().GetInt("hp") <= 0);
	}

	void DestroyCharacterEntity()
	{
		if(playAnim.GetMoveVelocity().GetEntity()
			.GetInt("hp") <= 0)
		{
			DeleteEntity(playAnim.GetMoveVelocity().GetEntity());
		}
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