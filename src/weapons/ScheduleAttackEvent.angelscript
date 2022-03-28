class ScheduleAttackEvent : sef::Event
{
	private IWeapon@ m_weapon;

	ScheduleAttackEvent(IWeapon@ weapon)
	{
		@m_weapon = @weapon;
	}

	void run()
	{
		m_weapon.RunWeaponAttack();
	}
}

