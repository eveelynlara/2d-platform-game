class PlayerJumpState : PlayerBaseState
{
	private ETHPhysicsController@ m_rigidbody2D;

	PlayerJumpState(PlayerStateMachine@ currentContext, PlayerStateFactory@ playerStateFactory)
	{
		super(@currentContext, @playerStateFactory);
		@m_rigidbody2D = currentContext.GetPlayerController().GetPhysicsController();
	}
	void EnterState() override {
		print("Oie! Estou no Jump State!");
		HandleJump();
	}
	void UpdateState() override {
		HandleJump();
	}
	void ExitState() override {
		HandleJump();
	}
	void CheckSwitchStates() override {

	}
	void InitializeSubState() override {}
	void UpdateStates() override {}
	void SwitchState(PlayerBaseState@ newState) override {}
	void SetSuperState() override {}
	void SetSubState() override {}

	void HandleJump()
	{
		//TODO: animate character
		// int currentJumpsInTheAir = m_ctx.GetJumpsInTheAir();
		// float newVelocityY = m_ctx.GetPlayerController().GetPlayerInputController().GetDirection().y;

		// if(m_ctx.GetJumpsInTheAir() < 1){
		// 	m_ctx.SetJumpsInTheAir(currentJumpsInTheAir++);
		// }
		// else
		// {
		// 	m_ctx.SetVelocityY(m_rigidbody2D.GetLinearVelocity().y);
		// 	newVelocityY = m_ctx.GetVelocityY();
		// }

		// float currentSpeed = m_ctx.GetMovementSpeed();
		// float currentDirectionX = m_ctx.GetPlayerController().GetPlayerInputController().GetDirection().x;

		// m_rigidbody2D.SetLinearVelocity(vector2(currentSpeed * currentDirectionX, newVelocityY));

		int currentJumpsInTheAir = m_ctx.GetJumpsInTheAir();
		float newVelocityY = m_ctx.GetPlayerController().GetPlayerInputController().GetDirection().y;

		bool isJumping = m_ctx.GetPlayerController().GetPlayerInputController().GetDirection().y < 0;

		m_ctx.SetMovementSpeed(sef::TimeManager.unitsPerSecond(300.0f));

		if(isJumping && m_ctx.GetJumpsInTheAir() < 1){
			currentJumpsInTheAir++;
			m_ctx.SetJumpsInTheAir(currentJumpsInTheAir);
		}
		else
		{
			newVelocityY = m_rigidbody2D.GetLinearVelocity().y;
			
			if (m_ctx.IsTouchingOnlyGround())
			{
				m_ctx.SetJumpsInTheAir(0);
			}
		}

		m_rigidbody2D.SetLinearVelocity(vector2(m_ctx.GetMovementSpeed() * m_ctx.GetPlayerController().GetPlayerInputController().GetDirection().x, newVelocityY));
		
	}
}