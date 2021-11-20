class Character
{
	private MoveVelocity@ moveVelocity;

	Character(const string &in entityName, const vector2 pos, int controllerType = 0)
	{
		// add character entity and rename it to "Character" for matching character-
		// specific entity callback functions
		LoadSoundEffect("soundfx/explosion_small.mp3");
		@moveVelocity = MoveVelocity(entityName, pos, controllerType);
	}

	void update()
	{
		moveVelocity.update();
	}

	vector2 GetPositionXY()
	{
		return moveVelocity.GetEntity().GetPositionXY();
	}

	MoveVelocity@ GetMoveVelocity()
	{
		return @moveVelocity;
	}

	bool IsDead() const
	{
		return (moveVelocity.GetEntity().GetInt("hp") <= 0);
	}

	void DestroyCharacterEntity()
	{
		if(moveVelocity.GetEntity().GetInt("hp") <= 0)
		{
			DeleteEntity(moveVelocity.GetEntity());
		}
	}
}	

int calcIsTouchingWall(vector2 normalForce)
{
	return abs(sef::math::dot(normalForce, vector2(1,0))) > 0.1 ? 1 : 0;
}

void ETHPreSolveContactCallback_Character(
	ETHEntity@ body,
	ETHEntity@ other,
	vector2 contactPointA,
	vector2 contactPointB,
	vector2 contactNormal)
{
	//quando inicia a colisao
	const float charBodyHeight = body.GetCollisionBox().size.y * body.GetScale().y;
	const float halfCharBodyHeight = charBodyHeight / 2.0f;
	float halfCharBodyHeightWithTolerance = body.GetPositionY() + (halfCharBodyHeight * 0.8f);

	abs(contactNormal.x) > 0.1 ? body.SetUInt("isTouchingWall", calcIsTouchingWall(contactNormal)) : body.SetUInt("isTouchingWall", 0);

	if (contactPointA.y > halfCharBodyHeightWithTolerance && body.GetUInt("isTouchingWall") == 0)
	{
		body.SetUInt("touchingOnlyGroundTime", GetTime());
	}
}