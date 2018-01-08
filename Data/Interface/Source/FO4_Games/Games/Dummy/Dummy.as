package
{
	import flash.display.DisplayObjectContainer;
	import flash.display.MovieClip;
	import flash.events.Event;
	import Shared.IDisplay;
	import Shared.Display;

	public class Dummy extends Display implements IDisplay
	{

		// Display
		//---------------------------------------------

		public function Dummy()
		{
			trace("[Dummy] Constructor");
			addEventListener(Event.ADDED_TO_STAGE, OnAddedToStage);
		}


		private function OnAddedToStage(e:Event) : void
		{
			trace("[Dummy] OnAddedToStage:"+Shared.Utility.WalkMovie(this));
		}


	}
}
