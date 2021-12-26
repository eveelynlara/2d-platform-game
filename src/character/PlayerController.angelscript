class PlayerController
{
	private Character@ m_character;
	private int jumpsInTheAir = 0;
	private ETHPhysicsController@ rigidbody2D;
	private float movementSpeed = sef::TimeManager.unitsPerSecond(300.0f);
	private PlayerInputController@ playerInputController;
	private bool canMoveFast = true;
	private bool canFlip = true;
	private PlayAnim@ playAnim;

	PlayerController(Character@ character, int playerInputType = 0)
	{
		@m_character = @character;
		SetPhysicsController(character.GetEntity());
		SetAnimationController(@this);
		SetPlayerInputController(playerInputType);
		m_character.GetEntity().SetUInt("attacking", 0);
	}

	void update()
	{
		rigidbody2D.SetAwake(true);
		playAnim.update();
		playerInputController.update();

		// ProcessAttack();
		ProcessMovement();
	}

	Character@ GetCharacter()
	{
		return @m_character;
	}

	void SetPlayerInputController(const int controllerType)
	{
		if(controllerType == 0)
		{
			@playerInputController = KeyInputController();
		}
		else
		{
			@playerInputController = MovementBubbleGumController();
		}
	}
	void SetAnimationController(PlayerController@ movelocityController)
	{
		@playAnim = PlayAnim(@movelocityController);
	}

	vector2 GetSpeed()
	{
		return rigidbody2D.GetLinearVelocity();
	}

	void SetPhysicsController(ETHEntity@ entity)
	{
		@rigidbody2D = @m_character.GetEntity().GetPhysicsController();
	}

	PlayerInputController@ GetPlayerInputController()
	{
		return @playerInputController;
	}

	int GetLastMovementDir()
	{
		return playerInputController.GetLastMovementDir();
	}

	bool isTouchingOnlyGround()
	{
		return (GetTime() - m_character.GetEntity().GetUInt("touchingOnlyGroundTime")) < 120;
	}

	void SlowMovementSpeedDown()
	{
		canMoveFast = false;
		float slowDownParameter = 0.2f;
		rigidbody2D.SetLinearVelocity(vector2(slowDownParameter * movementSpeed * playerInputController.GetDirection().x, GetSpeed().y));
	}

	void ProcessAttack()
	{
		if(GetPlayerInputController().GetAttackHit() == 1)
		{
			m_character.GetEntity().SetUInt("attacking", 1);
			m_character.GetEquippedWeapon().Attack();
		}

		if(m_character.GetEntity().GetUInt("attacking") == 1)
		{
			SlowMovementSpeedDown();
		}
		else if(m_character.GetEntity().GetUInt("attacking") == 0)
		{
			canMoveFast = true;
		}
	}

	void ProcessMovement()
	{
		bool isJumping = (playerInputController.GetDirection().y < 0);
		float newVelocityY = playerInputController.GetDirection().y;

		if(canMoveFast)
		{
			movementSpeed = sef::TimeManager.unitsPerSecond(300.0f);
			if(isJumping && jumpsInTheAir < 1){
				jumpsInTheAir++;
			}
			else
			{
				newVelocityY = rigidbody2D.GetLinearVelocity().y;

				if (isTouchingOnlyGround())
				{
					jumpsInTheAir = 0;
				}
			}

			rigidbody2D.SetLinearVelocity(vector2(movementSpeed * playerInputController.GetDirection().x, newVelocityY));
		}
	}
}