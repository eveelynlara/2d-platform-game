class PlayAnim 
{
	private MoveVelocity@ moveVelocity;
	private int frameRow = 2;
	private int frameColumn = 0;
	private sef::FrameTimer frameTimer;
	private int firstIndexRow = 1;
	private bool flipHorizontally = false;

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
		bool isTouchingGround = moveVelocity.isTouchingGround();
		frameColumn = 0;

		if(movementVelocityX != 0)
		{
			frameRow = firstIndexRow;
			
			if(moveVelocity.GetMovement().GetChangeDir())
			{
				moveVelocity.GetEntity().SetFlipX(lastMovementDir < 0);		
			}

			if(isTouchingGround)
			{
				frameColumn = frameTimer.set(0, 5, 90);
			}
		}
		else
		{
			frameRow = 0;
			frameColumn = frameTimer.set(0, 5, 90);			
		}

		moveVelocity.GetEntity().SetFrame(frameColumn, frameRow);
	}
}