class PlayerGroundedState : PlayerBaseState
{
	PlayerGroundedState(PlayerStateMachine@ currentContext, PlayerStateFactory@ playerStateFactory)
	{
		super(@currentContext, @playerStateFactory);
	}
	void EnterState() override {
		//hit the floor, reset jumps in the air
		print("\nEnhaiii\n");
		m_ctx.SetJumpsInTheAir(0);
	}
	void UpdateState() override {
		CheckSwitchStates();
	}
	void ExitState() override {}
	void InitializeSubState() override {}
	void CheckSwitchStates() override {
		//if player is grounded and jump is pressed, switch to jump state
		if (m_ctx.IsJumpPressed()){print("pulei");}

		if(m_ctx.IsJumpPressed())
		{
			SwitchState(m_playerStateFactory.Jump());
		}
	}
}