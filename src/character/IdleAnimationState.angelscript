class IdleAnimationState : AnimationBaseState
{
    private PlayAnim@ m_playAnim;
    private ETHEntity@ m_entity;

    IdleAnimationState(const string &in name, uint[] framesIndices, float stride, bool loop, float priority)
    {
        super(name, framesIndices, stride, loop, priority);
    }

    void EnterState(PlayAnim@ playAnim) override
    {
        @m_playAnim = @playAnim;
        @m_entity = @playAnim.GetPlayerController().GetCharacter().GetEntity();
        m_entity.SetFrame(frameColumn, frameRow);
    }

    void UpdateState() override
    {
        bool isTouchingGround = m_playAnim.GetPlayerController().isTouchingOnlyGround();
        if(m_playAnim.GetPlayerController().GetPlayerInputController().GetDirection().x == 0)
        {
            m_entity.SetFrame(GetAnimationFrame());
        }
        else
        {
            m_playAnim.SwitchState(@m_playAnim.walkingState);
        }

        if(!isTouchingGround)
        {
            if(m_playAnim.GetPlayerController().GetSpeed().y < 0)
            {
                m_playAnim.SwitchState(@m_playAnim.jumpRiseState);
            }
            else
            {
                m_playAnim.SwitchState(@m_playAnim.jumpFallState);
            }
        }
    }
}