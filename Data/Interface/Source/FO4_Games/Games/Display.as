package Games
{
	import flash.display.DisplayObjectContainer;
	import flash.display.MovieClip;
	import flash.events.Event;
	import Games.IDisplay;
	import Shared.IMenu;

	public class Display extends IMenu implements IDisplay
	{
		// IDisplay
		public function get Exists():Boolean { return true; }
		public function get Visible():Boolean { return this.visible; }
		public function set Visible(argument:Boolean):void { this.visible = argument; }


		// Menu
		//---------------------------------------------

		public function Display()
		{
			addEventListener(Event.ADDED_TO_STAGE, OnAddedToStage);
		}


		private function OnAddedToStage(e:Event) : void
		{
			trace("[Display.as] OnAddedToStage:"+Games.Utility.WalkMovie(this));
			var movieStage:MovieClip = stage.getChildAt(0) as MovieClip;
			Games.Utility.TraceDisplayList(movieStage)
		}


	}
}
