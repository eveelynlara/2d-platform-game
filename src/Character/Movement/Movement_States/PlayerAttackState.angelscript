class PlayerAttackState : PlayerBaseState
{
	private ETHPhysicsController@ m_rigidbody2D;

	//hitbox
	private bool m_canPerformAttack;

	//animation
	private int m_comboAnimation;
	private bool m_firstHitAnimation;
	private bool m_canDoComboAnimation;

	PlayerAttackState(PlayerStateMachine@ currentContext, PlayerStateFactory@ playerStateFactory)
	{
		super(@currentContext, @playerStateFactory);
		@m_rigidbody2D = currentContext.GetPlayerController().GetPhysicsController();
		m_isRootState = true;
	}
	void EnterState() override {
		
		m_canPerformAttack = true;
		m_firstHitAnimation = true;
		m_canDoComboAnimation = true;

		float attackingMovementSpeed = 100.0f;
		m_ctx.SetMovementSpeed(walkingMovementSpeed);

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
			m_comboAnimation++;
		}

		HandleHitbox();
		HandleAttackAnimation();
	}

	void HandleAttackAnimation()
	{
		if(m_firstHitAnimation)
		{	
			m_ctx.GetAnimationController().SwitchState(m_ctx.GetAnimationController().basicSwordAttackState);
			m_firstHitAnimation = false;
		}
		else if(m_ctx.GetAnimationController().GetCurrentAnimationState().IsAnimationFisnished())
		{
			if(m_comboAnimation >= 1 && m_canDoComboAnimation)
			{
				m_canPerformAttack = true;
				m_comboAnimation = 0;
				m_ctx.GetAnimationController().SwitchState(m_ctx.GetAnimationController().secondComboState);	
				m_canDoComboAnimation = false;		
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

	void HandleHitbox()
	{
		IWeapon@ characterEquippedWeapon = m_ctx.GetPlayerController().GetCharacter().GetEquippedWeapon();
		
		if(m_canPerformAttack)
		{
			characterEquippedWeapon.Attack();
			m_canPerformAttack = false;
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

