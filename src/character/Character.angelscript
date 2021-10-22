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

	void update()
	{
		playAnim.update();
	}

	vector2 GetPositionXY()
	{
		return playAnim.GetController().GetEntity().GetPositionXY();
	}

	PlayAnim@ GetPlayAnim()
	{
		return @playAnim;
	}

	bool IsDead() const
	{
		return (playAnim.GetController().GetEntity().GetInt("hp") <= 0);
	}

	void DestroyCharacterEntity()
	{
		if(playAnim.GetController().GetEntity()
			.GetInt("hp") <= 0)
		{
			DeleteEntity(playAnim.GetController().GetEntity());
		}
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