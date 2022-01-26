abstract class AnimationBaseState
{
	private string name;
	private uint[] framesIndices;
	private float stride;
	private float priority;
	private float elapsedTime;
	private sef::FrameTimer frameTimer;
	private uint frame;
	private bool loop;
	private PlayerController@ m_playerController;

	protected ETHEntity@ m_entity;
	protected int frameRow = 0;
	protected int frameColumn = 0;
	protected int _lastMovementDir;

	AnimationBaseState(PlayerController@ playerController, const string &in name, uint[] framesIndices, float stride, bool loop, float priority)
	{
		@m_playerController = @playerController;
		this.name = name;
		this.framesIndices = framesIndices;
		this.stride = stride;
		this.priority = priority;
		this.loop = loop;
	}

	void EnterState(PlayerAnimationController@ playerAnimationController){
		@m_entity = @m_playerController.GetCharacter().GetEntity();
	}
	
	void UpdateState(){
		_lastMovementDir = m_playerController.GetLastMovementDir();
		m_entity.SetFlipX(_lastMovementDir < 0);
	}

	float GetPriority()
	{
		return priority;
	}

	uint GetAnimationFrame()
	{
		return frame = framesIndices[frameTimer.set(0, framesIndices.length() - 1, 80, loop)];
	}

	float GetCurrentFrame()
	{
		return frameTimer.get();
	}

	float GetLastAnimationFrame()
	{
		return framesIndices.length() - 1;
	}

	string GetAnimationName()
	{
		return name;
	}

	bool IsAnimationFisnished()
	{
		return frameTimer.isFinished();
	}

	void ResetAnimation()
	{
		frameTimer.reset();
	}
}