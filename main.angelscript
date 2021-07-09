﻿#include "SEF/SEF.angelscript"

#include "src/StartScreenState.angelscript"
#include "src/StartScreenLayer.angelscript"
#include "src/OptionsLayer.angelscript"
#include "src/GameState.angelscript"

#include "src/character/Character.angelscript"
#include "src/character/CharacterController.angelscript"
#include "src/character/MainCharacterController.angelscript"
#include "src/character/MainCharacterMovementKeys.angelscript"
#include "src/character/MoveVelocity.angelscript"
#include "src/character/PlayAnim.angelscript"


#include "src/Curtain.angelscript"
#include "src/CameraController.angelscript"

void main()
{
	sef::init(720.0f /*virtual height*/, 0xFF222222, @customInitialState);
	sef::options::frameworkPath = "";
}

sef::BaseState@ customInitialState()
{
	return StartScreenState();
}