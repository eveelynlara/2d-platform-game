class Team
{
    private string m_teamName;
    private ITeamMember@[] members;

    Team(const string &in teamName)
    {
        m_teamName = teamName;
    }

    void addTeamMember(ITeamMember@ newMember)
    {
        members.insertLast(@newMember);
        newMember.SetTeam(@this);
    }
    
    bool IsInTeam(ITeamMember@ member)
    {
        //TODO: check if it is the same team
        return true;
    }

    string GetTeamName()
    {
        return m_teamName;
    }
}