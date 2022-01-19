class PlayerStateMachine 
{
	//references variables
	private PlayerController@ m_playerController;
	private PlayerInputController@ m_playerInputController;
	private PlayerAnimationController@ m_playerAnimationController;
	private ETHPhysicsController@ m_rigidbody2D;

	//state variables
	PlayerBaseState@ m_currentState;
	PlayerStateFactory@ m_states;

	//player control variables
	private float m_currentMovementInput;
	private bool m_isJumpPressed;
	private bool m_IsMovementPressed;
	private float m_movementSpeed;
	private float m_movementVelocityY;
	private int m_jumpsInTheAir;
	private bool m_isTouchingOnlyGround;

	PlayerStateMachine(PlayerController@ currentContext)
	{
		@m_playerController = @currentContext;
		@m_playerInputController = m_playerController.GetPlayerInputController();
		@m_playerAnimationController = m_playerController.GetAnimationController();

		//setup state
		@m_states = PlayerStateFactory(@this);
		@m_currentState = m_states.Grounded();
		m_currentState.EnterState();
	}

	void Update()
	{
		m_currentState.UpdateStates();
		m_playerController.Move(m_movementSpeed);
	}

	void SetCurrentState(PlayerBaseState@ newState)
	{
		@m_currentState = @newState;
	}

	PlayerBaseState@ GetCurrentState()
	{
		return @m_currentState;
	}

	bool IsJumpPressed()
	{
		return m_isJumpPressed = m_playerInputController.GetDirection().y < 0;
	}

	PlayerController@ GetPlayerController()
	{
		return @m_playerController;
	}

	float GetVelocityY()
	{
		return m_movementVelocityY;
	}

	void SetVelocityY(float newVelocityY)
	{
		m_movementVelocityY = newVelocityY;
	}

	float GetMovementSpeed()
	{
		return m_movementSpeed;
	}

	void SetMovementSpeed(float newSpeed)
	{
		m_movementSpeed = newSpeed;
	}

	int GetJumpsInTheAir()
	{
		return m_jumpsInTheAir;
	}

	void SetJumpsInTheAir(int jumpsInTheAir)
	{
		m_jumpsInTheAir = jumpsInTheAir;
	}

	bool IsTouchingOnlyGround()
	{
		return m_isTouchingOnlyGround = m_playerController.isTouchingOnlyGround();
	}
}