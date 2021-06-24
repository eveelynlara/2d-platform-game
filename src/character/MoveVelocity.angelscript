class MoveVelocity
{
	private vector2 moveVelocity;
	private ETHPhysicsController@ rigidbody2D;
	private float movementSpeed = sef::TimeManager.unitsPerSecond(300.0f);
	private sef::FrameTimer m_frameTimer;
	private MainCharacterMovementKeys@ moveKeys = MainCharacterMovementKeys(@this);;

	private uint m_directionLine = 2;
	private float m_lastDirectionX = 1;
	private uint m_frameColumn = 0;

	void SetVelocity(const vector2 moveVelocity)
	{
		this.moveVelocity = moveVelocity;
	}

	void SetPhysicsController(ETHPhysicsController@ rigidbody2D)
	{
		@this.rigidbody2D = @rigidbody2D;
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