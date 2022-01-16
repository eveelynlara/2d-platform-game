class PlayerIdleState : PlayerBaseState
{
    PlayerIdleState(PlayerStateMachine@ currentContext, PlayerStateFactory@ playerStateFactory){
        super(@currentContext, @playerStateFactory);
    }
    
    void EnterState() override {
		print("Oie! Estou no Enter State do Idle");
	}
	void UpdateState() override {
		CheckSwitchStates();
	}
	void ExitState() override {}
	void CheckSwitchStates() override {}
	void InitializeSubState() override {}
	void UpdateStates() override {}
	void SwitchState(PlayerBaseState@ newState) override {}
	void SetSuperState() override {}
	void SetSubState() override {}
}