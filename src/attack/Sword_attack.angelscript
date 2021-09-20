class Sword_attack
{
}
//criar uma entidade temporária, que vai existir por um curto periodo de tempo

sword_hit

//criar event
class AddMeleeHitBoxEvent : sef::event
{
	// preciso ter uma ref do character aqui
	private Character@ m_attacker;

	AddMeleeHitBoxEvent(Character @attacker)
	{
		@m_attacker = @attacker;  
	}

	void run()
	{
		//adicionar o offset
		const vector2 offset...

		//adicionar a entidade
		AddEntity("sword_hit.ent", vector3(m_attacker.getPositionXY() + offset, 0.0f), hitbox);

		//falar quem e o attacer dessa hitbox
		hitbox.SetObject("attacker", @m_attacker);
	}
}

void ETHCallback_sowrd_hit(ETHEntity@ thisEntity)
{
	...
}

if(attack())
{
	//rodar o evento
	seff::util::scheduleEvent(300, AddMeleeHitBoxEvent(/*ref do player*/));
}