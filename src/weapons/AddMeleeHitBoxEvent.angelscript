class AddMeleeHitBoxEvent : sef::Event
{
	// preciso ter uma ref do character aqui
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

		ETHEntity@ hitbox;
		AddEntity("sword_hit.ent", vector3(m_attacker.GetPositionXY() + offset, 0.0f), 0.0f, hitbox, "basicSlashMeleeHitbox", 1.3f);
        
        hitbox.SetObject("attacker", @m_attacker);
	}
}

