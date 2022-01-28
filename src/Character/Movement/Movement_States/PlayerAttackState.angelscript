class PlayerAttackState : PlayerBaseState
{
	private ETHPhysicsController@ m_rigidbody2D;
	private bool m_combo;

	PlayerAttackState(PlayerStateMachine@ currentContext, PlayerStateFactory@ playerStateFactory)
	{
		super(@currentContext, @playerStateFactory);
		@m_rigidbody2D = currentContext.GetPlayerController().GetPhysicsController();
		m_isRootState = true;
	}
	void EnterState() override {
		InitializeSubState();
	}
	void UpdateState() override {
		HandleAttack();
	}
	void ExitState() override {
	}
	void InitializeSubState() override {

	}

	void HandleAttack()
	{
		HandleAttacknimation();
		
		if(m_ctx.GetAnimationController().GetCurrentAnimationState().IsAnimationFisnished())
		{
			m_ctx.GetAnimationController().GetCurrentAnimationState().ResetAnimation();
			CheckSwitchStates();
		}
	}

	void HandleAttacknimation()
	{
		m_ctx.GetAnimationController().SwitchState(m_ctx.GetAnimationController().basicSwordAttackState);
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

