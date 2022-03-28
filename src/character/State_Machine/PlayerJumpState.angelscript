class PlayerJumpState : PlayerBaseState
{
	private ETHPhysicsController@ m_rigidbody2D;
	private float m_jumpElapsedTime;

	PlayerJumpState(PlayerStateMachine@ currentContext, PlayerStateFactory@ playerStateFactory)
	{
		super(@currentContext, @playerStateFactory);
		@m_rigidbody2D = currentContext.GetPlayerController().GetPhysicsController();
		m_isRootState = true;
	}
	void EnterState() override {
		InitializeSubState();
		HandleJump();
	}
	void UpdateState() override {
		// print(GetStateName());
		HandleJump();
		CheckSwitchStates();
	}
	void ExitState() override {
		ResetJumpCount();
	}
	void CheckSwitchStates() override {
		
		if(m_ctx.IsTouchingOnlyGround() && m_jumpElapsedTime > 160.0f){
			SwitchState(m_playerStateFactory.Grounded());
		}
	}
	void InitializeSubState() override {}

	void ResetJumpCount()
	{
		m_ctx.SetJumpsInTheAir(0);
	}
	string GetStateName() override
	{
		return "state name is: Jump";
	}

	void HandleJump()
	{
		//TODO: animate character
		int currentJumpsInTheAir = m_ctx.GetJumpsInTheAir();
		float movementSpeed = m_ctx.GetMovementSpeed();
		float directionInputController = m_ctx.GetPlayerController().GetPlayerInputController().GetDirection().x;
		float jumpImpulse = m_ctx.GetPlayerController().GetPlayerInputController().GetDirection().y;

		m_jumpElapsedTime += sef::TimeManager.getLastFrameElapsedTimeF();

		if (jumpImpulse != 0.0f && currentJumpsInTheAir < 2)
		{
			m_rigidbody2D.SetLinearVelocity(vector2(m_rigidbody2D.GetLinearVelocity().x, jumpImpulse));
			currentJumpsInTheAir++;
			m_ctx.SetJumpsInTheAir(currentJumpsInTheAir);
		}
	}
}