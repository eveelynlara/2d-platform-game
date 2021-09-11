class PlayAnim 
{
	private MoveVelocity@ moveVelocity;
	private int frameRow = 0;
	private int frameColumn = 0;
	private bool flipHorizontally = false;
	private sef::FrameTimer frameTimer;
	private uint[] idleFrameMapping = {0, 1, 2, 3, 4, 5, 6};	
	private uint[] walkingFrameMapping = {12, 13, 14, 15, 16, 17, 18, 19};
	private uint[] risingJump = {36, 37, 38, 39};
	private uint[] fallingJump = {48, 49, 50};

	PlayAnim(const string &in entityName, const vector2 pos, int movementType)
	{
		@moveVelocity = MoveVelocity(entityName, pos, movementType);
		moveVelocity.GetEntity().SetFrame(frameColumn, frameRow);
	}

	MoveVelocity@ GetMoveVelocity()
	{
		return @moveVelocity;
	}

	void update()
	{
		moveVelocity.update(); 

		float movementVelocityX = moveVelocity.GetMovement().GetDirection().x;
		float movementVelocityY = moveVelocity.GetMovement().GetDirection().y;
		int lastMovementDir = moveVelocity.GetLastMovementDir();
		bool isTouchingOnlyGround = moveVelocity.isTouchingOnlyGround();
		uint frame;

		if(moveVelocity.GetMovement().GetChangeDir())
		{
			moveVelocity.GetEntity().SetFlipX(lastMovementDir < 0);	
		}

		if(isTouchingOnlyGround)
		{
			if(movementVelocityX != 0)
			{	
				frame = walkingFrameMapping[frameTimer.set(0, walkingFrameMapping.length() - 1, 80, true /*loop*/)];
			}
			else
			{
				frame = idleFrameMapping[frameTimer.set(0, idleFrameMapping.length() - 1, 100, true /*loop*/)];
			}
		}
		else
		{
			if(moveVelocity.GetSpeed().y < 0)
			{
				frame = risingJump[frameTimer.set(0, risingJump.length() - 1, 100, false /*loop*/)];
			}
			else
			{
				frame = fallingJump[frameTimer.set(0, fallingJump.length() - 1, 100, false /*loop*/)];
			}
		}
		moveVelocity.GetEntity().SetFrame(frame);
	}
}