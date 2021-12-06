class PlayAnim 
{
	private MoveVelocityController@ moveVelocityController;
	private ETHEntity@ m_entity;
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


	PlayAnim(MoveVelocityController@ moveVelocityController)
	{
		@this.moveVelocityController = @moveVelocityController;
		@m_entity = @moveVelocityController.GetEntity();
		m_entity.SetFrame(frameColumn, frameRow);
	}

	void update()
	{
		float movementVelocityX = moveVelocityController.GetController().GetDirection().x;
		float movementVelocityY = moveVelocityController.GetController().GetDirection().y;
		int lastMovementDir = moveVelocityController.GetLastMovementDir();
		int attackButtonWasPressed = moveVelocityController.GetController().GetAttack();
		bool isTouchingOnlyGround = moveVelocityController.isTouchingOnlyGround();
		
		if(moveVelocityController.GetController().GetChangeDir())
		{
			m_entity.SetFlipX(lastMovementDir < 0);	
		}

		if(attackButtonWasPressed == 1)
		{
			m_entity.SetUInt("attacking", 1);
		}

		if(m_entity.GetUInt("attacking") == 1)
		{
			@currentPriorityAnim = @attackingGroundAnim;

			if(attackingGroundAnim.IsAnimationFisnished())
			{
				m_entity.SetUInt("attacking", 0);
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
				if(moveVelocityController.GetSpeed().y < 0)
				{
					@currentPriorityAnim = @jumpingRisingAnim;
				}
				else
				{
					@currentPriorityAnim = @jumpingFallingAnim;
				}
			}
		}
		m_entity.SetFrame(currentPriorityAnim.GetAnimationFrame());
	}
}