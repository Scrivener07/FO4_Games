package
{
	import flash.display.DisplayObjectContainer;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.text.TextField;
	import flash.utils.getQualifiedClassName;
	import Games.Debug;
	import Games.Display;
	import Games.IDisplay;

	public class Blackjack extends Display implements IDisplay
	{
		public var Info:MovieClip;


		// Display
		//---------------------------------------------

		public function Blackjack()
		{
			Debug.WriteLine(toString(), "Constructor");
			visible = true;
			Reset();
		}


		public function set Score(argument:String):void
		{
			Debug.WriteLine(toString(), "Player score is " + argument);
			Info.Score = argument;
		}


		public function set Bet(argument:String):void
		{
			Debug.WriteLine(toString(), "Player bet is " + argument);
			Info.Bet = argument;
		}


		public function set Caps(argument:String):void
		{
			Debug.WriteLine(toString(), "Player caps is " + argument);
			Info.Caps = argument;
		}


		public function set Earnings(argument:String):void
		{
			Debug.WriteLine(toString(), "Player earnings are " + argument);
			Info.Earnings = argument;
		}


		public function Reset():void
		{
			Debug.WriteLine(toString(), "Reset display values.");
			Score = "";
			Bet = "";
			Caps = "";
			Earnings = "";
		}


		override public function toString():String
		{
			return getQualifiedClassName(this);
		}


	}
}
