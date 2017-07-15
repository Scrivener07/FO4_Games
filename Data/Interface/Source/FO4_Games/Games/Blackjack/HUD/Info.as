package
{
	import flash.display.MovieClip;
	import flash.text.TextField;

	public class Info extends MovieClip
	{
		public var Name_tf:TextField;
		public function get Name():String { return Name_tf.text; }
		public function set Name(aValue:String):void { Name_tf.text = aValue; }

		public var Text_mc:MovieClip;
		public function get Text():String { return Text_mc.Text; }
		public function set Text(aValue:String):void { Text_mc.Text = aValue; }

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


		public function Info() {}

	}
}
