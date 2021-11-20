class PlayAnim 
{
	private MoveVelocity@ moveVelocity;
	private int frameRow = 0;
	private int frameColumn = 0;
	private bool flipHorizontally = false;
	private bool isLoop = true;

	private float stride_idle = 100;
	private float stride_walk = 80;
	private float stride_jumpRise = 100;
	private float stride_jumpFall = 100;
	private float stride_meleeAttack = 80;

	private Anim@ idleAnim = Anim("idle", {0, 1, 2, 3, 4, 5, 6}, stride_idle, isLoop, 0);
	private Anim@ walkingAnim = Anim("walking", {12, 13, 14, 15, 16, 17, 18, 19}, stride_walk, isLoop, 0);
	private Anim@ jumpingRisingAnim = Anim("jumpRising", {36, 37, 38, 39}, stride_jumpRise, !isLoop, 1.5);
	private Anim@ jumpingFallingAnim = Anim("jumpFalling", {48, 49, 50}, stride_jumpFall, !isLoop, 1.5);
	private Anim@ attackingGroundAnim = Anim("attackingGround", {27, 28, 29, 30}, stride_meleeAttack, !isLoop, 1);
	private Anim@ currentPriorityAnim;


	PlayAnim(MoveVelocity@ moveVelocity)
	{
		@this.moveVelocity = @moveVelocity;
		moveVelocity.GetEntity().SetFrame(frameColumn, frameRow);
	}

	void update()
	{
		float movementVelocityX = moveVelocity.GetController().GetDirection().x;
		float movementVelocityY = moveVelocity.GetController().GetDirection().y;
		int lastMovementDir = moveVelocity.GetLastMovementDir();
		int attackButtonWasPressed = moveVelocity.GetController().GetAttack();
		bool isTouchingOnlyGround = moveVelocity.isTouchingOnlyGround();
		
		if(moveVelocity.GetController().GetChangeDir())
		{
			moveVelocity.GetEntity().SetFlipX(lastMovementDir < 0);	
		}

		if(attackButtonWasPressed == 1)
		{
			moveVelocity.GetEntity().SetUInt("attacking", 1);
		}

		if(moveVelocity.GetEntity().GetUInt("attacking") == 1)
		{
			@currentPriorityAnim = @attackingGroundAnim;

			if(attackingGroundAnim.IsAnimationFisnished())
			{
				moveVelocity.GetEntity().SetUInt("attacking", 0);
				attackingGroundAnim.ResetAnimation();
			}
		}
		else
		{
			if(isTouchingOnlyGround)
			{
				if(movementVelocityX != 0)
				{	
					@currentPriorityAnim = @walkingAnim;
				}
				else
				{
					@currentPriorityAnim = @idleAnim;
				}
			}
			else
			{
				if(moveVelocity.GetSpeed().y < 0)
				{
					@currentPriorityAnim = @jumpingRisingAnim;
				}
				else
				{
					@currentPriorityAnim = @jumpingFallingAnim;
				}
			}
		}
		moveVelocity.GetEntity().SetFrame(currentPriorityAnim.GetAnimationFrame());
	}
}