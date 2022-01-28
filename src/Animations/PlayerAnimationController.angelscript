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
	private AnimationBaseState@ oldAnimationState;
	
	IdleAnimationState@ idleState = IdleAnimationState(@playerController, "idle", {0, 1, 2, 3, 4, 5, 6}, stride_idle, isLoop, 0);
	WalkingAnimationState@ walkingState = WalkingAnimationState(@playerController,"walking", {12, 13, 14, 15, 16, 17, 18, 19}, stride_walk, isLoop, 0);
	JumpingAnimationState@ jumpingState = JumpingAnimationState(@playerController,"jumpRising", {36, 37, 38, 39}, stride_jumpRise, !isLoop, 1.5);
	FallingAnimationState@ fallingState = FallingAnimationState(@playerController,"jumpFalling", {48, 49, 50}, stride_jumpFall, !isLoop, 1.5);
	BasicSwordAttackAnimationState@ basicSwordAttackState = BasicSwordAttackAnimationState(@playerController,"basicSwordAttack", {27, 28, 29, 30}, stride_meleeAttack, !isLoop, 1);
	SecondComboAnimationState@ secondComboState = SecondComboAnimationState(@playerController,"secondComboAttack", {31, 32, 33, 34}, stride_meleeAttack, !isLoop, 1);

	PlayerAnimationController(PlayerController@ playerController)
	{
		@this.playerController = @playerController;
		@currentAnimationState = @idleState;
		@oldAnimationState = @currentAnimationState;
		currentAnimationState.EnterState(@this);
	}

	void update()
	{
		currentAnimationState.UpdateState();
	}

	void SwitchState(AnimationBaseState@ animationBaseState)
	{
		if(@animationBaseState !is @oldAnimationState)
		{
			oldAnimationState.ResetAnimation();
			@oldAnimationState = @animationBaseState;
		}
		
		@currentAnimationState = @animationBaseState;
		animationBaseState.EnterState(@this);
	}

	AnimationBaseState@ GetCurrentAnimationState()
	{
		return @currentAnimationState;
	}

	PlayerController@ GetPlayerController()
	{
		return @playerController;
	}
}