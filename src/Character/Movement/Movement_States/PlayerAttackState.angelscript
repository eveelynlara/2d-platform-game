class PlayerAttackState : PlayerBaseState
{
	private ETHPhysicsController@ m_rigidbody2D;
	private bool m_isAttacking;

	PlayerAttackState(PlayerStateMachine@ currentContext, PlayerStateFactory@ playerStateFactory)
	{
		super(@currentContext, @playerStateFactory);
		@m_rigidbody2D = currentContext.GetPlayerController().GetPhysicsController();
		m_isRootState = true;
	}
	void EnterState() override {
		m_isAttacking = true;
		InitializeSubState();
	}
	void UpdateState() override {
		CheckSwitchStates();
	}
	void ExitState() override {
		m_isAttacking = false;
	}
	void InitializeSubState() override {

	}
	void CheckSwitchStates() override 
	{
		if(m_ctx.IsTouchingOnlyGround()){
			SwitchState(m_playerStateFactory.Grounded());
		}
		else if(m_ctx.IsJumpPressed() && m_ctx.GetJumpsInTheAir() == 0)
		{
			SwitchState(m_playerStateFactory.Jump());
		}
	}
	string GetStateName()
	{
		return "Attack";
	}	
}

