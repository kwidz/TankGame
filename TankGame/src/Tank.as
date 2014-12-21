package  
{
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	/**
	 * ...
	 * @author geoffrey glangine
	 */
	public class Tank extends Sprite
	{
		public var base:Base = new Base();
		public var turret:Turret;
		public var pointeur:MovieClip;
		public var vitesseRotation:int = 0;
		public var death:Boolean = false;
		

		public function Tank(pointeur:MovieClip) 
		{
			
			base.x = 337;
			base.y = 213;
			turret = new Turret(pointeur);
			turret.x = base.x;
			turret.y = base.y;
			turret.scaleX = turret.scaleY = .2;
			this.pointeur = pointeur;
			base.scaleX = base.scaleY = .2;
			addChild(base);
			addChild(turret);
			addEventListener(Event.ENTER_FRAME, enterFrameHandler);
			base.leftTreds.stop();
			base.rightTreds.stop();
		}
		
		public function enterFrameHandler(e:Event):void 
		{
			if (TestColisions.testWall(this.base)) {
				base.rotation -= this.vitesseRotation *3;
				trace("colision");				
			}
			else {
				base.rotation += this.vitesseRotation;
			}
			
			
			turret.x = base.x;
			turret.y = base.y;
		}
		public function destruct():void 
		{
			removeEventListener(Event.ENTER_FRAME, enterFrameHandler);
		}
		
		
		
	}

}