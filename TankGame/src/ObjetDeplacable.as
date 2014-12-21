package  
{
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.geom.Point;
	/**
	 * ...
	 * @author geoffrey glangine
	 */
	public class ObjetDeplacable extends MovieClip
	{
		public var vitesse:Point = new Point();
		public var estFusee:Boolean = false;
		
		public var acceleration:Point = new Point();
		public var LIMITE_VITESSE:uint = 10;
		
		
		public function ObjetDeplacable(vitesseX:Number, vitesseY:Number) 
		{
			vitesse.x = vitesseX;
			vitesse.y = vitesseY;
			acceleration.x = 0;
			acceleration.y = 0;
			addEventListener(Event.ENTER_FRAME, enterFrameHandler);
		}
		public function destruct():void 
		{
			removeEventListener(Event.ENTER_FRAME, enterFrameHandler);
		}
		private function enterFrameHandler(e:Event):void 
		{
			vitesse.x += acceleration.x;
			vitesse.y += acceleration.y;
			limiteVitesse()
			if (this is Balle) {
				if (TestColisions.testWallBottom(Balle(this))) 
				{
					this.vitesse.y = - vitesse.y;
				}
				if (TestColisions.testWall(Balle(this))) 
				{
					this.vitesse.x = -vitesse.x; 
				}
			}
			if (TestColisions.testWall(this)&&!estFusee&&!(this is Balle)) {
				this.vitesse.x = -vitesse.x;
				this.vitesse.y = -vitesse.y;
				this.x += vitesse.x*3;
				this.y += vitesse.y*3;
			}
			else{
				this.x += vitesse.x;
				this.y += vitesse.y;
			}
			
		}
		private function limiteVitesse():void 
		{
			if (vitesse.length > LIMITE_VITESSE)
			{
				vitesse.normalize(LIMITE_VITESSE);
				acceleration.x = 0;
				acceleration.y = 0;
			}
		}
		
	}

}