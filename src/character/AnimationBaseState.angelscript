abstract class AnimationBaseState
{
	protected int frameRow = 0;
	protected int frameColumn = 0;
	private string name;
	private uint[] framesIndices;
	private float stride;
	private float priority;
	private float elapsedTime;
	private sef::FrameTimer frameTimer;
	private uint frame;
	private bool loop;

	AnimationBaseState(const string &in name, uint[] framesIndices, float stride, bool loop, float priority)
	{
		this.name = name;
		this.framesIndices = framesIndices;
		this.stride = stride;
		this.priority = priority;
		this.loop = loop;
	}

	void EnterState(PlayerAnimationController@ playerAnimationController){}
	
	void UpdateState(){}

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