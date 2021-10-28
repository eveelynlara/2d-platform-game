class DeathOnDamage : IDamageable
{
	void TakeDamage(int damage) override
	{
		print("toma dano");
	}
}