class PlayerJumpState : PlayerBaseState
{
	private ETHPhysicsController@ m_rigidbody2D;

	PlayerJumpState(PlayerStateMachine@ currentContext, PlayerStateFactory@ playerStateFactory)
	{
		super(@currentContext, @playerStateFactory);
		@m_rigidbody2D = currentContext.GetPlayerController().GetPhysicsController();
	}
	void EnterState() override {
		ResetJumpCount();
		HandleJump();
	}
	void UpdateState() override {
		CheckSwitchStates();
	}
	void ExitState() override {
	}
	void CheckSwitchStates() override {
		HandleJump();
	}
	void InitializeSubState() override {}
	void UpdateStates() override {}
	void SetSuperState() override {}
	void SetSubState() override {}

	void ResetJumpCount()
	{
		m_ctx.SetJumpsInTheAir(0);
	}

	void HandleJump()
	{
		//TODO: animate character
		int currentJumpsInTheAir = m_ctx.GetJumpsInTheAir();
		float movementSpeed = m_ctx.GetMovementSpeed();
		float directionInputController = m_ctx.GetPlayerController().GetPlayerInputController().GetDirection().x;
		bool isTouchingGround = m_ctx.GetPlayerController().isTouchingOnlyGround();
		float jumpImpulse = m_ctx.GetPlayerController().GetPlayerInputController().GetDirection().y;

		if (jumpImpulse != 0.0f && currentJumpsInTheAir < 1)
		{
			m_rigidbody2D.SetLinearVelocity(vector2(m_rigidbody2D.GetLinearVelocity().x, jumpImpulse));
			currentJumpsInTheAir++;
			m_ctx.SetJumpsInTheAir(currentJumpsInTheAir);
		}	

		if(isTouchingGround)
		{
			SwitchState(m_playerStateFactory.Grounded());
		}
	}
}