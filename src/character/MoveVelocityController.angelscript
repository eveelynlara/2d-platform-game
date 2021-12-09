class MoveVelocityController
{
	private Character@ m_character;
	private int jumpsInTheAir = 0;
	private ETHPhysicsController@ rigidbody2D;
	private float movementSpeed = sef::TimeManager.unitsPerSecond(300.0f);
	private MovementController@ movementController;
	private bool canMoveFast = true;
	private bool canFlip = true;
	private PlayAnim@ playAnim;

	MoveVelocityController(Character@ character, int controllerType = 0)
	{
		@m_character = @character;
		SetPhysicsController(character.GetEntity());
		SetAnimationController(@this);
		SetMovementController(controllerType);
		m_character.GetEntity().SetUInt("attacking", 0);
	}

	void update()
	{
		rigidbody2D.SetAwake(true);
		playAnim.update();
		movementController.update();

		ProcessAttack();
		ProcessMovement();
	}

	Character@ GetCharacter()
	{
		return @m_character;
	}

	void SetMovementController(const int controllerType)
	{
		if(controllerType == 0)
		{
			@movementController = MovementByKeysController();
		}
		else
		{
			@movementController = MovementBubbleGumController();
		}
	}
	void SetAnimationController(MoveVelocityController@ movelocityController)
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

	MovementController@ GetController()
	{
		return @movementController;
	}

	int GetLastMovementDir()
	{
		return movementController.GetLastMovementDir();
	}

	bool isTouchingOnlyGround()
	{
		return (GetTime() - m_character.GetEntity().GetUInt("touchingOnlyGroundTime")) < 120;
	}

	void SlowMovementSpeedDown()
	{
		canMoveFast = false;
		float slowDownParameter = 0.2f;
		rigidbody2D.SetLinearVelocity(vector2(slowDownParameter * movementSpeed * movementController.GetDirection().x, GetSpeed().y));
	}

	void ProcessAttack()
	{
		if(GetController().GetAttackHit() == 1)
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
		bool isJumping = (movementController.GetDirection().y < 0);
		float newVelocityY = movementController.GetDirection().y;

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

			rigidbody2D.SetLinearVelocity(vector2(movementSpeed * movementController.GetDirection().x, newVelocityY));
		}
	}
}