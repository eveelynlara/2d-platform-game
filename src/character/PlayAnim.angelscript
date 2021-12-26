class PlayAnim 
{
	private PlayerController@ moveVelocityController;
	private ETHEntity@ m_entity;
	private bool flipHorizontally = false;
	private bool isLoop = true;

	private float stride_idle = 100;
	private float stride_walk = 80;
	private float stride_jumpRise = 100;
	private float stride_jumpFall = 100;
	private float stride_meleeAttack = 80;

	// private AnimationBaseState@ idleAnim = AnimationBaseState("idle", {0, 1, 2, 3, 4, 5, 6}, stride_idle, isLoop, 0);
	// private AnimationBaseState@ walkingAnim = AnimationBaseState("walking", {12, 13, 14, 15, 16, 17, 18, 19}, stride_walk, isLoop, 0);
	// private AnimationBaseState@ jumpingRisingAnim = AnimationBaseState("jumpRising", {36, 37, 38, 39}, stride_jumpRise, !isLoop, 1.5);
	// private AnimationBaseState@ jumpingFallingAnim = AnimationBaseState("jumpFalling", {48, 49, 50}, stride_jumpFall, !isLoop, 1.5);
	// private AnimationBaseState@ attackingGroundAnim = AnimationBaseState("attackingGround", {27, 28, 29, 30}, stride_meleeAttack, !isLoop, 1);
	private AnimationBaseState@ currentAnimationState;
	IdleAnimationState@ idleState = IdleAnimationState("idle", {0, 1, 2, 3, 4, 5, 6}, stride_idle, isLoop, 0);
	WalkingAnimationState@ walkingState = WalkingAnimationState("walking", {12, 13, 14, 15, 16, 17, 18, 19}, stride_walk, isLoop, 0);
	JumpRiseState@ jumpRiseState = JumpRiseState("jumpRising", {36, 37, 38, 39}, stride_jumpRise, !isLoop, 1.5);
	JumpFallState@ jumpFallState = JumpFallState("jumpFalling", {48, 49, 50}, stride_jumpFall, !isLoop, 1.5);


	PlayAnim(PlayerController@ moveVelocityController)
	{
		@this.moveVelocityController = @moveVelocityController;
		@currentAnimationState = @idleState;
		currentAnimationState.EnterState(@this);
	}

	void update()
	{
		currentAnimationState.UpdateState();
		// int lastMovementDir = moveVelocityController.GetLastMovementDir();
		
		// if(m_entity.GetUInt("attacking") == 1)
		// {
		// 	ProcessAttackAnimation();
		// }
		// else
		// {
		// 	m_entity.SetFlipX(lastMovementDir < 0);
		// 	ProcessMovementAnimation();
		// }
		
		// m_entity.SetFrame(currentAnimationState.GetAnimationFrame());
	}

	void SwitchState(AnimationBaseState@ animationBaseState)
	{
		@currentAnimationState = @animationBaseState;
		animationBaseState.EnterState(@this);
	}

	void ProcessAttackAnimation()
	{
		// @currentPriorityAnim = @attackingGroundAnim;

		// if(attackingGroundAnim.IsAnimationFisnished())
		// {
		// 	m_entity.SetUInt("attacking", 0);
		// 	attackingGroundAnim.ResetAnimation();
		// }
	}

	void ProcessMovementAnimation()
	{
	// 	float movementVelocityX = moveVelocityController.GetController().GetDirection().x;
	// 	bool isTouchingOnlyGround = moveVelocityController.isTouchingOnlyGround();

	// 	if(isTouchingOnlyGround)
	// 	{
	// 		if(movementVelocityX != 0)
	// 		{	
	// 			@currentPriorityAnim = @walkingAnim;
	// 		}
	// 		else
	// 		{
	// 			@currentPriorityAnim = @idleAnim;
	// 		}
	// 	}
	// 	else
	// 	{
	// 		if(moveVelocityController.GetSpeed().y < 0)
	// 		{
	// 			@currentPriorityAnim = @jumpingRisingAnim;
	// 		}
	// 		else
	// 		{
	// 			@currentPriorityAnim = @jumpingFallingAnim;
	// 		}
	// 	}
	}

	PlayerController@ GetPlayerController()
	{
		return @moveVelocityController;
	}
}