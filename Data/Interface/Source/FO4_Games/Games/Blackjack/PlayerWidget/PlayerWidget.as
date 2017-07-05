package
{
	import flash.display.MovieClip;
	import flash.text.TextField;
	import hudframework.IHUDWidget;

	public class PlayerWidget extends MovieClip implements IHUDWidget
	{
		private static const WIDGET_IDENTIFIER:String = "PlayerWidget.swf";


		private static const Command_UpdateName:int = 100;
		public var Name_tf:TextField;

		private static const Command_UpdateTurn:int = 200;
		public var Turn_tf:TextField;

		private static const Command_UpdateScore:int = 300;
		public var Score_tf:TextField;

		private static const Command_UpdateBet:int = 400;
		public var Bet_tf:TextField;

		private static const Command_UpdateEarnings:int = 500;
		public var Earnings_tf:TextField;


		public function PlayerWidget()
		{
			// constructor
		}


		public function processMessage(command:String, params:Array):void
		{
			switch(command)
			{
				case String(Command_UpdateName):
				{
					Name_tf.text = String(params[0]);
					break;
				}
				case String(Command_UpdateTurn):
				{
					Turn_tf.text = String(params[0]);
					break;
				}
				case String(Command_UpdateScore):
				{
					Score_tf.text = String(int(params[0]));
					break;
				}
				case String(Command_UpdateBet):
				{
					Bet_tf.text = String(int(params[0]));
					break;
				}
				case String(Command_UpdateEarnings):
				{
					Earnings_tf.text = String(int(params[0]));
					break;
				}
			}
		}


	}
}
