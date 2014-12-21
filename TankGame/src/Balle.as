package  
{
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.text.TextField;
	
	/**
	 * ...
	 * @author geoffrey glangine
	 */
	public class Balle extends ObjetDeplacable 
	{
		private var largeurEcran:int = 800;
		private var hauteurEcran:int = 600;
		private var pointage:Score;
		public var score:TextField = new TextField();
		public function Balle(x:Number, y:Number, pointage:Score) 
		{
			super(0, 0);
			this.x = x;
			this.y = y;
			this.pointage = pointage;
			addEventListener(Event.ENTER_FRAME, enterFrameHandler);
			
		}
		
		private function enterFrameHandler(e:Event):void 
		{		
			
			if(!verifierLimites()){
				for (var i:int = 0; i < Constantes.LesRoquettes.length; i++) 
				{
					
			
					if (this.hitTestObject(Constantes.LesRoquettes[i])) {
						Constantes.LesRoquettes[i].enVie = false;
						Rocket(Constantes.LesRoquettes[i]).LIMITE_VITESSE = 0;
						Rocket(Constantes.LesRoquettes[i]).vitesse.normalize(0);
						Rocket(Constantes.LesRoquettes[i]).gotoAndPlay(2);
						Constantes.sonExplosionRockette.play();
						Rocket(Constantes.LesRoquettes[i]).destruct();
						Constantes.LesRoquettes.splice(i,1);
						
						Constantes.LesBalles.splice(Constantes.LesBalles.indexOf(this), 1);
						this.destruct2();
						this.gotoAndPlay(2);
						this.addEventListener(Event.ENTER_FRAME, enleverDuStage);
						pointage.pointage += 50;
						GenerateurDeMissiles.EnvoyerRocket(pointage);
					}
				}
			}
			else
			{
				Constantes.partie.removeChild(this);
				Constantes.LesBalles.splice(Constantes.LesBalles.indexOf(this), 1);
				this.removeEventListener(Event.ENTER_FRAME, enterFrameHandler);
			}
			
		}
		public function lancerAngle(vitesse:Number,angle:Number):void
		{
			this.rotation = angle;
			this.vitesse.x = Trigo.retournerVitesseX(vitesse, angle);
			this.vitesse.y = Trigo.retournerVitesseY(vitesse, angle);
			
		}
		public function destruct2():void {
			this.removeEventListener(Event.ENTER_FRAME, enterFrameHandler);
			super.destruct();
		}
		private function verifierLimites():Boolean 
		{
			if (this.x > largeurEcran + this.width * .5) {
				return true;
				
			}
			else 
			{
				if (this.x < 0 - this.width * .5) {
					return true;
				}
			}
			if (this.y > hauteurEcran + this.height * .5) {
				return true;
				
			}
			else 
			{
				if (this.y < 0 - this.height * .5) {
					return true;
				}
			}
			return false;
			
		}
		private function enleverDuStage(e:Event):void 
		{
			if(this.currentFrame==23){
				Constantes.partie.removeChild(this);
				this.removeEventListener(Event.ENTER_FRAME, enleverDuStage);
			}
			
		}
		
	}

}