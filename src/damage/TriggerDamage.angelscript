class TriggerDamage
{
	IDamageable@ damageable; 
	
	TriggerDamage(IDamageable@ damageable)
	{
		@this.damageable = @damageable;
	}
}

void ETHBeginContactCallback_Character(
ETHEntity@ thisEntity,
ETHEntity@ other,
vector2 contactPointA,
vector2 contactPointB,
vector2 contactNormal)
{
	const int damage = 10;

	if(thisEntity.GetInt("isDamageable") == 1)
	{
		print("it can take damage");
	}
}