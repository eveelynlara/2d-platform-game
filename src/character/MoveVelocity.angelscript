class MoveVelocity
{
	private vector2 moveVelocity;
	private ETHPhysicsController@ rigidbody2D;
	private float movementSpeed = sef::TimeManager.unitsPerSecond(300.0f);
	private sef::FrameTimer m_frameTimer;
	private MainCharacterMovementKeys@ moveKeys = MainCharacterMovementKeys(@this);

	void SetVelocity(const vector2 moveVelocity)
	{
		this.moveVelocity = moveVelocity;
	}

	vector2 GetVelocity()
	{
		return moveVelocity;
	}

	vector2 GetSpeed()
	{
		return rigidbody2D.GetLinearVelocity();
	}

	void SetPhysicsController(ETHPhysicsController@ rigidbody2D)
	{
		@this.rigidbody2D = @rigidbody2D;
	}

	MainCharacterMovementKeys@ GetMainCharacterMovementKeys()
	{
		return @moveKeys;
	}

	void update()
	{
		moveKeys.update();
		vector2 currentVelocity = rigidbody2D.GetLinearVelocity();
		rigidbody2D.SetLinearVelocity(vector2(movementSpeed * moveVelocity.x, currentVelocity.y));
		
		if(moveVelocity.y < 0)
		{
			rigidbody2D.SetLinearVelocity(vector2(currentVelocity.x, moveVelocity.y));
		}
	}
}