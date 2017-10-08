package
{
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.utils.describeType;
	import Shared.AS3.BSButtonHintBar;
	import Shared.AS3.BSButtonHintData;
	import Shared.IDisplay;
	import Shared.IMenu;

	public class ButtonHint extends IMenu implements IDisplay, IButtonHint
	{
		public var ButtonHintBar_mc:BSButtonHintBar;

		public function get Exists():Boolean { return true; }
		public function get Visible():Boolean { return this.visible; }
		public function set Visible(argument:Boolean):void { this.visible = argument; }


		// Menu
		//---------------------------------------------

		public function ButtonHint()
		{
			super();
			trace("[ButtonHint] Constructor");
			addEventListener(Event.ADDED_TO_STAGE, OnAddedToStage);
		}


		private function OnAddedToStage(e:Event) : void
		{
			trace("[ButtonHint] OnAddedToStage:"+Shared.Utility.WalkMovie(this));
		}


		// Methods
		//---------------------------------------------

		public function SetButtons(argument:Object, ... rest) : void
		{
			trace("[ButtonHint] SetButtons");

			if (argument != null)
			{
				var Buttons:Vector.<BSButtonHintData> = new Vector.<BSButtonHintData>();

				Shared.Utility.TraceObject(argument);
				var button:BSButtonHintData = ToButtonHint(argument);
				button.ButtonVisible = true;
				button.ButtonEnabled = true;
				Buttons.push(button);

				if (rest != null)
				{
					for (var i:uint = 0; i < rest.length; i++)
					{
						Shared.Utility.TraceObject(rest[i]);
						var exbutton:BSButtonHintData = ToButtonHint(rest[i]);
						exbutton.ButtonVisible = true;
						exbutton.ButtonEnabled = true;
						Buttons.push(exbutton);
					}
				}

				this.ButtonHintBar_mc.SetButtonHintData(Buttons);
			}
			else
			{
				trace("[ButtonHint] Argument was null!");
			}
		}


		private function ToButtonHint(argument:Object) : BSButtonHintData
		{
			var textValue = argument["__struct__"]["__data__"]["text"];
			var keyCode = 	argument["__struct__"]["__data__"]["keyCode"];

			var hint:BSButtonHintData = new BSButtonHintData
			(
				textValue,
				Shared.Input.KeyCodeToPC(keyCode),
				"PlayStation",
				"Xbox",
				1,
				null
			);
			return hint;
		}


	}
}
