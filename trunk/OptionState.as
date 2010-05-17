package  
{
	import org.flixel.*;
	
	public class OptionState extends FlxState
	{
		[Embed(source = "data/arrow.png")] public static var arrow_gfx:Class;
		
		public static var particles:int = -1;
		public static var homemadesounds:int = -1;
		private static var select1:int = 3;
		private static var select2:int = 2;
		
		private var arrow1:FlxSprite;
		private var arrow2:FlxSprite;
		
		override public function create():void
		{
			var t:FlxText;
			t = new FlxText(0,20,FlxG.width,"Options");
			t.size = 20;
			t.alignment = "center";
			add(t);
			
			t = new FlxText(20,50,FlxG.width,"Particles");
			t.size = 16;
			t.alignment = "left";
			add(t);
			
			t = new FlxText(200,50,FlxG.width,"Sound");
			t.size = 16;
			t.alignment = "left";
			add(t);
			
			var b:FlxButton;
			b = new FlxButton(20, 80, click);
			t = new FlxText(0, 0, 100, "None");
			t.alignment = "center";
			b.loadText(t);
			b.height = 20;
			b.width = 100;
			this.add(b);
			
			b = new FlxButton(20, 110, click2);
			t = new FlxText(0, 0, 100, "Some");
			t.alignment = "center";
			b.loadText(t);
			b.height = 20;
			b.width = 100;
			this.add(b);
			
			b = new FlxButton(20, 140, click3);
			t = new FlxText(0, 0, 100, "Default");
			t.alignment = "center";
			b.loadText(t);
			b.height = 20;
			b.width = 100;
			this.add(b);
			
			b = new FlxButton(20, 170, click4);
			t = new FlxText(0, 0, 100, "Heaps");
			t.alignment = "center";
			b.loadText(t);
			b.height = 20;
			b.width = 100;
			this.add(b);
			
			b = new FlxButton(20, 200, click5);
			t = new FlxText(0, 0, 100, "Obscene amounts");
			t.alignment = "center";
			b.loadText(t);
			b.height = 20;
			b.width = 100;
			this.add(b);
			
			b = new FlxButton(200, 80, click6);
			t = new FlxText(0, 0, 100, "Normal");
			t.alignment = "center";
			b.loadText(t);
			b.height = 20;
			b.width = 100;
			this.add(b);
			
			b = new FlxButton(200, 110, click7);
			t = new FlxText(0, 0, 100, "Home made");
			t.alignment = "center";
			b.loadText(t);
			b.height = 20;
			b.width = 100;
			this.add(b);
			
			b = new FlxButton(130, 220, click8);
			t = new FlxText(0, 0, 100, "Back");
			t.alignment = "center";
			b.loadText(t);
			b.height = 20;
			b.width = 100;
			this.add(b);
			
			arrow1 = new FlxSprite(00, 50 + 30 * select1, arrow_gfx);
			this.add(arrow1);
			
			arrow2 = new FlxSprite(180, 50 + 30 * select2, arrow_gfx);
			this.add(arrow2);
		}
		
		override public function update():void
		{
			super.update();
			arrow1.y =  50 + 30 * select1;
			arrow2.y =  50 + 30 * select2;
		}
		
		private function click():void
		{
			particles = 0;
			select1 = 1;
		}
		
		private function click2():void
		{
			particles = 25;
			select1 = 2;
		}
		
		private function click3():void
		{
			particles = 50;
			select1 = 3;
		}
		
		private function click4():void
		{
			particles = 100;
			select1 = 4;
		}
		
		private function click5():void
		{
			particles = 300;
			select1 = 5;
		}
		
		private function click6():void
		{
			homemadesounds = 0;
			select2 = 1;
		}
		private function click7():void
		{
			homemadesounds = 1;
			select2 = 2;
		}
		
		private function click8():void
		{
			FlxG.state = new MenuState();
		}
	}
}