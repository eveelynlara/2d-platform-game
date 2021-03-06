class PlayerIdleState : PlayerBaseState
{
    PlayerIdleState(PlayerStateMachine@ currentContext, PlayerStateFactory@ playerStateFactory){
        super(@currentContext, @playerStateFactory);
    }
    
    void EnterState() override {
	}
	void UpdateState() override {
		// print(GetStateName());
		CheckSwitchStates();
	}
	void ExitState() override {}
	void CheckSwitchStates() override {
		if(m_ctx.GetPlayerController().GetPlayerInputController().GetDirection().x != 0)
		{
			SwitchState(m_playerStateFactory.Walk());
		}		
	}
	string GetStateName() override
	{
		return "state name is: Idle";
	}
	void InitializeSubState() override {}
}
