class MoveVelocity
{
	private ETHEntity@ m_entity;
	private int jumpsInTheAir = 0;
	private ETHPhysicsController@ rigidbody2D;
	private float movementSpeed = sef::TimeManager.unitsPerSecond(300.0f);
	private Movement@ movement;

	MoveVelocity(const string &in entityName, const vector2 pos, int movementType = 0)
	{
		AddEntity(entityName, vector3(pos, -2.0f), 0.0f /*rotation*/, m_entity, "Character", 1.0f /*scale*/);
		SetPhysicsController();
		print("Construtor passou aqui");
		//@movement = movementType == 0 ? MovementByKeys() : MovementBubbleGum(); 
		if(movementType == 0)
		{
			@movement = MovementByKeys();
		}
		else
		{
			@movement = MovementBubbleGum();
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

	Movement@ GetMovement()
	{
		return @movement;
	}

	int GetLastMovementDir()
	{
		return movement.GetLastMovementDir();
	}

	bool isTouchingGround()
	{
		// if the last time a ground touch had been detected was over a few
		// milliseconds ago, we assume it is no longer touching the ground 
		bool isTouchingGround = ((GetTime() - m_entity.GetUInt("touchingGroundTime")) < 120);
		return isTouchingGround;
	}

	void update()
	{
		movement.update();
		bool isJumping = (movement.GetDirection().y < 0);
		float newVelocityY;

		if(isJumping && jumpsInTheAir < 1){
			newVelocityY = movement.GetDirection().y;
			jumpsInTheAir++;
		}
		else
		{
			newVelocityY = rigidbody2D.GetLinearVelocity().y;
			
			if (isTouchingGround())
			{
				jumpsInTheAir = 0;
			}
		}
		
		rigidbody2D.SetLinearVelocity(vector2(movementSpeed * movement.GetDirection().x, newVelocityY));
	}
}