#include "SEF/SEF.angelscript"

#include "src/Layers/Curtain.angelscript"
#include "src/Layers/StartScreenLayer.angelscript"
#include "src/Layers/OptionsLayer.angelscript"

#include "src/Game_State/StartScreenState.angelscript"
#include "src/Game_State/GameState.angelscript"

#include "src/Animations/AnimationBaseState.angelscript"
#include "src/Animations/PlayerAnimationController.angelscript"

#include "src/Animations/Animation_States/FallingAnimationState.angelscript"
#include "src/Animations/Animation_States/IdleAnimationState.angelscript"
#include "src/Animations/Animation_States/JumpingAnimationState.angelscript"
#include "src/Animations/Animation_States/WalkingAnimationState.angelscript"


#include "src/Character/Character.angelscript"
#include "src/Character/CharactersManager.angelscript" 
#include "src/Character/PlayerController.angelscript"

#include "src/Character/Attack/IDamageable.angelscript"
#include "src/Character/Attack/ITeamMember.angelscript"
#include "src/Character/Attack/Team.angelscript"

#include "src/Character/Input_Controller/KeyInputController.angelscript"
#include "src/Character/Input_Controller/MovementBubbleGumController.angelscript" 
#include "src/Character/Input_Controller/PlayerInputController.angelscript"

#include "src/Character/Movement/PlayerBaseState.angelscript"
#include "src/Character/Movement/PlayerStateFactory.angelscript"
#include "src/Character/Movement/PlayerStateMachine.angelscript"

#include "src/Character/Movement/Movement_States/BasicSwordAttackState.angelscript"
#include "src/Character/Movement/Movement_States/PlayerGroundedState.angelscript"
#include "src/Character/Movement/Movement_States/PlayerIdleState.angelscript"
#include "src/Character/Movement/Movement_States/PlayerJumpState.angelscript"
#include "src/Character/Movement/Movement_States/PlayerWalkState.angelscript"
#include "src/Character/Movement/Movement_States/SecondComboState.angelscript"

#include "src/Gameplay/Spawner.angelscript"
#include "src/Gameplay/CameraController.angelscript"

#include "src/Weapons/BasicSlashMeleeWeapon.angelscript"
#include "src/Weapons/IWeapon.angelscript"
#include "src/Weapons/ScheduleAttackEvent.angelscript" 

void main()
{
	sef::init(720.0f /*virtual height*/, 0xFF222222, @customInitialState);
	sef::options::frameworkPath = "";
}

sef::BaseState@ customInitialState()
{
	return StartScreenState();
}