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
		@m_entity = @moveVelocityController.GetCharacter().GetEntity();
		m_entity.SetFrame(frameColumn, frameRow);
	}

	void update()
	{
		int lastMovementDir = moveVelocityController.GetLastMovementDir();
		
		if(m_entity.GetUInt("attacking") == 1)
		{
			ProcessAttackAnimation();
		}
		else
		{
			m_entity.SetFlipX(lastMovementDir < 0);
			ProcessMovementAnimation();
		}
		
		m_entity.SetFrame(currentPriorityAnim.GetAnimationFrame());
	}

	void ProcessAttackAnimation()
	{
		@currentPriorityAnim = @attackingGroundAnim;

		if(attackingGroundAnim.IsAnimationFisnished())
		{
			m_entity.SetUInt("attacking", 0);
			attackingGroundAnim.ResetAnimation();
		}
	}

	void ProcessMovementAnimation()
	{
		float movementVelocityX = moveVelocityController.GetController().GetDirection().x;
		bool isTouchingOnlyGround = moveVelocityController.isTouchingOnlyGround();

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
}