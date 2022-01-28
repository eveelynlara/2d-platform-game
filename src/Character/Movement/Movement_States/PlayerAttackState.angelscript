class PlayerAttackState : PlayerBaseState
{
	private ETHPhysicsController@ m_rigidbody2D;
	private int m_combo;
	private bool m_firstHit;
	private bool m_canDoCombo;

	PlayerAttackState(PlayerStateMachine@ currentContext, PlayerStateFactory@ playerStateFactory)
	{
		super(@currentContext, @playerStateFactory);
		@m_rigidbody2D = currentContext.GetPlayerController().GetPhysicsController();
		m_isRootState = true;
	}
	void EnterState() override {
		m_firstHit = true;
		m_canDoCombo = true;
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
		if(m_ctx.IsAttackPressed())
		{
			m_combo++;
		}

		HandleAttackAnimation();
	}

	void HandleAttackAnimation()
	{
		if(m_firstHit)
		{	
			m_ctx.GetAnimationController().SwitchState(m_ctx.GetAnimationController().basicSwordAttackState);
			m_firstHit = false;
		}
		else if(m_ctx.GetAnimationController().GetCurrentAnimationState().IsAnimationFisnished())
		{
			if(m_combo >= 1 && m_canDoCombo)
			{
				m_combo = 0;
				m_ctx.GetAnimationController().SwitchState(m_ctx.GetAnimationController().secondComboState);	
				m_canDoCombo = false;		
			}
			else
			{				
				if(m_ctx.GetAnimationController().GetCurrentAnimationState().IsAnimationFisnished())
				{
					CheckSwitchStates();
				}
			}
		}
		
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

