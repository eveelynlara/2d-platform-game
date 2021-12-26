class BasicSlashMeleeWeapon : IWeapon
{
	private IDamageable@ owner;
	private int damage = 2;
	Team@ currentWeaponTeam;

	BasicSlashMeleeWeapon(IDamageable@ attacker)
	{
		@owner = @attacker;
	}

	void Attack() override
	{
		ScheduleAttack();
	}

	void ScheduleAttack()
	{
		sef::util::scheduleEvent(30.0f, ScheduleAttackEvent(@this));
	}

	void RunWeaponAttack()
	{
		const vector2 offset = vector2(64.0f * (owner.GetPlayerController().GetLastMovementDir()), 10.0f);

		ETHEntity@ temporaryHitbox;
		Character@ ownerCharacter = cast<Character@>(owner);
		AddEntity("sword_hit.ent", vector3(ownerCharacter.GetPositionXY() + offset, 0.0f), 0.0f, temporaryHitbox, "basicSlashMeleeHitbox", 1.3f);
        
		owner.GetEntity().GetObject("currentTeam", @currentWeaponTeam);
		temporaryHitbox.SetObject("currentTeam", @currentWeaponTeam);
        temporaryHitbox.SetObject("attackerCharacter", @ownerCharacter);
		temporaryHitbox.SetObject("currentWeapon", @this);
	}

	void ApplyDamage(ETHEntity@ damagedObject)
	{
		ETHEntity@ damagedEntity = @damagedObject;
		
		Team@ damagedObjectTeam;
		damagedEntity.GetObject("currentTeam", @damagedObjectTeam);

		if (damagedObjectTeam !is currentWeaponTeam)
		{
			damagedEntity.AddToInt("hp", -10.0f);
			print(damagedEntity.GetInt("hp"));;
		}
	}
	
	void ApplyDamage(IDamageable@ damagedObject)
	{
		
	}

	IDamageable@ GetOwner()
	{
		return @owner;
	}
}

void ETHConstructorCallback_basicSlashMeleeHitbox(ETHEntity@ thisEntity)
{
    thisEntity.SetFloat("elapsedTime", 0.0f);
}

void ETHCallback_basicSlashMeleeHitbox(ETHEntity@ thisEntity)
{
    const float elapsedTime = thisEntity.AddToFloat("elapsedTime", sef::TimeManager.getLastFrameElapsedTimeF());
    if(elapsedTime >= 100.0f)
    {
        DeleteEntity(thisEntity);
    }
}

void ETHPreSolveContactCallback_basicSlashMeleeHitbox(
	ETHEntity@ thisEntity,
	ETHEntity@ other,
	vector2 contactPointA,
	vector2 contactPointB,
	vector2 contactNormal)
{
	Team@ damagedObjectTeam;
	Team@ attackerTeam;

	thisEntity.GetObject("currentTeam", @attackerTeam);
	thisEntity.GetObject("currentTeam", @damagedObjectTeam);

	if (damagedObjectTeam is attackerTeam)
	{
		DisableContact();
	}
}

void ETHBeginContactCallback_basicSlashMeleeHitbox(
    ETHEntity@ thisEntity,
    ETHEntity@ other,
    vector2 contactPointA,
    vector2 contactPointB,
    vector2 contactNormal)
{
	BasicSlashMeleeWeapon@ currentWeapon;
	thisEntity.GetObject("currentWeapon", @currentWeapon);
	currentWeapon.ApplyDamage(other);
}