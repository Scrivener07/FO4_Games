package
{
	import flash.display.MovieClip;
	import flash.text.TextField;
	import hudframework.IHUDWidget;

	public class Display extends MovieClip implements IHUDWidget
	{
		private static const WIDGET_IDENTIFIER:String = "Display.swf";

		public var PhaseFader_mc:MovieClip;
		public var Info_mc:MovieClip;

		private static const Command_UpdatePhase:int = 100;
		private static const Command_UpdateText:int = 200;
		private static const Command_UpdateName:int = 300;
		private static const Command_UpdateScore:int = 400;
		private static const Command_UpdateBet:int = 500;
		private static const Command_UpdateCaps:int = 600;
		private static const Command_UpdateEarnings:int = 700;


		public function Display() {}


		public function processMessage(command:String, params:Array):void
		{
			switch(command)
			{
				case String(Command_UpdatePhase):
				{
					PhaseFader_mc.Phase_mc.Name = String(params[0]);
					PhaseFader_mc.gotoAndPlay("Show")
					break;
				}

				case String(Command_UpdateName):
				{
					Info_mc.Name = String(params[0]);
					break;
				}
				case String(Command_UpdateText):
				{
					Info_mc.Text = String(params[0]);
					break;
				}
				case String(Command_UpdateScore):
				{
					Info_mc.Score = String(int(params[0]));
					break;
				}
				case String(Command_UpdateBet):
				{
					Info_mc.Bet = String(int(params[0]));
					break;
				}
				case String(Command_UpdateCaps):
				{
					Info_mc.Caps = String(int(params[0]));
					break;
				}
				case String(Command_UpdateEarnings):
				{
					Info_mc.Earnings = String(int(params[0]));
					break;
				}
			}
		}


	}
}
