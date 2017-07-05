package
{
	import flash.display.MovieClip;
	import flash.text.TextField;
	import hudframework.IHUDWidget;

	public class StatusWidget extends MovieClip implements IHUDWidget
	{
		private static const WIDGET_IDENTIFIER:String = "StatusWidget.swf";


		private static const Command_UpdateBet:int = 100;
		public var Bet_tf:TextField;

		private static const Command_UpdateCaps:int = 200;
		public var Caps_tf:TextField;

		private static const Command_UpdateEarnings:int = 300;
		public var Earnings_tf:TextField;

		private static const Command_UpdateScore:int = 400;
		public var Score_tf:TextField;

		private static const Command_UpdatePhase:int = 500;
		public var Phase_tf:TextField;


		public function StatusWidget()
		{
			// constructor
		}


		public function processMessage(command:String, params:Array):void
		{
			switch(command)
			{
				case String(Command_UpdateBet):
				{
					Bet_tf.text = String(int(params[0]));
					break;
				}
				case String(Command_UpdateCaps):
				{
					Caps_tf.text = String(int(params[0]));
					break;
				}
				case String(Command_UpdateEarnings):
				{
					Earnings_tf.text = String(int(params[0]));
					break;
				}
				case String(Command_UpdateScore):
				{
					Score_tf.text = String(int(params[0]));
					break;
				}
				case String(Command_UpdatePhase):
				{
					Phase_tf.text = String(params[0]);
					break;
				}
			}
		}


	}
}
