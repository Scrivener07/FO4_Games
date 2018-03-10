package
{
	import flash.display.MovieClip;

	public dynamic class IconHolderInstance extends MovieClip
	{

		public var IconAnimInstance:MovieClip;


		public function IconHolderInstance()
		{
			super();
			addFrameScript(0, this.frame1, 59, this.frame60);
		}


		function frame1() : *
		{
			stop();
		}


		function frame60() : *
		{
			gotoAndPlay("Flashing");
		}


	}
}
