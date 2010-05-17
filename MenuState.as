package

{

	import org.flixel.*;



	public class MenuState extends FlxState
	{
		[Embed(source = "data/startbutton.png")] public static var start_button:Class;
		[Embed(source = "data/startbutton2.png")] public static var start_button2:Class;

		[Embed(source = "data/optionsbutton.png")] public static var o_button:Class;
		[Embed(source = "data/optionsbutton2.png")] public static var o_button2:Class;
		
		override public function create():void
		{
			var t:FlxText;
			t = new FlxText(0,FlxG.height/2-80,FlxG.width,"Space Death Worm");
			t.size = 20;
			t.alignment = "center";
			add(t);
			
			t = new FlxText(0,FlxG.height/2-20,FlxG.width,"Controls: WASD or Arrow Keys");
			t.size = 14;
			t.alignment = "center";
			add(t);
			
			var b:FlxButton;
			b = new FlxButton(20, 170, startclick);
			b.loadGraphic(new FlxSprite(0, 0, start_button2), new FlxSprite(0,0,start_button));
			b.width = 80;
			b.height = 40;
			add(b);
			
			b = new FlxButton(220, 170, optionsclick);
			b.loadGraphic(new FlxSprite(0, 0, o_button2), new FlxSprite(0,0,o_button));
			b.width = 80;
			b.height = 40;
			add(b);
			
			
			FlxG.mouse.show();
		}

		private function startclick():void
		{
			if (OptionState.particles < 0) 
			{
				OptionState.particles = 50;
			}
			if (OptionState.homemadesounds < 0) 
			{
				OptionState.homemadesounds = 1;
			}
			FlxG.state = new PlayState();
		}
		
		private function optionsclick():void
		{
			FlxG.state = new OptionState();
		}


		override public function update():void

		{

			super.update();
		}

	}

}

