package  
{
	import org.flixel.FlxSprite;
	
	public class Laser extends FlxSprite
	{
		
		
		public function Laser(X:Number = 0, Y:Number = 0, SimpleGraphic:Class = null, ang:Number = 0) 
		{
			super(X, Y, SimpleGraphic);
			
			this.angle = ang * 180 / Math.PI;
		}
		
		override public function update():void
		{
			super.update();
			
			this.velocity.x = 100 * Math.cos(angle * Math.PI / 180);
			this.velocity.y = 100 * Math.sin(angle * Math.PI / 180);
			
			if (x < -25 || x > 645) 
			{
				this.kill();
				this.destroy();
			}
			if (y < -25 || y > 250) 
			{
				this.kill();
				this.destroy();
			}
		}
	}
}