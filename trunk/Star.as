package  
{
	import org.flixel.FlxSprite;
	public class Star extends FlxSprite
	{
		private var ang:Number;
		private var speed:Number;
		
		
		public function Star(X:Number = 0, Y:Number = 0, SimpleGraphic:Class = null) 
		{
			super(X, Y, SimpleGraphic);
			
			ang = Math.random() * 2 * Math.PI;
			speed = 2 + Math.random();
		}
		
/*		override public function update():void
		{
			super.update();
			
			x += speed * Math.cos(ang) / 100;
			y += speed * Math.sin(ang) / 100;
			
			if (x > 640) 
			{
				x = -3
			}
			if (x < -3) 
			{
				x = 640
			}
			if (y > 240) 
			{
				y = -3
			}
			if (y < -3) 
			{
				y = 240
			}
		}*/
		
	}

}