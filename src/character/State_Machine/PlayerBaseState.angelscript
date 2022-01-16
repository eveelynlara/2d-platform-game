abstract class PlayerBaseState
{
	protected PlayerStateMachine@ m_ctx;
	protected PlayerStateFactory@ m_playerStateFactory;

	//sub and super states
	protected PlayerBaseState@ m_subState;
	protected PlayerBaseState@ m_superState;
	protected bool m_isRootState = false;

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
	void UpdateStates(){
		UpdateState();
		if(@m_subState != null)
		{
			m_subState.UpdateState();
		}
	}
	void SwitchState(PlayerBaseState@ newState){
		//exit from current state
		ExitState();

		//enter new state
		newState.EnterState();

		//switch current state of context if it's at the top lvel of the sate chain
		if(m_isRootState)
		{			
			m_ctx.SetCurrentState(@newState);
		}
		else if(@m_superState != null)
		{
			m_superState.SetSubState(@newState);
		}
	}
	void SetSuperState(PlayerBaseState@ newSuperState){
		@m_superState = @newSuperState;
	}
	void SetSubState(PlayerBaseState@ newSubState){
		@m_subState = @newSubState;
		newSubState.SetSuperState(@this);
	}
}