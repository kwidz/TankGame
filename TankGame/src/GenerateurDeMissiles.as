package  
{
	/**
	 * ...
	 * @author geoffrey glangine
	 */
	public class GenerateurDeMissiles 
	{

		public function GenerateurDeMissiles() 
		{
			
		}
		public static function EnvoyerRocket(score:Score):void {
			for (var i:int = 0; (i < score.level)&&(i < 4)&&(Constantes.LesRoquettes.length<score.level)&&(Constantes.LesRoquettes.length<4); i++) 
			{
					var rocket:Rocket = new Rocket(Constantes.tank.base);
					Constantes.partie.addChild(rocket);
					Constantes.LesRoquettes.push(rocket);
			
			}
			
		}
	}

}