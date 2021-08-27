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

int calcIsTouchingGround(float otherY, float bodyY, float charBodyHeight)
{
	return otherY - bodyY < charBodyHeight * 1.2 ? 1 : 0;
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
	body.SetUInt("touchingGround", calcIsTouchingGround(other.GetPositionY(), body.GetPositionY(), charBodyHeight));
}

void ETHEndContactCallback_Character(
	ETHEntity@ body,
	ETHEntity@ other,
	vector2 contactPointA,
	vector2 contactPointB,
	vector2 contactNormal)
{
	//quando acaba a colisao
	const float charBodyHeight = body.GetCollisionBox().size.y * body.GetScale().y;
	body.SetUInt("touchingGround", calcIsTouchingGround(other.GetPositionY(), body.GetPositionY(), charBodyHeight));
}