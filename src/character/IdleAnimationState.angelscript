class IdleAnimationState : AnimationBaseState
{
    private PlayerAnimationController@ m_playerAnimationController;
    private ETHEntity@ m_entity;

    IdleAnimationState(const string &in name, uint[] framesIndices, float stride, bool loop, float priority)
    {
        super(name, framesIndices, stride, loop, priority);
    }

    void EnterState(PlayerAnimationController@ playerAnimationController) override
    {
        @m_playerAnimationController = @playerAnimationController;
        @m_entity = @playerAnimationController.GetPlayerController().GetCharacter().GetEntity();
        m_entity.SetFrame(frameColumn, frameRow);
    }

    void UpdateState() override
    {
        bool isTouchingGround = m_playerAnimationController.GetPlayerController().IsTouchingOnlyGround();

        if(m_playerAnimationController.GetPlayerController().GetPlayerInputController().GetAttackHit() == 1)
		{
            m_playerAnimationController.SwitchState(@m_playerAnimationController.basicSwordAttackState);
        }

        if(m_playerAnimationController.GetPlayerController().GetPlayerInputController().GetDirection().x == 0)
        {
            m_entity.SetFrame(GetAnimationFrame());
        }
        else
        {
            m_playerAnimationController.SwitchState(@m_playerAnimationController.walkingState);
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