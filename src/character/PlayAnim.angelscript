class PlayAnim 
{
	private Character@ character;
	private ETHEntity@ entity;
	private MoveVelocity@ moveVelocity;
	private MainCharacterMovementKeys@ mainCharacterMovementKeys;
	private int frameRow = 2;
	private int frameColumn = 0;
	private sef::FrameTimer frameTimer;

	void SetCharacterToBeAnimated(Character@ character)
	{
		@this.character = @character;
		SetEntity();
		SetMoveVelocity();
		SetMovementKeys();
	}

	void SetEntity()
	{
		@entity = @character.GetEntity();
	}

	void SetMoveVelocity()
	{
		@moveVelocity = @character.GetMoveVelocity();
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
		bool isTouchingGround = character.isTouchingGround();

		if(movementVelocityX != 0)
		{
			frameRow = lastMovementDir > 0 ? 2 : 1;

			if(isTouchingGround)
			{
				frameColumn = frameTimer.set(0, 3, 150);
			}
			else
			{
				frameColumn = 0;	
			}
		}
		else
		{
			frameColumn = 0;
		}
	}
}