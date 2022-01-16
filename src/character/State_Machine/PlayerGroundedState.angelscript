class PlayerGroundedState : PlayerBaseState
{
	private ETHPhysicsController@ m_rigidbody2D;

	PlayerGroundedState(PlayerStateMachine@ currentContext, PlayerStateFactory@ playerStateFactory)
	{
		super(@currentContext, @playerStateFactory);
		@m_rigidbody2D = currentContext.GetPlayerController().GetPhysicsController();
	}
	void EnterState() override {
	}
	void UpdateState() override {
		CheckSwitchStates();
	}
	void ExitState() override {}
	void InitializeSubState() override {}
	void CheckSwitchStates() override {
		//if player is grounded and jump is pressed, switch to jump state

		// float movementSpeed = m_ctx.GetMovementSpeed();
		// float directionInputController = m_ctx.GetPlayerController().GetPlayerInputController().GetDirection().x;

		// m_rigidbody2D.SetLinearVelocity(vector2(movementSpeed * directionInputController, m_rigidbody2D.GetLinearVelocity().y));

		if(m_ctx.IsJumpPressed())
		{
			SwitchState(m_playerStateFactory.Jump());
		}
	}
}