package 
{
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	
	/**
	 * ...
	 * @author geoffrey glangine
	 */
	public class Main extends MovieClip 
	{

		public var wallTop:MovieClip = new MovieClip();
		public var wallMidle:MovieClip = new MovieClip();
		public var wallBottom:MovieClip = new MovieClip();		
		public var wallLeft:MovieClip = new MovieClip();
		public var wallRight:MovieClip = new MovieClip();
		public var score:TextField = new TextField();
		public var partie:Partie;
		public var playAgain:PlayAgain = new PlayAgain();
		public function Main():void 
		{
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event = null):void 
		{
			Constantes.sonExplosionTank = new ExplosionTankSound();
			Constantes.sonExplosionRockette = new ExplosionFuseSound();
			Constantes.sonCannon = new CannonSound();
			Constantes.sonMoteur = new TankMoteur();
			trace(stage);
			Constantes.playAgain = playAgain;
			Constantes.stage = stage;	
			Constantes.main = this;
			trace( Constantes.stage);
			playAgain.addEventListener(MouseEvent.MOUSE_UP, rejouer);
			removeEventListener(Event.ADDED_TO_STAGE, init);
			this.partie = new Partie(wallTop, wallMidle, wallBottom, wallLeft, wallRight, score);
			stage.addChild(partie);
			}
			
			public function rejouer(e:Event):void 
			{
				trace("##################");
				trace(e.target);
				trace("##################");
				stage.removeChild(partie);
				var partie2:Partie = new Partie(wallTop, wallMidle, wallBottom, wallLeft, wallRight, score);
				partie = null;
				for (var i:int = 0; i < stage.numChildren; i++) 
				{
					trace(stage.getChildAt(i));
				}
				partie = partie2;
				Constantes.partie = partie;
				stage.addChild(partie);

			}
		
		
	}
	
}