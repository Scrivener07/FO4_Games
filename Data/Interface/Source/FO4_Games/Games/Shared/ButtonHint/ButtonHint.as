package
{
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.utils.describeType;
	import Shared.AS3.BSButtonHintBar;
	import Shared.AS3.BSButtonHintData;
	import Shared.IMenu;

	public class ButtonHint extends IMenu implements IButtonHint
	{
		public var BGSCodeObj:Object;
		public var ButtonHintBar_mc:BSButtonHintBar;


		// Menu
		//---------------------------------------------

		public function ButtonHint()
		{
			super();
			trace("ButtonHint.as");

			this.BGSCodeObj = new Object();
			addEventListener(Event.ADDED_TO_STAGE, OnAddedToStage);
		}


		private function OnAddedToStage(e:Event) : void
		{
			trace("OnAddedToStage:"+e);
		}


		// IChoiceMenu
		//---------------------------------------------

		public function SetButtons(argument:Object) : void
		{
			for each (var e_0 in argument)
			{
				trace(e_0);
				for each (var e_1 in e_0)
				{
					trace(e_1);
					for each (var e_2 in e_1)
					{
						trace(e_2);
						for each (var e_3 in e_2)
						{
							trace(e_3);
						}
					}
				}
			}
		}

		public function SetButton(argument:Object) : void
		{
			trace(argument);

			var TextValue = argument["__struct__"]["__data__"]["text"];
			var PCValue = argument["__struct__"]["__data__"]["PC"];
			var PSNValue = argument["__struct__"]["__data__"]["PSN"];
			var XenonValue = argument["__struct__"]["__data__"]["Xenon"];

			var Buttons:Vector.<BSButtonHintData> = new Vector.<BSButtonHintData>();
			var button:BSButtonHintData = new BSButtonHintData
			(
				TextValue,
				PCValue,
				PSNValue,
				XenonValue,
				1,
				this.OnButton
			);

			button.ButtonVisible = true;
			button.ButtonEnabled = true;

			Buttons.push(button);
			this.ButtonHintBar_mc.SetButtonHintData(Buttons);
		}


		public function get IsLoaded():Boolean { return true; }
		public function get Visible():Boolean { return this.visible; }
		public function set Visible(argument:Boolean):void { this.visible = argument; }


		// Buttons
		//---------------------------------------------

		private function OnButton(e:Event) : void
		{
			trace("A button has been has had an event. Event:"+e);
		}


	}
}
