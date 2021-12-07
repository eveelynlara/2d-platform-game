//checa se o botão de ataque foi pressionado:
if(GetInputHandle().GetKeyState(K_SPACE) == KS_HIT)
{
	attack();
}

void attack()
{
	sef::util::scheduleEvent(20, AddMeleeHitBoxEvent(/*tempo*/ 20, /*passa o atacante. se tiver dentro do character
		essa funcao -> */ @this));
}

class Sword_attack
{
}
//criar uma entidade temporária, que vai existir por um curto periodo de tempo

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
		const vector2 offset = vector2(5.0f, 0);
		//adicionar a entidade
		AddEntity("sword_hit.ent", vector3(m_attacker.getPositionXY() + offset, 0.0f), hitbox);

		//falar quem e o attacker dessa hitbox
		hitbox.SetObject("attacker", @m_attacker);
	}
}

void ETHCallback_sowrd_hit(ETHEntity@ thisEntity)
{
	/*dano*/
}

if(attack())
{
	//rodar o evento
	seff::util::scheduleEvent(30, AddMeleeHitBoxEvent(/*ref do player*/));
}