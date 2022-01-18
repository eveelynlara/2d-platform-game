class PlayerGroundedState : PlayerBaseState
{
	private ETHPhysicsController@ m_rigidbody2D;

	PlayerGroundedState(PlayerStateMachine@ currentContext, PlayerStateFactory@ playerStateFactory)
	{
		super(@currentContext, @playerStateFactory);
		@m_rigidbody2D = currentContext.GetPlayerController().GetPhysicsController();
		InitializeSubState();
		m_isRootState = true;
	}
	void EnterState() override {
	}
	void UpdateState() override {
		CheckSwitchStates();
	}
	void ExitState() override {}
	void InitializeSubState() override {
		if(m_ctx.GetPlayerController().GetPlayerInputController().GetDirection().x == 0)
		{
			SetSubState(m_playerStateFactory.Idle());
		}
		else if(m_ctx.GetPlayerController().GetPlayerInputController().GetDirection().x != 0)
		{
			SetSubState(m_playerStateFactory.Walk());
		}
	}
	void CheckSwitchStates() override 
	{
		//if player is grounded and jump is pressed, switch to jump state
		if(m_ctx.IsJumpPressed() && m_ctx.GetJumpsInTheAir() == 0)
		{
			SwitchState(m_playerStateFactory.Jump());
		}
	}
}

