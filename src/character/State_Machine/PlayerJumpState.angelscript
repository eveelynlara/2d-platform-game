class PlayerJumpState : PlayerBaseState
{
	private ETHPhysicsController@ m_rigidbody2D;

	PlayerJumpState(PlayerStateMachine@ currentContext, PlayerStateFactory@ playerStateFactory)
	{
		super(@currentContext, @playerStateFactory);
		@m_rigidbody2D = currentContext.GetPlayerController().GetPhysicsController();
		m_isRootState = true;
	}
	void EnterState() override {
		HandleJump();
	}
	void UpdateState() override {
		CheckSwitchStates();
	}
	void ExitState() override {
		ResetJumpCount();
	}
	void CheckSwitchStates() override {
		HandleJump();

		if(m_ctx.IsTouchingOnlyGround()){
			SwitchState(m_playerStateFactory.Grounded());
		}
	}
	void InitializeSubState() override {}
	void UpdateStates() override {
		
	}

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
		float jumpImpulse = m_ctx.GetPlayerController().GetPlayerInputController().GetDirection().y;

		if (jumpImpulse != 0.0f && currentJumpsInTheAir < 1)
		{
			m_rigidbody2D.SetLinearVelocity(vector2(m_rigidbody2D.GetLinearVelocity().x, jumpImpulse));
			currentJumpsInTheAir++;
			m_ctx.SetJumpsInTheAir(currentJumpsInTheAir);
		}	
	}
}