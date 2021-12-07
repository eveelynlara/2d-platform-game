class MoveVelocityController
{
	private ETHEntity@ m_entity;
	private int jumpsInTheAir = 0;
	private ETHPhysicsController@ rigidbody2D;
	private float movementSpeed = sef::TimeManager.unitsPerSecond(300.0f);
	private MovementController@ movementController;
	private bool canMoveFast = true;
	private PlayAnim@ playAnim;

	MoveVelocityController(ETHEntity@ entity, int controllerType = 0)
	{
		SetEntity(@entity);
		SetPhysicsController(@entity);
		SetAnimationController();
		SetMovementController(controllerType);
	}

	void update()
	{
		rigidbody2D.SetAwake(true);
		playAnim.update();
		movementController.update();
		
		ProcessAttack();
		ProcessMovement();
	}

	void SetEntity(ETHEntity@ entity)
	{
		@m_entity = @entity;
	}

	ETHEntity@ GetEntity()
	{
		return @m_entity;
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
	void SetAnimationController()
	{
		@playAnim = PlayAnim(@this);
	}

	vector2 GetSpeed()
	{
		return rigidbody2D.GetLinearVelocity();
	}

	void SetPhysicsController(ETHEntity@ entity)
	{
		@rigidbody2D = @m_entity.GetPhysicsController();
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
		return (GetTime() - m_entity.GetUInt("touchingOnlyGroundTime")) < 120;
	}

	void SlowMovementSpeedDown()
	{
		canMoveFast = false;
		movementSpeed = sef::TimeManager.unitsPerSecond(150.0f);
		rigidbody2D.SetLinearVelocity(vector2(movementSpeed * movementController.GetDirection().x, GetSpeed().y));		
	}

	void ProcessAttack()
	{
		if(GetController().GetAttack() == 1)
		{
			sef::util::scheduleEvent(30.0f, AddMeleeHitBoxEvent(@this));
		}

		if(m_entity.GetUInt("attacking") == 1)
		{
			SlowMovementSpeedDown();
		}
	}

	void ProcessMovement()
	{
		bool isJumping = (movementController.GetDirection().y < 0);
		float newVelocityY = movementController.GetDirection().y;
		canMoveFast = true;

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