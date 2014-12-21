package  
{
	import flash.display.MovieClip;
	import flash.display.SimpleButton;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.media.Sound;
	import flash.media.SoundChannel;
	import flash.text.TextField;
	import flash.ui.Keyboard;
	import flash.ui.Mouse;
	/**
	 * ...
	 * @author geoffrey glangine
	 */
	public class Partie extends MovieClip
	{
		public var pointeur:PointeurBlanc = new PointeurBlanc();
		public var tank:Tank;
		public var rocket:Rocket;
		private var tankAvance:Boolean = false;
		private var tankRecule:Boolean = false;
		private var leftTredForward:Boolean=false;
		private var leftTredReverse:Boolean=false;
		private var rightTredForward:Boolean=false;
		private var rightTredReverse:Boolean = false;
		public var pointage:Score = new Score();
		public var wallTop:MovieClip = new MovieClip();
		public var wallMidle:MovieClip = new MovieClip();
		public var wallBottom:MovieClip = new MovieClip();		
		public var wallLeft:MovieClip = new MovieClip();
		public var wallRight:MovieClip = new MovieClip();
		public var flag:FlagPole;
		public var playAgain:PlayAgain = Constantes.playAgain;
		public var score:TextField;
		public var boucleSon:SoundChannel;
		public function Partie(wallTop:MovieClip, wallMidle:MovieClip, wallBottom:MovieClip, wallLeft:MovieClip, wallRight:MovieClip, score:TextField) 
		{
			
			this.wallTop  = wallTop;
			this.wallMidle = wallMidle;
			this.wallBottom = wallBottom;
			this.wallLeft = wallLeft;
			this.wallRight = wallRight;
			this.score = score;
			
			boucleSon = Constantes.sonMoteur.play();
			boucleSon.addEventListener(Event.SOUND_COMPLETE,boucle);
			Constantes.sonMoteur.addEventListener(Event.SOUND_COMPLETE, boucle);
			playAgain.visible = false;
			Constantes.wallBottom = wallBottom;
			Constantes.wallLeft = wallLeft;
			Constantes.wallMidle = wallMidle;
			Constantes.wallRight = wallRight;
			Constantes.wallTop = wallTop;
			Mouse.hide();
			trace("test");
			addEventListener(Event.ENTER_FRAME, enterFrameHandler);
			Constantes.stage.mouseChildren = false;
			Constantes.partie = this;
			Constantes.stage.addEventListener(KeyboardEvent.KEY_DOWN, keyDownHandler);
			Constantes.stage.addEventListener(KeyboardEvent.KEY_UP, keyUpHandler);
			Constantes.stage.addEventListener(MouseEvent.MOUSE_MOVE, mouseMouveHandler);
			Constantes.stage.addEventListener(MouseEvent.CLICK, mouseClickHandler);
			addChild(pointeur);
			tank = new Tank(pointeur);
			Constantes.tank = tank;
			addChild(tank);
			flag = new FlagPole(pointage, tank);
			rocket = new Rocket(tank.base);
			addChild(rocket);
			Constantes.LesRoquettes.push(rocket);
			Constantes.LesBalles = new Array();
			Constantes.stage.addChild(playAgain);
			//afficherRejouer();
			//playAgain.addEventListener(MouseEvent.CLICK, clickButton);			
		}
		
		private function boucle(e:Event):void 
		{			
			boucleSon.removeEventListener(Event.SOUND_COMPLETE, boucle); //Supprime l'écouteur actuel
			boucleSon = new SoundChannel(); //Remplace le lecteur de son par un nouveau
			boucleSon = Constantes.sonMoteur.play(); //Lancement de la lecture du son
			boucleSon.addEventListener(Event.SOUND_COMPLETE, boucle); //Applique un écouteur détectant la fin de lecture du son 
		}
		
		public function afficherRejouer():void {
			for (var i:int = 0; i < Constantes.LesRoquettes.length; i++) 
			{
				Constantes.LesRoquettes[i].destruct2();
				Constantes.partie.removeChild(Constantes.LesRoquettes[i]);
				
			}
			boucleSon.removeEventListener(Event.SOUND_COMPLETE, boucle);
			boucleSon.stop();
			Constantes.LesRoquettes = [];
			for (i = 0; i < Constantes.LesBalles.length; i++) 
			{
				Constantes.LesBalles[i].destruct2();
				
			}
			tank.destruct();
			tank.turret.destruct();
			tank.base.destruct();
			flag.destruct();
			Constantes.LesBalles = [];
			removeEventListener(Event.ENTER_FRAME, enterFrameHandler);
			Constantes.stage.removeEventListener(KeyboardEvent.KEY_DOWN, keyDownHandler);
			Constantes.stage.removeEventListener(KeyboardEvent.KEY_UP, keyUpHandler);
			Constantes.stage.removeEventListener(MouseEvent.MOUSE_MOVE, mouseMouveHandler);
			Constantes.stage.removeEventListener(MouseEvent.CLICK, mouseClickHandler);
			//Constantes.stage.removeChild(flag);
			pointeur.visible = false;
			Mouse.show();
			Constantes.stage.mouseChildren = true;
			playAgain.visible = true;
		}
		
		//private function clickButton(e:MouseEvent):void 
		//{
			//trace(parent);
			
			//Constantes.main.rejouer();
		//}
		
		private function mouseClickHandler(e:MouseEvent):void 
		{
			trace(Constantes.LesBalles.length);
			if(!(e.target is SimpleButton))
			if (Constantes.LesBalles.length < 5) {
				Constantes.sonCannon.play();
				trace(Constantes.LesBalles.length);
				var balle:Balle = new Balle(tank.turret.x, tank.turret.y, pointage);
				Constantes.LesBalles.push(balle);
				addChildAt(balle, 1);
				balle.lancerAngle(10, tank.turret.rotation);
				
			}
		}
		
		private function mouseMouveHandler(e:MouseEvent):void 
		{
			
			pointeur.x = mouseX;
			pointeur.y = mouseY;
		}
		
		private function enterFrameHandler(e:Event):void 
		{
			score.text = "Score : " + pointage.pointage;	
			if (tankAvance) {
				tank.base.vitesse.x = Trigo.retournerVitesseX(1,tank.base.rotation+180+90);
				tank.base.vitesse.y = Trigo.retournerVitesseY(1, tank.base.rotation + 180 + 90);
			}else if (tankRecule) {
				tank.base.vitesse.x = Trigo.retournerVitesseX(1, tank.base.rotation+90);
				tank.base.vitesse.y = Trigo.retournerVitesseY(1, tank.base.rotation + 90);
				
			}

			
		}
		
		private function keyUpHandler(e:KeyboardEvent):void 
		{
			
			switch(e.keyCode)
			{
				// déplacement vers la gauche
				case Keyboard.LEFT:
					tank.base.leftTreds.gotoAndStop(1);
					tank.base.rightTreds.gotoAndStop(1);
					tank.vitesseRotation = 0;
					leftTredForward = false;
					leftTredReverse = false;
					rightTredForward = false;
					rightTredReverse = false;
					if (tankAvance&& !leftTredForward && !rightTredForward) {
						tank.base.leftTreds.gotoAndPlay("forward");
						tank.base.rightTreds.gotoAndPlay("forward");
						leftTredForward = true;
						rightTredForward = true;
						leftTredReverse = false;
						rightTredReverse = false;
					}
					if (tankRecule && !leftTredReverse && !rightTredReverse)
					{
						tank.base.leftTreds.gotoAndPlay("reverse");
						tank.base.rightTreds.gotoAndPlay("reverse");	
						leftTredReverse = true;
						rightTredReverse = true;
						leftTredForward = false;
						rightTredForward = false;
					}
					break;
				case Keyboard.RIGHT:
					tank.base.leftTreds.gotoAndStop(1);
					tank.base.rightTreds.gotoAndStop(1);
					tank.vitesseRotation = 0;
					leftTredForward = false;
					leftTredReverse = false;
					rightTredForward = false;
					rightTredReverse = false;
					if (tankAvance&& !leftTredForward && !rightTredForward) {
						tank.base.leftTreds.gotoAndPlay("forward");
						tank.base.rightTreds.gotoAndPlay("forward");
						leftTredForward = true;
						rightTredForward = true;
						leftTredReverse = false;
						rightTredReverse = false;
					}
					if (tankRecule && !leftTredReverse && !rightTredReverse)
					{
						tank.base.leftTreds.gotoAndPlay("reverse");
						tank.base.rightTreds.gotoAndPlay("reverse");
						leftTredReverse = true;
						rightTredReverse = true;
						leftTredForward = false;
						rightTredForward = false;
					}
					break;
				case Keyboard.UP:
					tank.base.leftTreds.gotoAndStop(1);
					tank.base.rightTreds.gotoAndStop(1);
					leftTredForward = false;
					leftTredReverse = false;
					rightTredForward = false;
					rightTredReverse = false;
					tank.base.vitesse.x = 0;
					tank.base.vitesse.y = 0;					
					tankAvance = false;
					break;
				case Keyboard.DOWN:
					tank.base.leftTreds.gotoAndStop(1);
					tank.base.rightTreds.gotoAndStop(1);
					leftTredForward = false;
					leftTredReverse = false;
					rightTredForward = false;
					rightTredReverse = false;
					tank.base.vitesse.x = 0;
					tank.base.vitesse.y = 0;
					tankRecule = false;
					break;
			}
		}
		
		private function keyDownHandler(e:KeyboardEvent):void 
		{
				switch(e.keyCode)
			{
				// déplacement vers la gauche
				case Keyboard.LEFT:
					if(!leftTredReverse){
						tank.base.leftTreds.gotoAndPlay("reverse");
						leftTredReverse = true;
						leftTredForward = false;
						}
					if(!rightTredForward){
						tank.base.rightTreds.gotoAndPlay("forward");
						rightTredForward = true;
						rightTredReverse = false;
						}
					
					tank.vitesseRotation = -1;
					break;
				// déplacement vers la droite
				case Keyboard.RIGHT:
					if(!leftTredForward){
						tank.base.leftTreds.gotoAndPlay("forward");
						leftTredForward = true;
						leftTredReverse = false;
					}
					if(!rightTredReverse){
						tank.base.rightTreds.gotoAndPlay("reverse");
						rightTredReverse = true;
						rightTredForward = false;
					}
					tank.vitesseRotation = 1;
					break;
				case Keyboard.UP:
					tankAvance = true;	
					if(!leftTredForward){
						tank.base.leftTreds.gotoAndPlay("forward");
						leftTredForward = true;
						leftTredReverse = false;
					}
					if(!rightTredForward){
						tank.base.rightTreds.gotoAndPlay("forward");
						rightTredForward = true;
						rightTredReverse = false;
						}
					
					break;
				case Keyboard.DOWN:
					if(!leftTredReverse){
						tank.base.leftTreds.gotoAndPlay("reverse");
						leftTredReverse = true;
						leftTredForward = false;
					}
					if(!rightTredReverse){
						tank.base.rightTreds.gotoAndPlay("reverse");
						rightTredReverse = true;
						rightTredForward = false;
					}
					tankRecule = true;
					break;
			}
		}
		
	}

}