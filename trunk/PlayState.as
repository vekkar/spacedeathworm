package
{
	import org.flixel.*;
	
	public class PlayState extends FlxState
	{
		[Embed(source = "data/map.txt", mimeType = "application/octet-stream")] public static var data_map:Class;
		[Embed(source = "data/1.png")] public static var data_tiles:Class;
		[Embed(source = "data/player.png")] public static var player_gfx:Class;
		[Embed(source = "data/playerpiece.png")] public static var player_gfx2:Class;
		[Embed(source = "data/storm.png")] public static var storm_gfx:Class;
		[Embed(source = "data/blood.png")] public static var blood_gfx:Class;
		[Embed(source = "data/earth.png")] public static var earth_gfx:Class;
		[Embed(source = "data/mars.png")] public static var mars_gfx:Class;
		[Embed(source = "data/moon.png")] public static var moon_gfx:Class;
		[Embed(source = "data/star1.png")] public static var star1_gfx:Class;
		[Embed(source = "data/star2.png")] public static var star2_gfx:Class;
		[Embed(source = "data/laser.png")] public static var laser_gfx:Class;
		[Embed(source = "data/combo.png")] public static var combo_gfx:Class;
		[Embed(source = "data/moondust.png")] public static var moondust_gfx:Class;
		[Embed(source = "data/wormblood.png")] public static var wormblood_gfx:Class;
		[Embed(source = "data/dirt.png")] public static var dirt_gfx:Class;
		
		[Embed(source = "data/pew.mp3")] public static var h_laser_sound:Class;
		[Embed(source = "data/om.mp3")] public static var h_om_sound:Class;
		[Embed(source = "data/nom.mp3")] public static var h_nom_sound:Class;
		[Embed(source = "data/explodehome.mp3")] public static var h_explode_sound:Class;
		
		[Embed(source = "data/laser.mp3")] public static var laser_sound:Class;
		[Embed(source = "data/eat.mp3")] public static var om_sound:Class;
		[Embed(source = "data/moonexplode.mp3")] public static var explode_sound:Class;
		
		public var player:Worm;
		
		public var enemies:FlxGroup;
		public var bullets:FlxGroup;
		public var parts:FlxGroup;
		public var background:FlxGroup;
		public var tail:FlxGroup;
		
		private var enemy:Enemy;
		
		private var map:FlxTilemap;
		
		public var t:FlxText;
		public var t_score:FlxText;
		public var t_combo:FlxText;
		public var t_health:FlxText;
		
		private var framenum:uint;
		private var spawnrate:uint;
		
		public var score:int;
		public var combo:int;
		private var comboreset:Number;
		
		private var combobar:FlxSprite;
		private var healthbar:FlxSprite;
		
		private var moon:Moon;

		private var h_lasersound:FlxSound;
		private var h_omsound:FlxSound;
		private var h_nomsound:FlxSound;
		private var h_explodesound:FlxSound;
		
		private var lasersound:FlxSound;
		private var omsound:FlxSound;
		private var explodesound:FlxSound;
		
		override public function create():void
		{	
			background = new FlxGroup();
			this.add(background);
			
			map = new FlxTilemap();
			map.drawIndex = 2;
			map.loadMap(new data_map, data_tiles, 20, 20);
			this.add(map);
			
			for (var i:int = 0; i < 30; i++) 
			{
				var star:FlxSprite = new FlxSprite(Math.random() * 620, Math.random() * 230, star1_gfx)
				background.add(star, false);
				var star2:FlxSprite = new FlxSprite(Math.random() * 620, Math.random() * 230, star2_gfx)
				background.add(star2, false);
			}
			
			var mars:FlxSprite = new FlxSprite(20 + Math.random() * 580, 20 + Math.random() * 60, mars_gfx)
			background.add(mars, false);
			
			var earth:FlxSprite = new FlxSprite(20 + Math.random() * 580, 20 + Math.random() * 60, earth_gfx)
			background.add(earth, false);
			
			moon = new Moon(earth.x + 22.5, earth.y - 30, moon_gfx)
			background.add(moon, false);
			
			bullets = new FlxGroup();
			this.add(bullets);
			
			enemies = new FlxGroup();
			this.add(enemies);
			
			parts = new FlxGroup();
			this.add(parts);
			
			tail = new FlxGroup();
			this.add(tail);
			
			healthbar = new FlxSprite(205, 234, combo_gfx);
			healthbar.scrollFactor = new FlxPoint(0, 0);
			healthbar.scale.y = 23;
			healthbar.origin = new FlxPoint(0, 1);
			this.add(healthbar);
			
			combobar = new FlxSprite(125, 234, combo_gfx);
			combobar.scrollFactor = new FlxPoint(0, 0);
			combobar.scale.y = 23;
			combobar.origin = new FlxPoint(0, 1);
			this.add(combobar);
			
			player = new Worm(this, player_gfx, player_gfx2);
			this.add(player);
			
			FlxG.follow(player, 20);
			FlxG.followAdjust(0, 0);
			FlxG.followBounds(0, 0, 640, 480);
			
			t = new FlxText(220, 210, 100, "BLOOD SPILT");
			t.scrollFactor = new FlxPoint(0, 0);
			t.alignment = "right";
			this.add(t)
			
			t = new FlxText(0, 210, 50, "Score");
			t.scrollFactor = new FlxPoint(0, 0);
			t.alignment = "center";
			this.add(t)
			
			t = new FlxText(80, 210, 50, "Combo");
			t.scrollFactor = new FlxPoint(0, 0);
			t.alignment = "center";
			this.add(t)
			
			t = new FlxText(160, 210, 50, "Health");
			t.scrollFactor = new FlxPoint(0, 0);
			t.alignment = "center";
			this.add(t)
			
			t_score = new FlxText(-5, 225, 50, "0");
			t_score.scrollFactor = new FlxPoint(0, 0);
			t_score.alignment = "right";
			this.add(t_score);
			
			t_combo = new FlxText(75, 225, 50, "0");
			t_combo.scrollFactor = new FlxPoint(0, 0);
			t_combo.alignment = "right";
			this.add(t_combo);
			
			t_health = new FlxText(155, 225, 50, "0");
			t_health.scrollFactor = new FlxPoint(0, 0);
			t_health.alignment = "right";
			this.add(t_health);
			
			t = new FlxText(220, 225, 100, "0 Litres");
			t.scrollFactor = new FlxPoint(0, 0);
			t.alignment = "right";
			this.add(t)
			
			score = 0;
			combo = 0;
			comboreset = 100;
			framenum = 0;
			spawnrate = 50 + Math.random() * 50
			
			h_lasersound = new FlxSound();
			h_lasersound.loadEmbedded(h_laser_sound, false);
			h_omsound = new FlxSound();
			h_omsound.loadEmbedded(h_om_sound, false);
			h_nomsound = new FlxSound();
			h_nomsound.loadEmbedded(h_nom_sound, false);
			h_explodesound = new FlxSound();
			h_explodesound.loadEmbedded(h_explode_sound, false);
			
			lasersound = new FlxSound();
			lasersound.loadEmbedded(laser_sound, false);
			omsound = new FlxSound();
			omsound.loadEmbedded(om_sound, false);
			explodesound = new FlxSound();
			explodesound.loadEmbedded(explode_sound, false);
		}
		
		public override function update():void
		{
			super.update();
			
			if (combo > 0) 
			{
				comboreset -= 0.75;
			}
			
			FlxU.overlap(player, enemies, eatenemy);
			FlxU.overlap(player, bullets, hit);
			FlxU.overlap(player, moon, eatmoon);
			
			if (comboreset <= 0) 
			{
				comboreset = 100;
				combo = 0;
			}
			
			framenum += 1;
			
			if (framenum % spawnrate == 0) 
			{
				spawnrate = Math.round(100 - framenum / 100 + Math.random() * 50);
				if (Math.random() > 0.5) 
				{
					enemy = new Enemy(this, -20, 220, storm_gfx, 1);
					enemies.add(enemy, false);
				}
				else 
				{
					enemy = new Enemy(this, 640, 220, storm_gfx, 0);
					enemies.add(enemy, false);
				}
			}
			
			t.text = (int((player.bloodSpilt) * 100) / 100).toString() + " Litres";
			t_score.text = score.toString();
			t_combo.text = combo.toString();
			t_health.text = player.health.toString();
			healthbar.scale.y = Math.round(player.health/ 10 * 2.3);
			if (combo > 0) 
			{
				combobar.scale.y = Math.round(comboreset / 10 * 2.3);
				//combobar.color = 0xff0000;
			}
			else 
			{
				combobar.scale.y = 0;
			}
		}
		
		private function eatmoon(p:Worm, m:Moon):void
		{
			m.kill();
			m.destroy();
			
			var e_blood:BloodEmitter;
			e_blood = new BloodEmitter(p.x + 10, p.y + 10, -1);
			e_blood.createSprites(moondust_gfx, 3 * OptionState.particles, 8, false, 0);
			e_blood.gravity = 15;
			e_blood.start(true, 15, 0);
			parts.add(e_blood);
			
			if (OptionState.homemadesounds == 0) 
			{
				explodesound.play();
			}
			else 
			{
				h_explodesound.play();
			}
		}
		
		public function leaveearth():void
		{
			
			var e_blood:BloodEmitter;
			e_blood = new BloodEmitter(player.x + 10, player.y + 10, -2);
			e_blood.createSprites(dirt_gfx, OptionState.particles / 3, 8, false, 0);
			e_blood.gravity = 15;
			e_blood.start(true, 15, 0);
			FlxG.quake.start(0.008, 0.2);
			parts.add(e_blood);
		}
		
		private function hit(p:Worm, l:Laser):void
		{
			l.kill();
			l.destroy();
			
			var e_blood:BloodEmitter;
			e_blood = new BloodEmitter(p.x + 10, p.y + 10, -1);
			e_blood.createSprites(wormblood_gfx, OptionState.particles/2, 8, false, 0);
			e_blood.gravity = 15;
			e_blood.start(true, 15, 0);
			parts.add(e_blood);
			
			p.hurt(2);
		}
		
		private function eatenemy(p:Worm, e:Enemy):void
		{
			if (player.aboveground) 
			{
				var e_blood:BloodEmitter;
				e_blood = new BloodEmitter(e.x + 10, e.y + 10, player.getAngle());
				e_blood.createSprites(blood_gfx, OptionState.particles, 8, false, 0);
				e_blood.gravity = 15;
				e_blood.start(true, 15, 0);
				parts.add(e_blood);
				e.killit();
				player.killed += 1;
				player.bloodSpilt += 5 + Math.random();
				combo += 1;
				if (combo >= 2 && combo % 2 == 0) 
				{
					if (player.health < 100) 
					{
						player.health += 1;
					}
				}
				if (combo >= 2) 
				{
					if (OptionState.homemadesounds == 0) 
					{
						omsound.play();
					}
					else 
					{
						h_nomsound.play();
					}
				}
				else 
				{
					if (OptionState.homemadesounds == 0) 
					{
						omsound.play();
					}
					else 
					{
						h_omsound.play();
					}
				}
				comboreset = 100;
				score += 10 * combo;
			}
		}
		
		public function firelaser(x:Number, y:Number):void
		{
			bullets.add(new Laser(x + 10, y + 10, laser_gfx, Math.atan2(player.y - y, player.x - x)));
			if (OptionState.homemadesounds == 0) 
			{
				lasersound.play();
			}
			else 
			{
				h_lasersound.play();
			}
		}
	}
}

