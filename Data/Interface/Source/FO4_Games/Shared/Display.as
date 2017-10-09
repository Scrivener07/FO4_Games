package Shared
{
	import flash.display.DisplayObjectContainer;
	import flash.display.MovieClip;
	import flash.events.Event;
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
			trace("[Display] Constructor");
			addEventListener(Event.ADDED_TO_STAGE, OnAddedToStage);
		}


		private function OnAddedToStage(e:Event) : void
		{
	//		BringToFront();
			trace("[Display] OnAddedToStage:"+Shared.Utility.WalkMovie(this));
		}


		public function BringToFront() : void
		{
			trace("[Display] BringToFront");
			var stageRoot:DisplayObjectContainer = this.parent.parent; // root1
			var container:DisplayObjectContainer = this.parent; // instance10


			if (isTrue)
			{
				stageRoot.setChildIndex(container, stageRoot.numChildren - 1); // bottom??
			}
			else
			{
				stageRoot.setChildIndex(container, 0); // top??
			}
			isTrue = !isTrue;


			trace("\n\n\n\n");
			trace("[Display] TraceDisplayList");
			Shared.Utility.TraceDisplayList(stageRoot);
			trace("\n\n\n\n");


			trace("\n\n\n\n");
			trace("[Display] TraceObject");
			Shared.Utility.TraceObject(stageRoot);
			trace("\n\n\n\n");



		//	trace("\n\n[Display] BringToFront - After \n\n");
		//	Shared.Utility.TraceObject(stageRoot);
		}


	}
}
