class JumpRiseState : AnimationBaseState
{
    private PlayAnim@ m_playAnim;
    private ETHEntity@ m_entity;
    private int lastMovementDir;

    JumpRiseState(const string &in name, uint[] framesIndices, float stride, bool loop, float priority)
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

        lastMovementDir = m_playAnim.GetPlayerController().GetLastMovementDir();
        m_entity.SetFlipX(lastMovementDir < 0);

        if(!isTouchingGround)
        {  
            m_entity.SetFrame(GetAnimationFrame());
        
            if(m_playAnim.GetPlayerController().GetPlayerInputController().GetAttackHit() == 1)
            {
                m_playAnim.SwitchState(@m_playAnim.basicSwordAttackState);
            }    
            if(m_playAnim.GetPlayerController().GetSpeed().y > 0)
            {
                m_playAnim.SwitchState(@m_playAnim.jumpFallState);
            }
        }
    }
}