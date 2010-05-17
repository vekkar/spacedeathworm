package {
	import org.flixel.*;
	
	[SWF(width = "640", height = "480", backgroundColor = "#000000")]
	[Frame(factoryClass="Preloader")]

	public class DeathWorm extends FlxGame
	{
		
		public function DeathWorm()
		{
			super(320,240,MenuState,2);
		}
	}
}