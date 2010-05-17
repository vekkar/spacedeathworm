package  
{
	import org.flixel.*;
	
	/**
	 * ...
	 * @author Echo
	 */
	public class BloodEmitter extends FlxEmitter
	{
		public var ang:Number;
		private var directional:int;
		
		public function BloodEmitter(X:Number = 0, Y:Number = 0, ang:Number = 0) 
		{
			super(X, Y);
			this.ang = ang;
			
			directional = 0;
			if (ang == -1) 
			{
				directional = 1;
			}
			if (ang == -2) 
			{
				directional = 2;
			}
		}
		
		override public function emitParticle():void
		{
			_counter++;
			var s:Blood = members[_particle] as Blood;
			s.visible = true;
			s.exists = true;
			s.active = true;
			s.x = x - (s.width>>1) + FlxU.random()*width;
			s.y = y - (s.height >> 1) + FlxU.random() * height;
			
			if (FlxU.random() < 0.15 || directional == 1 || directional == 2) 
			{
				s.velocity.x = minParticleSpeed.x;
				s.velocity.y = minParticleSpeed.y;
				if (directional == 2) 
				{
					if(minParticleSpeed.x != maxParticleSpeed.x) s.velocity.x += FlxU.random()*(maxParticleSpeed.x-minParticleSpeed.x);
					if(minParticleSpeed.y != maxParticleSpeed.y) s.velocity.y += (FlxU.random()/2)*(maxParticleSpeed.y-minParticleSpeed.y);
				}
				else 
				{
					if(minParticleSpeed.x != maxParticleSpeed.x) s.velocity.x += FlxU.random()*(maxParticleSpeed.x-minParticleSpeed.x);
					if(minParticleSpeed.y != maxParticleSpeed.y) s.velocity.y += FlxU.random()*(maxParticleSpeed.y-minParticleSpeed.y);
				}
				s.acceleration.y = gravity;
			}
			else 
			{
				s.velocity.x = minParticleSpeed.x;
				s.velocity.y = minParticleSpeed.y;
				var temp:Number = ang;
				if (temp >= 0 && temp < 90) 
				{
					if(minParticleSpeed.x != maxParticleSpeed.x) s.velocity.x += (FlxU.random()/2 + 0.5)*(maxParticleSpeed.x-minParticleSpeed.x);
					if(minParticleSpeed.y != maxParticleSpeed.y) s.velocity.y += (FlxU.random()/2 + 0.5)*(maxParticleSpeed.y-minParticleSpeed.y);
				}
				if (temp >= 90 && temp < 180) 
				{
					if(minParticleSpeed.x != maxParticleSpeed.x) s.velocity.x += (FlxU.random()/2)*(maxParticleSpeed.x-minParticleSpeed.x);
					if(minParticleSpeed.y != maxParticleSpeed.y) s.velocity.y += (FlxU.random()/2 + 0.5)*(maxParticleSpeed.y-minParticleSpeed.y);
				}
				if (temp >= 180 && temp < 270) 
				{
					if(minParticleSpeed.x != maxParticleSpeed.x) s.velocity.x += (FlxU.random()/2)*(maxParticleSpeed.x-minParticleSpeed.x);
					if(minParticleSpeed.y != maxParticleSpeed.y) s.velocity.y += (FlxU.random()/2)*(maxParticleSpeed.y-minParticleSpeed.y);
				}
				if (temp >= 270 && temp < 360) 
				{
					if(minParticleSpeed.x != maxParticleSpeed.x) s.velocity.x += (FlxU.random()/2 + 0.5)*(maxParticleSpeed.x-minParticleSpeed.x);
					if(minParticleSpeed.y != maxParticleSpeed.y) s.velocity.y += (FlxU.random()/2)*(maxParticleSpeed.y-minParticleSpeed.y);
				}
				s.acceleration.y = gravity;
			}
			
			s.velocity.x *= 1.5;
			s.velocity.y *= 1.5;
			
			s.angularVelocity = minRotation;
			if(minRotation != maxRotation) angularVelocity += FlxU.random()*(maxRotation-minRotation);
			if(s.angularVelocity != 0) s.angle = FlxU.random()*360-180;
			s.drag.x = particleDrag.x;
			s.drag.y = particleDrag.y;
			s.visible = true;
			_particle++;
			if(_particle >= members.length)
				_particle = 0;
			s.onEmit();
		}
		
		override public function createSprites(Graphics:Class, Quantity:uint=50, BakedRotations:uint=16, Multiple:Boolean=true, Collide:Number=0):FlxEmitter
		{
			members = new Array();
			var r:uint;
			var s:Blood;
			var tf:uint = 1;
			var sw:Number;
			var sh:Number;
			if(Multiple)
			{
				s = new Blood(0,0,Graphics);
				tf = s.width/s.height;
			}
			for(var i:uint = 0; i < Quantity; i++)
			{
				s = new Blood();
				if(Multiple)
				{
					r = FlxU.random()*tf;
					if(BakedRotations > 0)
						s.loadRotatedGraphic(Graphics,BakedRotations,r);
					else
					{
						s.loadGraphic(Graphics,true);
						s.frame = r;
					}
				}
				else
				{
					if(BakedRotations > 0)
						s.loadRotatedGraphic(Graphics,BakedRotations);
					else
						s.loadGraphic(Graphics);
				}
				if(Collide > 0)
				{
					sw = s.width;
					sh = s.height;
					s.width *= Collide;
					s.height *= Collide;
					s.offset.x = (sw-s.width)/2;
					s.offset.y = (sh-s.height)/2;
					s.solid = true;
				}
				else
					s.solid = false;
				s.exists = false;
				s.scrollFactor = scrollFactor;
				add(s);
			}
			return this;
		}
		
	}

}