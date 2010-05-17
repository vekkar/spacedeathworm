package  
{
	import org.flixel.FlxSprite;
	
	public class Blood extends FlxSprite
	{
		private var lifespan:Number;
		
		public function Blood(X:Number = 0, Y:Number = 0, SimpleGraphic:Class = null) 
		{
			super(X, Y, SimpleGraphic);
						
			lifespan = 350 + 300 * Math.random();
		}
		
		override public function update():void
		{
			super.update();
			
			lifespan -= 1;
			if (y > 240) 
			{
				moves = false;
				y = 240;
			}
			if (lifespan <= 0) 
			{
				this.kill();
				this.destroy();
			}
		}
	}

}