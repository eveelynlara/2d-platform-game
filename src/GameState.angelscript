class GameState : sef::BaseState
{
	sef::UISchedulerLayer@ m_hudLayer;

	CameraController m_cameraController;
	private Character@ m_character;
	private CharactersManager m_charactersManager;

	ETHEntity@ m_spaceShip;

	GameState()
	{
		super("scenes/level1.esc", vector2(sef::getFixedHeight() / 2.0f) /*bucketSize*/);
		sef::state::backgroundColor = 0xFF000000;
	}

	void onCreated() override
	{
		const vector2 screenMiddle(GetScreenSize() * 0.5f);
		@m_character = Character("adventurer.ent", screenMiddle + 20.0f, 0);
		m_character.GetPlayAnim().GetMoveVelocity().GetEntity().SetInt("hp", 100);
		m_charactersManager.addCharacter(@m_character);

		BaseState::onCreated();

		curtain::fadeIn(500, 0);

		SetParallaxIntensity(6.0f);

		addController(@m_cameraController);

		// insert ui layer
		@m_hudLayer = sef::UISchedulerLayer("HUD", false /*iterable*/);
		addLayer(@m_hudLayer);
		setCurrentLayer(m_hudLayer.getName());

		// add sample text element to hud layer
		sef::UIDrawableText textElement(
			vector2(0.5f, 0.053f) /*position*/,
			vector2(0.5f, 0.0f) /*origin*/,
			sef::StaticFont("Verdana24_shadow.fnt"),
			"Hello World!",
			2.5f /*scale*/, 
			true /*centered*/,
			sef::uieffects::createBounceAppearEffect(200, 1.1f, 500 /*delay*/, 15 /*repeats*/),
			false /*worldSpace*/,
			0x999CD92B /*ARGB*/);

		textElement.setName("instructions");

		m_hudLayer.insertElement(@textElement);

		// add back button
		sef::UIButton backButton(
			"sprites/back-button.png",
			vector2(0.053f) /*position*/,
			vector2(0.0f),
			0.5f /*scale*/);

		backButton.setName("back");
		backButton.setDismissEffect(sef::uieffects::createFadeOutEffect(600));

		m_hudLayer.insertElement(@backButton);

		// fill scene with spaceships
		for (uint t = 0; t < 80; t++)
		{
			ETHEntity@ ship;
			const vector3 pos(randF(GetScreenSize().x), randF(GetScreenSize().y), randF(-20.0f, -80.0f));
			AddEntity("space_ship.ent", pos, 0.0f, ship, "decor_space_ship", 0.9f);
			ship.SetColor(vector3(randF(1.5f), randF(1.5f), randF(1.5f)) * 0.3f);
		}
	}

	void onUpdate() override
	{
		BaseState::onUpdate();
		m_charactersManager.update();
		m_cameraController.setDest(m_character.GetPositionXY());

		// check back request
		if (m_hudLayer.isButtonPressed("back") || sef::input::global.getBackState() == KS_HIT)
		{
			m_hudLayer.scheduleOperation("backToStartScreen");
			curtain::fadeOut(500, 0);
		}

		if (m_hudLayer.getScheduledOperation() == "backToStartScreen")
		{
			sef::StateManager.setState(StartScreenState());
		}
	}
}
