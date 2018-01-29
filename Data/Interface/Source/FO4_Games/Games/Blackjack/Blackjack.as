package
{
	import flash.display.DisplayObjectContainer;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.text.TextField;
	import Shared.Display;
	import Shared.IDisplay;

	public class Blackjack extends Display implements IDisplay
	{
		public var Info:MovieClip;


		// Display
		//---------------------------------------------

		public function Blackjack()
		{
			trace("[Blackjack] Constructor");
			visible = true;
			Reset();
		}


		public function set Score(argument:String):void
		{
			trace("[Blackjack] Player score is " + argument);
			Info.Score = argument;
		}


		public function set Bet(argument:String):void
		{
			trace("[Blackjack] Player bet is " + argument);
			Info.Bet = argument;
		}


		public function set Caps(argument:String):void
		{
			trace("[Blackjack] Player caps is " + argument);
			Info.Caps = argument;
		}


		public function set Earnings(argument:String):void
		{
			trace("[Blackjack] Player earnings are " + argument);
			Info.Earnings = argument;
		}


		public function Reset():void
		{
			trace("[Blackjack] Reset display values.");
			Score = "";
			Bet = "";
			Caps = "";
			Earnings = "";
		}


	}
}
