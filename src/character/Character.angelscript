class Character : IDamageable, ITeamMember
{
	private ETHEntity@ characterEntity;
	private MoveVelocityController@ moveVelocityController;
	private Team@ currentTeam;
	private IWeapon@ currentEquippedWeapon;

	Character(const string &in characterEntityName, const vector2 pos, int controllerType = 0)
	{
		// add character entity and rename it to "Character" for matching character-
		// specific entity callback functions
		LoadSoundEffect("soundfx/explosion_small.mp3");
		AddEntity(characterEntityName, vector3(pos, -2.0f), 0.0f /*rotation*/, characterEntity, "Character",  1.0f /*scale*/);
		@moveVelocityController = MoveVelocityController(@this, controllerType);
		SetWeapon(BasicSlashMeleeWeapon(@this));
	}

	void update()
	{
		moveVelocityController.update();
	}

	void SetTeam(Team@ team)
	{
		@currentTeam = @team;
		characterEntity.SetObject("currentTeam", @currentTeam);
	}

	Team@ GetTeam()
	{
		return @currentTeam;
	}

	void SetWeapon(IWeapon@ weapon)
	{
		@currentEquippedWeapon = @weapon;
	}

	IWeapon@ GetEquippedWeapon()
	{
		return @currentEquippedWeapon;
	}

	ETHEntity@ GetEntity()
	{
		return @characterEntity;
	}

	vector2 GetPositionXY()
	{
		return characterEntity.GetPositionXY();
	}

	MoveVelocityController@ GetMoveVelocityController()
	{
		return @moveVelocityController;
	}

	bool IsDead() const
	{
		return (characterEntity.GetInt("hp") <= 0);
	}

	void DestroyCharacterEntity()
	{
		if(characterEntity.GetInt("hp") <= 0)
		{
			DeleteEntity(characterEntity);
		}
	}

	bool CanBeDamagedBy(IDamageable@ other, IWeapon@ otherWeapon)
	{
		return !currentTeam.IsInTeam(cast<ITeamMember@>(other));
	}
}	

int calcIsTouchingWall(vector2 normalForce)
{
	return abs(sef::math::dot(normalForce, vector2(1,0))) > 0.1 ? 1 : 0;
}

void ETHConstructorCallback_Character(
	ETHEntity@ body,
	ETHEntity@ other,
	vector2 contactPointA,
	vector2 contactPointB,
	vector2 contactNormal)
{
	body.SetInt("hp", 100);
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
