class WalkingAnimationState : AnimationBaseState
{
    private PlayerAnimationController@ m_playerAnimationController;
    private ETHEntity@ m_entity;
    private int lastMovementDir;

    WalkingAnimationState(const string &in name, uint[] framesIndices, float stride, bool loop, float priority)
    {
        super(name, framesIndices, stride, loop, priority);
    }

    void EnterState(PlayerAnimationController@ playerAnimationController) override
    {
        @m_playerAnimationController = @playerAnimationController;
        @m_entity = @playerAnimationController.GetPlayerController().GetCharacter().GetEntity();
    }

    void UpdateState() override
    {
        bool isTouchingGround = m_playerAnimationController.GetPlayerController().isTouchingOnlyGround();
        lastMovementDir = m_playerAnimationController.GetPlayerController().GetLastMovementDir();

        m_entity.SetFlipX(lastMovementDir < 0);

        if(m_playerAnimationController.GetPlayerController().GetPlayerInputController().GetAttackHit() == 1)
		{
            m_playerAnimationController.SwitchState(@m_playerAnimationController.basicSwordAttackState);
        }
        else
        {
            if(m_playerAnimationController.GetPlayerController().GetPlayerInputController().GetDirection().x != 0)
            {
                m_entity.SetFrame(GetAnimationFrame());
            }
            else if(m_playerAnimationController.GetPlayerController().GetPlayerInputController().GetDirection().x == 0)
            {
                m_playerAnimationController.SwitchState(@m_playerAnimationController.idleState);
            }
            
            if(!isTouchingGround)
            {
                if(m_playerAnimationController.GetPlayerController().GetSpeed().y < 0)
                {
                    m_playerAnimationController.SwitchState(@m_playerAnimationController.jumpRiseState);
                }
                else
                {
                    m_playerAnimationController.SwitchState(@m_playerAnimationController.jumpFallState);
                }
            }
        }
    }
}