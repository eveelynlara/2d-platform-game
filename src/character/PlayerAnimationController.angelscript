class PlayerAnimationController 
{
	private PlayerController@ playerController;
	private ETHEntity@ m_entity;
	private bool flipHorizontally = false;
	private bool isLoop = true;

	private float stride_idle = 100;
	private float stride_walk = 80;
	private float stride_jumpRise = 100;
	private float stride_jumpFall = 100;
	private float stride_meleeAttack = 80;

	private AnimationBaseState@ currentAnimationState;
	
	IdleAnimationState@ idleState = IdleAnimationState("idle", {0, 1, 2, 3, 4, 5, 6}, stride_idle, isLoop, 0);
	WalkingAnimationState@ walkingState = WalkingAnimationState("walking", {12, 13, 14, 15, 16, 17, 18, 19}, stride_walk, isLoop, 0);
	JumpRiseState@ jumpRiseState = JumpRiseState("jumpRising", {36, 37, 38, 39}, stride_jumpRise, !isLoop, 1.5);
	JumpFallState@ jumpFallState = JumpFallState("jumpFalling", {48, 49, 50}, stride_jumpFall, !isLoop, 1.5);
	BasicSwordAttackState@ basicSwordAttackState = BasicSwordAttackState("basicSwordAttack", {27, 28, 29, 30}, stride_meleeAttack, !isLoop, 1);
	SecondComboState@ secondComboState = SecondComboState("secondComboAttack", {31, 32, 33, 34}, stride_meleeAttack, !isLoop, 1);

	PlayerAnimationController(PlayerController@ playerController)
	{
		@this.playerController = @playerController;
		@currentAnimationState = @idleState;
		currentAnimationState.EnterState(@this);
	}

	void update()
	{
		currentAnimationState.UpdateState();
	}

	void SwitchState(AnimationBaseState@ animationBaseState)
	{
		@currentAnimationState = @animationBaseState;
		animationBaseState.EnterState(@this);
	}

	PlayerController@ GetPlayerController()
	{
		return @playerController;
	}
}