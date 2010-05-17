package  
{
	import org.flixel.FlxSprite;
	
	public class Moon extends FlxSprite
	{
		public var ang:Number;
		private var updates:int;
		
		public function Moon(X:Number = 0, Y:Number = 0, SimpleGraphic:Class = null) 
		{
			super(X, Y, SimpleGraphic);
			
			ang = 0;
			updates = 0;
		}
		
		override public function update():void
		{
			updates += 1;
			
			if (updates == 5) 
			{
				updates = 0;
				
				x += Math.cos(ang);
				y += Math.sin(ang);
			
				ang += 0.02;
			}
		}
		
	}

}