package  
{
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.display.Stage;
	/**
	 * ...
	 * @author geoffrey glangine
	 */
	public class Constantes 
	{
		public static var wallTop:MovieClip = new MovieClip();
		public static var wallMidle:MovieClip = new MovieClip();
		public static var wallBottom:MovieClip = new MovieClip();		
		public static var wallLeft:MovieClip = new MovieClip();
		public static var wallRight:MovieClip = new MovieClip();
		public static var LesBalles:Array = new Array();
		public static var LesRoquettes:Array = new Array();
		static public var stage:Stage;
		static public var tank:Tank;
		static public var playAgain:PlayAgain;
		static public var main:MovieClip;
		static public var partie:Partie;
		static public var sonCannon:CannonSound;
		static public var sonExplosionRockette:ExplosionFuseSound;
		static public var sonExplosionTank:ExplosionTankSound;
		static public var sonMoteur:TankMoteur;
		
		public function Constantes() 
		{
			
		}
		
	}

}