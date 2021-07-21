class CharactersManager
{
	private Character@[] m_character;
	
	void addCharacter(Character@ newCharacter)
	{
		m_character.insertLast(@newCharacter);
	}
	
	void update()
	{
		for(int i = 0; i < m_character.length();)
		{
			if(m_character[i].IsDead())
			{
				m_character[i].DestroyCharacterEntity();
				m_character.removeAt(i);
				continue;
			}
			
			m_character[i].update();
			i++;
		}
	}
}
