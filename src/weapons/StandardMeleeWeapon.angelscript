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

void ETHBeginContactCallback_basicSlashMeleeHitbox(
    ETHEntity@ thisEntity,
    ETHEntity@ other,
    vector2 contactPointA,
    vector2 contactPointB,
    vector2 contactNormal)
{
	// Character@ attacker;
	// thisEntity.GetObject("attacker", @attacker);

	// Team@ currentAttackerTeam;
	// thisEntity.GetObject("currentTeam", @currentAttackerTeam);
	
	// print(currentAttackerTeam.GetTeamName());
}