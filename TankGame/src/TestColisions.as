package  
{
	import flash.display.MovieClip;
	/**
	 * ...
	 * @author geoffrey glangine
	 */
	public class TestColisions 
	{
		
		public function TestColisions() 
		{
			
		}
		
		public static function testWall(object:MovieClip):Boolean 
		{
			if(object is Base){
			if (object.hitBox.hitTestObject(Constantes.wallTop.hitBox)||object.hitBox.hitTestObject(Constantes.wallBottom.hitBox)||object.hitBox.hitTestObject(Constantes.wallMidle.hitBox)||object.hitBox.hitTestObject(Constantes.wallLeft.hitBox)||object.hitBox.hitTestObject(Constantes.wallRight.hitBox)) 
			{
				return true;
			}
			if (object.hitBox2.hitTestObject(Constantes.wallTop.hitBox)||object.hitBox2.hitTestObject(Constantes.wallBottom.hitBox)||object.hitBox2.hitTestObject(Constantes.wallMidle.hitBox)||object.hitBox2.hitTestObject(Constantes.wallLeft.hitBox)||object.hitBox2.hitTestObject(Constantes.wallRight.hitBox)) 
			{
				return true;
			}
			}
			else {
				if (object.hitTestObject(Constantes.wallTop.hitBox)||object.hitTestObject(Constantes.wallBottom.hitBox)||object.hitTestObject(Constantes.wallMidle.hitBoxBas)||object.hitTestObject(Constantes.wallMidle.hitBoxHaut)||object.hitTestObject(Constantes.wallLeft.hitBox)||object.hitTestObject(Constantes.wallRight.hitBox)) 
			{
				return true;
			}
			}
			return false;
		}
		
		static public function testWallBottom(object:ObjetDeplacable):Boolean 
		{
			if (object.hitTestObject(Constantes.wallTop.hitBoxHaut)||object.hitTestObject(Constantes.wallBottom.hitBoxHaut)||object.hitTestObject(Constantes.wallMidle.hitBox)||object.hitTestObject(Constantes.wallLeft.hitBoxHaut)||object.hitTestObject(Constantes.wallRight.hitBoxHaut)) 
			{
				return true;
			}
			if (object.hitTestObject(Constantes.wallTop.hitBoxBas)||object.hitTestObject(Constantes.wallBottom.hitBoxBas)||object.hitTestObject(Constantes.wallMidle.hitBox)||object.hitTestObject(Constantes.wallLeft.hitBoxBas)||object.hitTestObject(Constantes.wallRight.hitBoxBas)) 
			{
				return true;
			}
			return false;
		}
		
	}

}