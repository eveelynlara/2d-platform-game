class IdleAnimationState : AnimationBaseState
{
    IdleAnimationState(PlayerController@ playerController, const string &in name, uint[] framesIndices, float stride, bool loop, float priority)
    {
        super(@playerController, name, framesIndices, stride, loop, priority);
    }

    void EnterState()
    {
    }

    void UpdateState() override
    {
        CheckIfShouldFlip();
        m_entity.SetFrame(GetAnimationFrame());
    }
}