class SecondComboState : AnimationBaseState
{
    private PlayAnim@ m_playAnim;
    private ETHEntity@ m_entity;
    private int lastMovementDir;
    private int combo = 0;

    SecondComboState(const string &in name, uint[] framesIndices, float stride, bool loop, float priority)
    {
        super(name, framesIndices, stride, loop, priority);
    }

    void EnterState(PlayAnim@ playAnim) override
    {
        @m_playAnim = @playAnim;
        @m_entity = @playAnim.GetPlayerController().GetCharacter().GetEntity();
    }

    void UpdateState() override
    {
        bool isTouchingGround = m_playAnim.GetPlayerController().isTouchingOnlyGround();
        m_entity.SetFrame(GetAnimationFrame());

        if(IsAnimationFisnished())
        {
            m_entity.SetUInt("attacking", 0);
            if(!isTouchingGround)
            {  
                if(m_playAnim.GetPlayerController().GetSpeed().y < 0)
                {
                    ResetAnimation();
                    m_playAnim.SwitchState(@m_playAnim.jumpRiseState);
                }
            }
            else
            {
                if(m_playAnim.GetPlayerController().GetPlayerInputController().GetDirection().x != 0)
                {
                    ResetAnimation();
                    m_playAnim.SwitchState(@m_playAnim.walkingState);
                }
                else
                {
                    ResetAnimation();
                    m_playAnim.SwitchState(@m_playAnim.idleState);
                }
            }
        }
    }
}