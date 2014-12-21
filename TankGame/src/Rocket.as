package  
{
	import flash.events.Event;
	/**
	 * ...
	 * @author geoffrey glangine
	 */
	public class Rocket extends ObjetDeplacable
	{
		public var position:String;
		public var base:Base;
		public var lesPosition:Array = new Array("hautGauche", "hautDroite", "basGauche", "basDroite");
		public var enVie:Boolean = true;
		public function Rocket(base:Base) 
		{
			super(.2, .2)
			this.base = base;
			positionner();
			addEventListener(Event.ENTER_FRAME, enterFrameHandler);
			this.estFusee = true;
		}
		
		private function enterFrameHandler(e:Event):void 
		{
			lancer();
			if(!Constantes.tank.death)
			if(enVie)
			if (this.hitTestObject(Constantes.tank.base.hitBox) || this.hitTestObject(Constantes.tank.base.hitBox2)) {
				Constantes.tank.turret.gotoAndPlay(1);
				Constantes.tank.death = true;
				this.destruct2();
				Constantes.sonExplosionTank.play();
				this.visible = false;
				trace("destructiuon");
			}
		}
		public function destruct2():void 
		{
			super.destruct();
			removeEventListener(Event.ENTER_FRAME, enterFrameHandler);
		}
		
		public function positionner():void
		{
			do
			{
				setPosition()
			}
			while (!verifierPosition()) ;

			if(position=="hautGauche")
			{
				this.x = -150;
				this.y = -150;
			}
			if(position=="hautDroite")
			{
				this.x = 950;
				this.y = -150;
			}

			if(position=="basGauche")
			{
				this.x = -150;
				this.y = 750;
			}

			if(position=="basDroite")
			{
				this.x = 950;
				this.y = 750;
			}


			
		}
		public function lancer():void
		{
			var distanceX:Number = base.x - this.x;
			var distanceY:Number = base.y - this.y;
			var angle:int = Trigo.retourneAngleEntreDeuxObjets(distanceX, distanceY);
			this.rotation = angle;
			this.acceleration.x = Trigo.retournerVitesseX(.4, angle);
			this.acceleration.y = Trigo.retournerVitesseY(.4, angle);
			
		}

		public function verifierPosition():Boolean {
			for (var i:int = 0; i < Constantes.LesRoquettes.length; i++) 
			{
				if (Constantes.LesRoquettes[i].position == this.position)
					return false;
			}
			return true;
		}
		public function setPosition():void 
		{
			var valeur_MIN:int = 0;
			var valeur_MAX:int = 3;
			var valeur_aleatoire:Number = Math.round(Math.random() * (valeur_MAX - valeur_MIN + 1) + (valeur_MIN - .5)); 
			position = lesPosition[valeur_aleatoire];
		}
		
		
	}

}