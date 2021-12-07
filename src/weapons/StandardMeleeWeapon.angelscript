class BasicSlashMeleeWeapon : IWeapon
{
	private IDamageable@ owner; //preciso de uma ref do character aqui
	private int damage = 2;

	void Attack(IDamageable@ damagedObject) override
	{
		// sef::util::scheduleEvent(10, sef::util::scheduleEvent(20.0f, AddMeleeHitBoxEvent(MoveVelocityController@ ...));

		IDamageable@ damaged = @damagedObject;
		DamageParams@ BasicSlashMeleeWeaponParams = DamageParams(@owner, @this, damage);

		if(damaged.CanBeDamagedBy(@owner, @this))
		{
			damaged.TakeDamage(@BasicSlashMeleeWeaponParams);
		}

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
	ETHEntity@ attacker;
	thisEntity.GetObject("attacker", @attacker);

	Team@ attackerTeam;
	Team@ damagedObjectTeam;
	thisEntity.GetObject("currentTeam", @attackerTeam);
	other.GetObject("currentTeam", @damagedObjectTeam);

	if (damagedObjectTeam !is attackerTeam)
	{
		print(damagedObjectTeam.GetTeamName());;
	}
}