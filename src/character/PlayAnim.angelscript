class PlayAnim 
{
	private MoveVelocity@ moveVelocity;
	private int frameRow = 0;
	private int frameColumn = 0;
	private bool flipHorizontally = false;

	private Anim@ idleAnim = Anim("idle", {0, 1, 2, 3, 4, 5, 6}, 100, true, 0);
	private Anim@ walkingAnim = Anim("walking", {12, 13, 14, 15, 16, 17, 18, 19}, 80, true, 0);
	private Anim@ jumpingRisingAnim = Anim("jumpRising", {36, 37, 38, 39}, 100, false, 1.5);
	private Anim@ jumpingFallingAnim = Anim("jumpFalling", {48, 49, 50}, 100, false, 1.5);
	private Anim@ attackingGroundAnim = Anim("attackingGround", {24, 25, 26, 27, 28, 29, 30, 31, 32, 33, 34, 35}, 100, false, 1);
	private Anim@ currentPriorityAnim;


	PlayAnim(const string &in entityName, const vector2 pos, int controllerType)
	{
		@moveVelocity = MoveVelocity(entityName, pos, controllerType);
		moveVelocity.GetEntity().SetFrame(frameColumn, frameRow);
	}

	MoveVelocity@ GetController()
	{
		return @moveVelocity;
	}

	void update()
	{
		moveVelocity.update(); 

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
				attackingGroundAnim.SetIsAnimationFinished(false);
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