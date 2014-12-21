package  
{
	import flash.display.MovieClip;
	import flash.events.Event;
	
	/**
	 * ...
	 * @author geoffrey glangine
	 */
	public class FlagPole extends MovieClip 
	{
		public var pointage:Score;
		public var tank:Tank;
		public var flagHitArea:MovieClip = new MovieClip();
		public function FlagPole(pointage:Score, tank:Tank) 
		{
			this.pointage = pointage;
			super();
			this.tank = tank;
			this.addEventListener(Event.ENTER_FRAME, enterFrameHandler);
			placer();
			
		}
		
		private function enterFrameHandler(e:Event):void 
		{
			if (this.flagHitArea.hitTestObject(tank.base.hitBox) || this.flagHitArea.hitTestObject(tank.base.hitBox2)) {
				pointage.pointage += 500;
				placer();
				pointage.level += 1;
				GenerateurDeMissiles.EnvoyerRocket(pointage);
			}
		}
		public function destruct():void {
			this.removeEventListener(Event.ENTER_FRAME, enterFrameHandler);
		}
		private function placer():void 
		{			
			do
			{
				this.x = Math.round(Math.random() * (700-50 + 1) + ( 50 - .5)); 
				this.y = Math.round(Math.random() * (600 -150 + 1) + (150 -.5)); 
				
				Constantes.partie.addChild(this);
			}while (!(TestColisions.testWall || this.flagHitArea.hitTestObject(tank.base.hitBox) || this.flagHitArea.hitTestObject(tank.base.hitBox2)))
		}
		
		
		
	}

}