class PlayerController
{
	private Character@ m_character;
	private int jumpsInTheAir = 0;
	private ETHPhysicsController@ rigidbody2D;
	private PlayerInputController@ playerInputController;
	private bool canMoveFast = true;
	private bool canFlip = true;
	// private PlayerAnimationController@ playerAnimationController;

	//state machine
	private PlayerStateMachine@ playerStateMachine;

	PlayerController(Character@ character, int playerInputType = 0)
	{
		@m_character = @character;
		SetPhysicsController(character.GetEntity());
		SetPlayerInputController(playerInputType);
		SetPlayerStateMachine(@this);
		m_character.GetEntity().SetUInt("attacking", 0);
	}

	void Update()
	{
		rigidbody2D.SetAwake(true);
		playerStateMachine.Update();
		playerInputController.Update();
	}

	Character@ GetCharacter()
	{
		return @m_character;
	}

	void SetPlayerStateMachine(PlayerController@ pc)
	{
		@playerStateMachine = PlayerStateMachine(@pc);
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

	vector2 GetSpeed()
	{
		return rigidbody2D.GetLinearVelocity();
	}

	void SetPhysicsController(ETHEntity@ entity)
	{
		@rigidbody2D = @m_character.GetEntity().GetPhysicsController();
	}

	ETHPhysicsController@ GetPhysicsController()
	{
		return @rigidbody2D;
	}

	PlayerInputController@ GetPlayerInputController()
	{
		return @playerInputController;
	}

	int GetLastMovementDir()
	{
		return playerInputController.GetLastMovementDir();
	}

	bool IsTouchingOnlyGround()
	{
		return (GetTime() - m_character.GetEntity().GetUInt("touchingOnlyGroundTime")) < 120;
	}

	void Move(float characterMovementSpeed)
	{
		float movementSpeed = sef::TimeManager.unitsPerSecond(characterMovementSpeed);
		rigidbody2D.SetLinearVelocity(vector2(movementSpeed * playerInputController.GetDirection().x, rigidbody2D.GetLinearVelocity().y));
	}
}