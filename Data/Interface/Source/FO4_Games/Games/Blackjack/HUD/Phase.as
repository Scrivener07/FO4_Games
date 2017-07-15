package
{
	import flash.display.MovieClip;
	import flash.text.TextField;

	public class Phase extends MovieClip
	{
		public var Name_tf:TextField;
		public function get Name():String { return Name_tf.text; }
		public function set Name(aValue:String):void { Name_tf.text = aValue; }

		public function Phase() {}


	}
}
