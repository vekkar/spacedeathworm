package  
{
	import org.flixel.*;
	public class Enemy extends FlxSprite
	{
		private var direction:Boolean;
		public var scared:Boolean;
		private var speed:int;
		private var s:PlayState;
		private var firerate:int;
		private var firstshot:Boolean;
		
		public function Enemy(s:PlayState, X:Number=0,Y:Number=0,SimpleGraphic:Class=null, flipper:int = 0) 
		{
			super(X, Y, null);
			addAnimation("walk", [0, 1, 2, 1], 5, true);
			addAnimation("fire", [3], 1, true);
			loadGraphic(SimpleGraphic, false, true, 20, 20, false);
			play("walk", false);
			this.s = s;
			
			if (flipper == 1) 
			{
				direction = true;
				this.facing = LEFT;
			}
			else 
			{
				direction = false;
				this.facing = RIGHT;
			}
			
			firerate = 25;
		}
		
		public override function update():void
		{
			super.update();
			
			scared = false;
			if (s.player.aboveground && Math.abs(x-s.player.x) < 100 && Math.abs(y-s.player.y) < 150) 
			{
				scared = true;
				if (x-s.player.x > 0) 
				{
					this.facing = RIGHT;
				}
				else 
				{
					this.facing = LEFT;
				}
			}
			else 
			{
				if (direction) 
				{
					this.facing = LEFT;
				}
				else 
				{
					this.facing = RIGHT;
				}
			}
			
			movement();
			
			if (x < -25 || x > 645) 
			{
				killit()
			}
			
			if (scared) 
			{
				firerate -= 1;
				play("fire", false);
				if (firerate <= 0) 
				{
					s.firelaser(x, y);
					firerate = 25;
				}
			}
			else 
			{
				play("walk", false);
				firerate = 25;
			}
		}
		
		public function killit():void
		{
			kill();
			destroy();
		}
		
		public function movement():void
		{
			speed = 1;
			if (scared) 
			{
				speed = 0;
			}
			if (direction) 
			{
				this.velocity.x = 25 * speed;
			}
			else 
			{
				this.velocity.x = -25 * speed;
			}
		}
		
	}

}