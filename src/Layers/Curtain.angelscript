namespace curtain {

class FadeCurtain : sef::UILayer
{
	private float m_startingDelay;
	private float m_delayElapsedTime = 0;

	private float m_curtainTime;
	private float m_elapsedTime = 0;
	private float m_bias = 0.0f;

	private string m_blankSprite = sef::options::frameworkPath + "SEF/media/sef-white.png";

	private bool m_fadeIn = true;

	FadeCurtain(const bool fadeIn, const float curtainTime = 3000, const float delay = 500)
	{
		super("FadeCurtain");
		setPopup(fadeIn);

		m_startingDelay = delay;
		m_fadeIn = fadeIn;
		m_curtainTime = curtainTime;
		m_bias = (fadeIn) ? 0.0f : 1.0f;
	}

	void draw() override
	{
		const vector2 screenSize(GetScreenSize());
		SetSpriteOrigin(m_blankSprite, vector2(0));
		DrawShapedSprite(m_blankSprite, vector2(0), screenSize, sef::Color(1.0f - m_bias, vector3(0.0f)).getUInt());
	}

	void update() override
	{
		m_delayElapsedTime += GetLastFrameElapsedTimeF();
		if (m_delayElapsedTime < m_startingDelay)
			return;

		m_elapsedTime += GetLastFrameElapsedTimeF();
		if (m_elapsedTime > m_curtainTime)
			m_elapsedTime = m_curtainTime;

		m_bias = sef::easing::smoothBeginning(m_elapsedTime / m_curtainTime);
		if (!m_fadeIn)
		{
			m_bias = 1.0f - m_bias;
		}
	}

	bool isFinished() const
	{
		return (m_elapsedTime >= m_curtainTime);
	}

	bool isEmpty() const override
	{
		return isFinished();
	}

	bool isAlwaysActive() const override
	{
		return true;
	}
}

void fadeOut(const float curtainTime, const float delay)
{
	sef::UILayerManager@ layerManager = sef::util::getBaseStateLayerManager();

	FadeCurtain curtain(false /*fadeIn*/, curtainTime, delay);
	layerManager.insertLayer(@curtain);
}

void fadeIn(const float curtainTime, const float delay)
{
	sef::UILayerManager@ layerManager = sef::util::getBaseStateLayerManager();

	FadeCurtain curtain(true /*fadeIn*/, curtainTime, delay);
	layerManager.insertLayer(@curtain);
}

} // namespace curtain