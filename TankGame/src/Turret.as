package  
{
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.events.Event;
	/**
	 * ...
	 * @author geoffrey glangine
	 */
	public class Turret extends MovieClip
	{
		public var obj:MovieClip;
		
		public function Turret(pointeur:MovieClip) 
		{
			this.obj = pointeur
			addEventListener(Event.ENTER_FRAME, enterFrameHandler);

		}
		
		private function enterFrameHandler(e:Event):void 
		{
			var distanceX:Number = obj.x - this.x;
			var distanceY:Number = obj.y - this.y;
			this.rotation = Trigo.retourneAngleEntreDeuxObjets(distanceX, distanceY);
			if (this.currentFrame == 22) {
				Constantes.tank.base.visible = false;
			}
			if (this.currentFrame == 33) {
				trace ("perdu guy");
				this.removeEventListener(Event.ENTER_FRAME, enterFrameHandler);
				Constantes.tank.visible = false;
				Constantes.partie.afficherRejouer();
			}
		}
		public function destruct():void 
		{
			removeEventListener(Event.ENTER_FRAME, enterFrameHandler);
		}
		
	}

}