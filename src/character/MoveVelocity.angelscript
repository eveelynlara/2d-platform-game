class MoveVelocity
{
	private Character@ characterToBeMoved;
	private vector2 moveVelocity;
	private int jumpsInTheAir = 0;
	private ETHPhysicsController@ rigidbody2D;
	private float movementSpeed = sef::TimeManager.unitsPerSecond(300.0f);
	private sef::FrameTimer m_frameTimer;
	private MainCharacterMovementKeys@ moveKeys = MainCharacterMovementKeys(@this);

	void SetCharacterToBeMoved(Character@ character)
	{
		@characterToBeMoved = @character;
		SetPhysicsController();
	}

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

	void SetPhysicsController()
	{
		@rigidbody2D = characterToBeMoved.GetEntity().GetPhysicsController();
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
		bool isJumping = (moveVelocity.y < 0);
		bool isTouchingGround = characterToBeMoved.isTouchingGround();

		if(isJumping && jumpsInTheAir < 1)
		{
			rigidbody2D.SetLinearVelocity(vector2(currentVelocity.x, moveVelocity.y));
			jumpsInTheAir++;
		}
		else if (isTouchingGround)
		{
			jumpsInTheAir = 0;
		}
	}
}