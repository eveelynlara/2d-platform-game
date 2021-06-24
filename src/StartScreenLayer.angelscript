class StartScreenLayer : sef::UISchedulerLayer
{
	StartScreenLayer()
	{
		super("StartScreenLayer", true /*iterable*/, "start");

		sef::parseLayerFileAndAddTo(GetResourceDirectory() + "layers/StartScreen.layer", this, sef::StaticFont());		

		LoadSoundEffect("soundfx/button.mp3");
		LoadSoundEffect("soundfx/click.mp3");
	}

	void update() override
	{
		UISchedulerLayer::update();

		if (isButtonPressed("options"))
		{
			sef::util::callLayer(OptionsLayer(sef::util::getBaseStateLayerManager(), @this));
		}

		if (isButtonPressed("start"))
		{
			scheduleOperation("start");
			curtain::fadeOut(500, 0);
		}

		if (getScheduledOperation() == "start")
		{
			sef::StateManager.setState(GameState());
		}
	}
}
