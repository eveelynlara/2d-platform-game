interface IDamageable
{
    bool CanBeDamagedBy(IDamageable@ other, IWeapon@ otherWeapon);
    ETHEntity@ GetEntity();
    PlayerController@ GetPlayerController();
}