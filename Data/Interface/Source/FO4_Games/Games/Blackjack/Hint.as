package
{
	import flash.display.MovieClip;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;

	public class Hint extends MovieClip
	{
		public var Text_tf:TextField;
		public var Background_mc:MovieClip;

		private static const Gutter:int = 6;


		public function Hint()
		{
			Text_tf.autoSize = TextFieldAutoSize.LEFT;
			Text_tf.multiline = false;
			Text_tf.wordWrap = false;
		}


		public function get Text():String { return Text_tf.text; }
		public function set Text(aValue:String):void
		{
			Text_tf.text = aValue;
			Background_mc.width = Text_tf.width + Gutter;
		}


	}
}
