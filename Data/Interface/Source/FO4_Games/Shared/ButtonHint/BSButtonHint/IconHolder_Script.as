package BSButtonHint
{
	import flash.display.MovieClip;

	public dynamic class IconHolder_Script extends MovieClip
	{

		public var IconAnimInstance:MovieClip;


		public function IconHolder_Script()
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
