package
{
	import flash.display.MovieClip;
	import flash.text.TextField;

	public class Info extends MovieClip
	{
		public var Score_tf:TextField;
		public function get Score():String { return Score_tf.text; }
		public function set Score(aValue:String):void { Score_tf.text = aValue; }

		public var Bet_tf:TextField;
		public function get Bet():String { return Bet_tf.text; }
		public function set Bet(aValue:String):void { Bet_tf.text = aValue; }

		public var Caps_tf:TextField;
		public function get Caps():String { return Caps_tf.text; }
		public function set Caps(aValue:String):void { Caps_tf.text = aValue; }

		public var Earnings_tf:TextField;
		public function get Earnings():String { return Earnings_tf.text; }
		public function set Earnings(aValue:String):void { Earnings_tf.text = aValue; }
	}
}
