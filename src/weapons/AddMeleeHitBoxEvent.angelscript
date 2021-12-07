class AddMeleeHitBoxEvent : sef::Event
{
	private ETHEntity@ m_attacker;
	private MoveVelocityController@ m_moveVelocityController;

	AddMeleeHitBoxEvent(MoveVelocityController@ moveVelocityFromAttacker)
	{
		@m_moveVelocityController = @moveVelocityFromAttacker;
		@m_attacker = @moveVelocityFromAttacker.GetEntity();
	}

	void run()
	{
		Team@ currentAttackerTeam;
		m_attacker.GetObject("currentTeam", @currentAttackerTeam);
		
		const vector2 offset = vector2(64.0f * (m_moveVelocityController.GetLastMovementDir()), 10.0f);

		ETHEntity@ m_hitbox;
		AddEntity("sword_hit.ent", vector3(m_attacker.GetPositionXY() + offset, 0.0f), 0.0f, m_hitbox, "basicSlashMeleeHitbox", 1.3f);
        
		m_hitbox.SetObject("currentTeam", @currentAttackerTeam);
        m_hitbox.SetObject("attacker", @m_attacker);
	}
}

