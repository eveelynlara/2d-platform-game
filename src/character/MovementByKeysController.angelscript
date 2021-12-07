class MovementByKeysController : MovementController
{
	private ETHInput@ input = GetInputHandle();

	void HandleMovement() override
		{
			attack = 0;
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
			if(input.GetKeyState(K_SPACE) == KS_HIT)
			{
				attack = 1;
			}
			if (movementX != 0)
			{
				changeDir = (lastMovementDir != movementX);
				lastMovementDir = movementX;
			}
			vDirection = vector2(movementX, jumpImpulse);
		}
}