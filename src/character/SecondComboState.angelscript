class SecondComboState : AnimationBaseState
{
    private PlayerAnimationController@ m_playerAnimationController;
    private ETHEntity@ m_entity;
    private int lastMovementDir;
    private int combo = 0;

    SecondComboState(const string &in name, uint[] framesIndices, float stride, bool loop, float priority)
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
        bool isTouchingGround = m_playerAnimationController.GetPlayerController().IsTouchingOnlyGround();
        m_entity.SetFrame(GetAnimationFrame());

        if(IsAnimationFisnished())
        {
            m_entity.SetUInt("attacking", 0);
            if(!isTouchingGround)
            {  
                if(m_playerAnimationController.GetPlayerController().GetSpeed().y < 0)
                {
                    ResetAnimation();
                    m_playerAnimationController.SwitchState(@m_playerAnimationController.jumpRiseState);
                }
            }
            else
            {
                if(m_playerAnimationController.GetPlayerController().GetPlayerInputController().GetDirection().x != 0)
                {
                    ResetAnimation();
                    m_playerAnimationController.SwitchState(@m_playerAnimationController.walkingState);
                }
                else
                {
                    ResetAnimation();
                    m_playerAnimationController.SwitchState(@m_playerAnimationController.idleState);
                }
            }
        }
    }
}