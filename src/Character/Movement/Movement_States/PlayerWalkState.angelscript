  class PlayerWalkState : PlayerBaseState
{
	PlayerWalkState(PlayerStateMachine@ currentContext, PlayerStateFactory@ playerStateFactory)
	{
		super(@currentContext, @playerStateFactory);
		m_isRootState = false;
	}
	void EnterState() override {
		float walkingMovementSpeed = 300.0f;
		m_ctx.SetMovementSpeed(walkingMovementSpeed);
	}
	void UpdateState() override {
		// print(GetStateName());
		HandleWalkingAnimation();
		CheckSwitchStates();
		
	}
	void ExitState() override {
	}
	void CheckSwitchStates() override {
		if(m_ctx.GetPlayerController().GetPlayerInputController().GetDirection().x == 0)
		{
			SwitchState(m_playerStateFactory.Idle());
		}			
	}
	string GetStateName() override
	{
		return "state name is: Walk";
	}	
	void HandleWalkingAnimation()
	{
		m_ctx.GetAnimationController().SwitchState(m_ctx.GetAnimationController().walkingState);
	}
}