package  
{
	import flash.display.DisplayObject;
	import flash.display.SimpleButton;
	
	/**
	 * ...
	 * @author geoffrey glangine
	 */
	public class PlayAgain extends SimpleButton 
	{
		
		public function PlayAgain(upState:DisplayObject=null, overState:DisplayObject=null, downState:DisplayObject=null, hitTestState:DisplayObject=null) 
		{
			super(upState, overState, downState, hitTestState);
			this.x = 410;
			this.y = 338;
			
		}
		
	}

}