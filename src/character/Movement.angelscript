abstract class Movement 
{
	protected float m_jumpImpulse = 18.0f;
	protected int lastMovementDir = 1;
	protected vector2 vDirection;
	protected bool changeDir = false;

	void update()
	{
		HandleMovement();
	}

	bool GetChangeDir()
	{
		return changeDir;
	}

	void HandleMovement() 
	{

	}

	int GetLastMovementDir()
	{
		return lastMovementDir;
	}

	vector2 GetDirection()
	{
		return vDirection;
	}
	
	//fazer outros directions, DirectionX(), DirectionY()
}