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

	/*-- abstract functions --*/
	void EnterState(){}
	void UpdateState(){}
	void ExitState(){}
	void CheckSwitchStates(){}
	void InitializeSubState(){}
	string GetStateName(){ return "name from base state";}	
	/*------------------------*/

	void UpdateStates(){
		UpdateState();
		if(@m_subState != null)
		{
			m_subState.UpdateState();
		}
	}
	protected void SwitchState(PlayerBaseState@ newState){
		//exit from current state
		ExitState();

		//enter new state
		newState.EnterState();

		//switch current state of context if it's at the top lvel of the state chain
		if(m_isRootState)
		{	
			m_ctx.SetCurrentState(@newState);
		}
		else if(m_superState !is null)
		{
			m_superState.SetSubState(@newState);
		}
	}
	protected void SetSuperState(PlayerBaseState@ newSuperState){
		@m_superState = @newSuperState;
	}
	protected void SetSubState(PlayerBaseState@ newSubState){
		@m_subState = @newSubState;
		newSubState.SetSuperState(@this);
	}
}