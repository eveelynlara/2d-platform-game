class DamageParams
{
    IDamageable@ Attacker;
    IWeapon@ Weapon;
    int Damage;

    DamageParams(IDamageable@ Attacker, IWeapon@ Weapon, int Damage)
    {
        @this.Attacker = @Attacker;
        @this.Weapon = @Weapon;
        this.Damage = Damage;
    }
}

interface IDamageable
{
    void TakeDamage(DamageParams@ damageParams);
    bool CanBeDamagedBy(IDamageable@ other, IWeapon@ otherWeapon);
}