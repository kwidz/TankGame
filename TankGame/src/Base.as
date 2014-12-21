package  
{
	import flash.display.MovieClip;
	import flash.events.Event;
	/**
	 * ...
	 * @author geoffrey glangine
	 */
	public class Base extends ObjetDeplacable
	{
		public var leftTreds:MovieClip = new MovieClip();
		public var rightTreds:MovieClip = new MovieClip();
		public var hitBox2:MovieClip = new MovieClip();
		public var hitBox:MovieClip = new MovieClip();
		
		public function Base() 
		{
			super(0, 0);
		}

		
	}

}