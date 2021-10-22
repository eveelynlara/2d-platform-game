class Anim
{
	private string name;
	private uint[] framesIndices;
	private float stride;
	private float priority;
	private float elapsedTime;
	private sef::FrameTimer frameTimer;
	private uint frame;
	private bool loop;

	Anim(const string &in name, uint[] framesIndices, float stride, bool loop, float priority)
	{
		this.name = name;
		this.framesIndices = framesIndices;
		this.stride = stride;
		this.priority = priority;
		this.loop = loop;
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
}