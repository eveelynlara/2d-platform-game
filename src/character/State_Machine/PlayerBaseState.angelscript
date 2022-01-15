abstract class PlayerBaseState
{
	protected PlayerStateMachine@ m_ctx;
	protected PlayerStateFactory@ m_playerStateFactory;

	PlayerBaseState(PlayerStateMachine@ currentContext, PlayerStateFactory@ factory)
	{
		@m_ctx = @currentContext;
		@m_playerStateFactory = @factory;
	}

	void EnterState(){}
	void UpdateState(){}
	void ExitState(){}
	void CheckSwitchStates(){}
	void InitializeSubState(){}
	void UpdateStates(){}
	void SwitchState(PlayerBaseState@ newState){
		//exit from current state
		ExitState();

		//enter new state
		newState.EnterState();

		//switch current state of context
		m_ctx.SetCurrentState(@newState);
	}
	void SetSuperState(){}
	void SetSubState(){}
}