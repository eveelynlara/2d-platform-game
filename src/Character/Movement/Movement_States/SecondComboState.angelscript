class SecondComboState : AnimationBaseState
{
    private int combo = 0;

    SecondComboState(PlayerController@ playerController, const string &in name, uint[] framesIndices, float stride, bool loop, float priority)
    {
        super(@playerController, name, framesIndices, stride, loop, priority);
    }

    void EnterState()
    {
    }

    void UpdateState() override
    {
        m_entity.SetFrame(GetAnimationFrame());
    }
}