abstract class PlayerInputController 
{
	protected float m_jumpImpulse = 18.0f;
	protected int lastMovementDir = 1;
	protected vector2 vDirection;
	protected bool changeDir = false;
	protected int attack = 0;

	void Update()
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

	int GetAttackHit()
	{
		return attack;
	}

	vector2 GetDirection()
	{
		return vDirection;
	}
}