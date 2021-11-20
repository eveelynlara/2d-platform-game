class MoveVelocity
{
	private ETHEntity@ m_entity;
	private int jumpsInTheAir = 0;
	private ETHPhysicsController@ rigidbody2D;
	private float movementSpeed = sef::TimeManager.unitsPerSecond(300.0f);
	private Controller@ controller;
	private bool canMoveFast = true;
	private PlayAnim@ playAnim;

	MoveVelocity(const string &in entityName, const vector2 pos, int controllerType = 0)
	{
		AddEntity(entityName, vector3(pos, -2.0f), 0.0f /*rotation*/, m_entity, "Character", 1.3f /*scale*/);
		@playAnim = PlayAnim(@this);
		
		SetPhysicsController();

		if(controllerType == 0)
		{
			@controller = MovementByKeysController();
		}
		else
		{
			@controller = MovementBubbleGumController();
		}
	}

	ETHEntity@ GetEntity()
	{
		return @m_entity;
	}

	vector2 GetSpeed()
	{
		return rigidbody2D.GetLinearVelocity();
	}

	void SetPhysicsController()
	{
		@rigidbody2D = m_entity.GetPhysicsController();
	}

	Controller@ GetController()
	{
		return @controller;
	}

	int GetLastMovementDir()
	{
		return controller.GetLastMovementDir();
	}

	bool isTouchingOnlyGround()
	{
		return (GetTime() - m_entity.GetUInt("touchingOnlyGroundTime")) < 120;
	}

	void SlowMovementSpeedDown()
	{
		canMoveFast = false;
		movementSpeed = sef::TimeManager.unitsPerSecond(150.0f);
		rigidbody2D.SetLinearVelocity(vector2(movementSpeed * controller.GetDirection().x, GetSpeed().y));		
	}

	void update()
	{
		playAnim.update();
		rigidbody2D.SetAwake(true);

		controller.update();
		bool isJumping = (controller.GetDirection().y < 0);
		float newVelocityY = controller.GetDirection().y;
		canMoveFast = true;

		if(GetEntity().GetUInt("attacking") == 1)
		{
			SlowMovementSpeedDown();
		}
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

			rigidbody2D.SetLinearVelocity(vector2(movementSpeed * controller.GetDirection().x, newVelocityY));
		}
	}
}