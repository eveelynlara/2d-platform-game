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
	private PlayerAnimationController@ m_playerAnimationController;

	protected ETHEntity@ m_entity;
	protected int frameRow = 0;
	protected int frameColumn = 0;
	protected int _lastMovementDir;

	AnimationBaseState(const string &in name, uint[] framesIndices, float stride, bool loop, float priority)
	{
		this.name = name;
		this.framesIndices = framesIndices;
		this.stride = stride;
		this.priority = priority;
		this.loop = loop;
	}

	void EnterState(PlayerAnimationController@ playerAnimationController){
		@m_entity = @playerAnimationController.GetPlayerController().GetCharacter().GetEntity();
	}
	
	void UpdateState(){
		_lastMovementDir = m_playerAnimationController.GetPlayerController().GetLastMovementDir();
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