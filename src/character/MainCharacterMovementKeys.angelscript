class MainCharacterMovementKeys 
{
	MainCharacterMovementKeys(MoveVelocity@ moveVelocity)
	{
		@this.moveVelocity = @moveVelocity;
	}

	private ETHInput@ input = GetInputHandle();
	private MoveVelocity@ moveVelocity;
	private float m_jumpImpulse = 18.0f;
	private int lastMovementDir = 1;

	void update()
	{
		HandleMovement();
	}

	void HandleMovement()
	{
		int movementX = 0;
		float jumpImpulse = 0.0f;

		if (input.KeyDown(K_LEFT))
		{
			movementX = -1;
		}
		if (input.KeyDown(K_RIGHT))
		{
			movementX = 1;
		}
		if (input.GetKeyState(K_UP) == KS_HIT)
		{
			jumpImpulse =-m_jumpImpulse;
		}
		if (movementX != 0)
		{
			lastMovementDir = movementX;
		}
		const vector2 movementXY = vector2(movementX, jumpImpulse);
		moveVelocity.SetVelocity(movementXY);
	}

	int GetLastMovementDir()
	{
		return lastMovementDir;
	}
}