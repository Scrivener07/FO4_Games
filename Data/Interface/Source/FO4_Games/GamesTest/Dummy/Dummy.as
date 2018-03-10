package
{
	import flash.display.MovieClip;
	import Games.Debug;
	import Games.Display;
	import Games.IDisplay;

	public class Dummy extends Display implements IDisplay
	{

		// Display
		//---------------------------------------------

		public function Dummy()
		{
			Debug.WriteLine("Dummy", "Constructor");
		}

	}
}
