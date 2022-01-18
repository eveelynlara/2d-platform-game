  class PlayerWalkState : PlayerBaseState
{
	private ETHPhysicsController@ m_rigidbody2D;

	PlayerWalkState(PlayerStateMachine@ currentContext, PlayerStateFactory@ playerStateFactory)
	{
		super(@currentContext, @playerStateFactory);
		@m_rigidbody2D = currentContext.GetPlayerController().GetPhysicsController();
	}
	void EnterState() override {
	}
	void UpdateState() override {
		CheckSwitchStates();
	}
	void ExitState() override {
	}
	void CheckSwitchStates() override {
		if(m_ctx.GetPlayerController().GetPlayerInputController().GetDirection().x == 0)
		{
			SetSubState(m_playerStateFactory.Idle());
		}			
	}
	void InitializeSubState() override {}
	void UpdateStates() override {}
	void SetSuperState(PlayerBaseState@ newSuperState) override {}
	void SetSubState(PlayerBaseState@ newSubState) override {}
}