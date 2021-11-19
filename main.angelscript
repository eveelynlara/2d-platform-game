#include "SEF/SEF.angelscript"

#include "src/StartScreenState.angelscript"
#include "src/StartScreenLayer.angelscript"
#include "src/OptionsLayer.angelscript"
#include "src/GameState.angelscript"

#include "src/character/Anim.angelscript"
#include "src/character/Character.angelscript"
#include "src/character/CharactersManager.angelscript" 
#include "src/character/Controller.angelscript"
#include "src/character/MovementByKeysController.angelscript"
#include "src/character/MovementBubbleGumController.angelscript" 
#include "src/character/MoveVelocity.angelscript"
#include "src/character/PlayAnim.angelscript"

#include "src/Curtain.angelscript"
#include "src/CameraController.angelscript"

#include "src/damage/DeathOnDamage.angelscript"
#include "src/damage/IDamageable.angelscript"

#include "src/weapon/IWeapon.angelscript"
#include "src/weapon/MeleeWeapon.angelscript"

void main()
{
	sef::init(720.0f /*virtual height*/, 0xFF222222, @customInitialState);
	sef::options::frameworkPath = "";
}

sef::BaseState@ customInitialState()
{
	return StartScreenState();
}