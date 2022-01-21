class SecondComboState : AnimationBaseState
{
    private int combo = 0;

    SecondComboState(const string &in name, uint[] framesIndices, float stride, bool loop, float priority)
    {
        super(name, framesIndices, stride, loop, priority);
    }

    void EnterState()
    {
    }

    void UpdateState() override
    {
        m_entity.SetFrame(GetAnimationFrame());

        // if(IsAnimationFisnished())
        // {
        //     m_entity.SetUInt("attacking", 0);
        //     if(!isTouchingGround)
        //     {  
        //         if(m_playerAnimationController.GetPlayerController().GetSpeed().y < 0)
        //         {
        //             ResetAnimation();
        //             m_playerAnimationController.SwitchState(@m_playerAnimationController.jumpRiseState);
        //         }
        //     }
        //     else
        //     {
        //         if(m_playerAnimationController.GetPlayerController().GetPlayerInputController().GetDirection().x != 0)
        //         {
        //             ResetAnimation();
        //             m_playerAnimationController.SwitchState(@m_playerAnimationController.walkingState);
        //         }
        //         else
        //         {
        //             ResetAnimation();
        //             m_playerAnimationController.SwitchState(@m_playerAnimationController.idleState);
        //         }
        //     }
        // }
    }
}