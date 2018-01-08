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

//			var bg: MovieClip = new MovieClip();
//			bg.graphics.beginFill(0xCCCCCC,0);
//			bg.graphics.drawRect(-2000,-2000,4000,4000);
//			bg.graphics.endFill();
//			var StageRoot:MovieClip = stage.getChildAt(0) as MovieClip;
//			StageRoot.addChild(bg)
		}


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
			trace("[Display] TraceObject");
			Shared.Utility.TraceObject(container);
			trace("\n\n\n\n");


		//	trace("\n\n[Display] BringToFront - After \n\n");
		//	Shared.Utility.TraceObject(stageRoot);
		}


	}
}
