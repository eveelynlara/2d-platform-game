class PlayAnim 
{
	private Character@ character;
	private ETHEntity@ entity;
	private MainCharacterMovementKeys@ mainCharacterMovementKeys;
	private int directionLine;
	private int frameColumn = 0;
	private sef::FrameTimer frameTimer;

	void SetCharacterToBeAnimated(Character@ character)
	{
		@this.character = @character;
		SetEntity();
		SetMoveVelocityController();
	}

	void SetEntity()
	{
		@entity = @character.GetEntity();
	}

	void SetMoveVelocityController()
	{
		@mainCharacterMovementKeys = @character.GetMoveVelocityController().GetMainCharacterMovementKeys();
	}

	void update()
	{
		directionLine = (mainCharacterMovementKeys.GetLastMovementDir()) > 0 ? 2 : 1;
		frameColumn = frameTimer.set(0, 3, 150);
		entity.SetFrame(frameColumn, directionLine);
	}
}