package  
{
	import org.flixel.*;

	public class Worm extends FlxSprite
	{
		public var speed:int;
		private var s:PlayState;
		public var aboveground:Boolean;
		public var minspeed:int;
		public var maxspeed:int;
		private var past:Array;
		private var starting:int;
		
		private var tail1:FlxSprite;
		private var tails:Array;
		
		public var killed:int;
		public var bloodSpilt:Number;
			
		public function Worm(s:PlayState, gfx:Class, gfx2:Class) 
		{
			super(15, 300, null);
			this.loadGraphic(gfx, false, false, 20, 20, false);
			
			
			past = new Array();
			this.s = s;
			health = 100;
			
			speed = 100;
			aboveground = false;
			minspeed = 75;
			maxspeed = 150;
			starting = 0;
			
			killed = 0;
			bloodSpilt = 0;
			
			this.angle = 0;
			
			tails = new Array();
			for (var i:int = 0; i < 8; i++) 
			{
				tail1 = new FlxSprite(0, 300, gfx2);
				tails.push(tail1);
				s.tail.add(tail1);
			}
			
			for (var j:int = 0; j < 28; j++) 
			{
				past.push(x);
				past.push(y);
			}
		}
		
		public override function update():void
		{
			super.update();
			
			past.push(x);
			past.push(y);
			
			input();
			
			movement();
			
			if (y < 230)
			{
				if (aboveground == false) 
				{
					s.leaveearth();
				}
				
				aboveground = true;
				
				if (getAngle() >= 270 || getAngle() < 90) 
				{
					angle += 1.43;
				}
				
				if (getAngle() >= 90 && getAngle() < 270) 
				{
					angle -= 1.43;
				}
			}
			else
			{
				if (aboveground) 
				{
					s.leaveearth();
				}
				aboveground = false;
				starting = 0;
			}
			
			if (x < 0) 
			{
				x = 0;
			}
			if (x > 620) 
			{
				x = 620;
			}
			if (y < 0) 
			{
				y = 0;
			}
			if (y > 460) 
			{
				y = 460;
			}
		}
		
		private function input():void
		{			
			if (false == false) 
			{
				if (FlxG.keys.pressed("W") || FlxG.keys.pressed("UP")) 
				{
					setSpeed(speed + 2);
				}
				if (FlxG.keys.pressed("S") || FlxG.keys.pressed("DOWN")) 
				{
					setSpeed(speed - 2);
				}
			
				if (speed < 100) 
				{
					setSpeed(speed + 1);
				}
				else 
				{
					setSpeed(speed - 1);
				}
			}
			
			if (FlxG.keys.pressed("A") || FlxG.keys.pressed("LEFT")) 
			{
				if (aboveground == false) 
				{
					angle -= 2.86;
				}
				else 
				{
					angle -= 0.86;
				}
			}
			if (FlxG.keys.pressed("D") || FlxG.keys.pressed("RIGHT")) 
			{
				if (aboveground == false) 
				{
					angle += 2.86;
				}
				else 
				{
					angle += 0.86;
				}
			}
		}
		
		private function movement():void
		{
			setVelocity(speed * Math.cos(angle * Math.PI / 180), speed * Math.sin(angle * Math.PI / 180));
			
			for (var i:int = 0; i < tails.length - 1; i++) 
			{
				tails[i].y = past[8*i + 1];
				tails[i].x = past[8*i];
			}
			tails[7].x = past.shift();
			tails[7].y = past.shift();	
		}
				
		private function setSpeed(speed:int):void 
		{
			if (speed < minspeed) 
			{
				speed = minspeed;
			}
			if (speed > maxspeed) 
			{
				speed = maxspeed;
			}
			this.speed = speed;
		}
		
		private function setVelocity(velocityx:Number, velocityy:Number):void 
		{
			this.velocity.x = velocityx;
			
			this.velocity.y = velocityy;
		}
		
		public function getAngle():Number
		{
			if (angle % 360 < 0) 
			{
				return 360 + angle % 360;
			}
			else 
			{
				return angle % 360;
			}
		}
		
		override public function kill():void
		{
			super.kill();
			
			FlxG.state = new MenuState();
		}
	}
}