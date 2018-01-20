package Shared
{
	import flash.display.DisplayObjectContainer;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.utils.getQualifiedClassName;
	import Shared.IDisplay;

	public class Display extends MovieClip implements IDisplay
	{
		// IDisplay
		public function get Exists():Boolean { return true; } // depreciate
		public function get Visible():Boolean { return this.visible; }
		public function set Visible(argument:Boolean):void { this.visible = argument; }
		private var isTrue:Boolean = true;


		// Menu
		//---------------------------------------------

		public function Display()
		{
			addEventListener(Event.ADDED_TO_STAGE, OnAddedToStage);
		}


		// HUD Framework
		//---------------------------------------------

		private function OnAddedToStage(e:Event) : void
		{
			trace("[Display.as] OnAddedToStage:"+Shared.Utility.WalkMovie(this));
			var baseMenu:MovieClip = stage.getChildAt(0) as MovieClip;
			trace("\n\n\n\n");
			Shared.Utility.TraceDisplayList(baseMenu)
			trace("\n\n\n\n");
		}


		// Functions
		//---------------------------------------------

		public function BringToFront() : void
		{
			trace("[Display] BringToFront");
			var container:DisplayObjectContainer = this.parent.parent;
			var loader:DisplayObjectContainer = this.parent;
			container.setChildIndex(loader, container.numChildren - 1);

			var StageRoot:MovieClip = stage.getChildAt(0) as MovieClip;
			trace("\n\n\n\n");
			trace("[Display] TraceDisplayList");
			Shared.Utility.TraceDisplayList(StageRoot);
			trace("\n\n\n\n");

			trace("\n\n\n\n");
			trace("[Display.as] TraceObject");
			Shared.Utility.TraceObject(container);
			trace("\n\n\n\n");
		}


	}
}
