class PlayerStateFactory 
{
	PlayerStateMachine@ m_context;

	PlayerStateFactory(PlayerStateMachine@ currentContext)
	{
		@m_context = @currentContext;
	}

	PlayerBaseState@ Grounded(){
		return PlayerGroundedState(@m_context, @this);
	}

	PlayerBaseState@ Idle(){
		return PlayerIdleState(@m_context, @this);
	}

	PlayerBaseState@ Jump()
	{
		return PlayerJumpState(@m_context, @this);
	}

	PlayerBaseState@ Walk()
	{
		return PlayerWalkState(@m_context, @this);
	}

	PlayerBaseState@ Attack()
	{
		return PlayerAttackState(@m_context, @this);
	}
}