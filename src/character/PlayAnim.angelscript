class PlayAnim 
{
	private Character@ characterToBeAnimated;
	private ETHEntity@ entity;
	private MoveVelocity@ moveVelocity;
	private MainCharacterMovementKeys@ mainCharacterMovementKeys;
	private int frameRow = 2;
	private int frameColumn = 0;
	private sef::FrameTimer frameTimer;
	private int secondIndexRow = 2;
	private bool flipHorizontally = false;

	void SetCharacterToBeAnimated(Character@ character)
	{
		@characterToBeAnimated = @character;
		SetEntity();
		SetMoveVelocity();
		SetMovementKeys();
	}

	void SetEntity()
	{
		@entity = @characterToBeAnimated.GetEntity();
	}

	void SetMoveVelocity()
	{
		@moveVelocity = @characterToBeAnimated.GetMoveVelocity();
	}

	void SetMovementKeys()
	{
		@mainCharacterMovementKeys = @moveVelocity.GetMainCharacterMovementKeys();
	}

	void update()
	{
		entity.SetFrame(frameColumn, frameRow);

		float movementVelocityX = moveVelocity.GetVelocity().x;
		float movementVelocityY = moveVelocity.GetVelocity().y;
		int lastMovementDir = mainCharacterMovementKeys.GetLastMovementDir();
		bool isTouchingGround = characterToBeAnimated.isTouchingGround();
		frameColumn = 0;

		if(movementVelocityX != 0)
		{
			frameRow = secondIndexRow;
			flipHorizontally = lastMovementDir < 0 ? true : false;
			entity.SetFlipX(flipHorizontally);

			if(isTouchingGround)
			{
				frameColumn = frameTimer.set(0, 3, 150);
			}
		}
	}
}