class OptionsLayer : sef::DefaultPopup
{
	OptionsLayer(sef::UILayerManager@ layerManager, sef::UILayer@ currentLayer)
	{
		super("OptionsLayer", "", @layerManager, @currentLayer);

		sef::parseLayerFileAndAddTo(GetResourceDirectory() + "layers/Options.layer", this, sef::StaticFont());		
	}

	bool detectEscapeTouch() const override
	{
		return false;
	}
}
