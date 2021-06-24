class StartScreenState : sef::BaseState
{
	StartScreenState()
	{
		super("empty", vector2(sef::getFixedHeight() / 2.0f) /*bucketSize*/);
		sef::state::backgroundColor = 0xFF222222;
	}

	void onCreated() override
	{
		BaseState::onCreated();

		// insert ui layer
		StartScreenLayer startScreenLayer();
		addLayer(@startScreenLayer);
		setCurrentLayer(startScreenLayer.getName());

		curtain::fadeIn(500, 0);
	}

	void onUpdate() override
	{
		BaseState::onUpdate();
	}
}
