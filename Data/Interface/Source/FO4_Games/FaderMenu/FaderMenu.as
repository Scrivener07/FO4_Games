package
{
	import Shared.GlobalFunc;
	import Shared.IMenu;
	import flash.display.MovieClip;
	import flash.geom.ColorTransform;

	public class FaderMenu extends IMenu
	{
		public var BGSCodeObj:Object;
		public var FadeRect_mc:MovieClip;
		public var SpinnerIcon_mc:MovieClip;
		public var FadeValue:Number;

		private var fStartAlpha:Number;
		private var fEndAlpha:Number;
		private var fFadeDuration:Number;
		private var fFadeElapsedSecs:Number;
		private var fTotalElapsedSecs:Number;
		private var iPostFadeCountdown:int;
		private var fMinNumSeconds:Number;
		private var bShaderFadeActivated:Boolean;

		// Games
		private var displayShown:Boolean;


		// Constructor
		//---------------------------------------------

		public function FaderMenu()
		{
			super();
			this.BGSCodeObj = new Object();
			this.fStartAlpha = 1;
			this.FadeValue = this.fStartAlpha;
			this.fEndAlpha = 0;
			this.fFadeDuration = 0;
			this.fFadeElapsedSecs = 0;
			this.fTotalElapsedSecs = 0;
			this.fMinNumSeconds = 0;
			this.iPostFadeCountdown = -1;

			displayShown = false;
		}


		override protected function onSetSafeRect() : void
		{
			trace("[FaderMenu.psc] onSetSafeRect: Locking spinner icon to the bottom right area.");
			GlobalFunc.LockToSafeRect(this.SpinnerIcon_mc, "BR", SafeX, SafeY);
		}


		// Games
		//---------------------------------------------

		public function ShowDisplay() : void
		{
			if (!displayShown)
			{
				displayShown = true;
				FadeRect_mc.visible = false;
				SpinnerIcon_mc.visible = false;
				trace("[FaderMenu.psc] ShowDisplay: Called by papyrus code.");
			}
			else
			{
				trace("[FaderMenu.psc] ShowDisplay: Display is already shown.");
			}
		}


		public function HideDisplay() : void
		{
			if (displayShown)
			{
				displayShown = false;
				BGSCodeObj.onFadeDone();
				trace("[FaderMenu.psc] HideDisplay: Called by papyrus code.");
			}
			else
			{
				trace("[FaderMenu.psc] HideDisplay: Display is already hidden.");
			}
		}


		// Vanilla
		//---------------------------------------------

		public function SetImmediateWhiteFullFade() : *
		{
			if (displayShown)
			{
				trace("[FaderMenu.psc] SetImmediateWhiteFullFade: Ignoring native calls while the display is shown.");
				return;
			}
			else
			{
				trace("[FaderMenu.psc] SetImmediateWhiteFullFade: Called by native code.");
				this.FadeValue = 1;
				this.FadeRect_mc.alpha = 1;
				this.FadeRect_mc.visible = true;
				var _loc1_:ColorTransform = this.FadeRect_mc.transform.colorTransform;
				_loc1_.redOffset = 255;
				_loc1_.greenOffset = 255;
				_loc1_.blueOffset = 255;
				this.FadeRect_mc.transform.colorTransform = _loc1_;
				this.SpinnerIcon_mc.visible = false;
			}
		}


		public function initFade(param1:Boolean, param2:Boolean, param3:Number, param4:Number, param5:Boolean, param6:Boolean) : *
		{
			if (displayShown)
			{
				trace("[FaderMenu.psc] initFade: Ignoring native calls while the display is shown.");
				return;
			}
			else
			{
				trace("[FaderMenu.psc] initFade: Called by native code.");
				this.bShaderFadeActivated = param5;
				if(this.FadeRect_mc.alpha > 0 && this.FadeRect_mc.alpha < 1)
				{
					if(param1)
					{
						this.fFadeElapsedSecs = (1 - this.FadeRect_mc.alpha) / 1 * param3;
					}
					else
					{
						this.fFadeElapsedSecs = this.FadeRect_mc.alpha / 1 * param3;
					}
				}
				else
				{
					this.fFadeElapsedSecs = 0;
					this.fTotalElapsedSecs = 0;
				}
				if(!param1)
				{
					this.fStartAlpha = 0;
					this.fEndAlpha = 1;
					this.FadeRect_mc.alpha = 0;
				}
				else
				{
					this.fStartAlpha = 1;
					this.fEndAlpha = 0;
					this.FadeRect_mc.alpha = 1;
				}
				var _loc7_:ColorTransform = this.FadeRect_mc.transform.colorTransform;
				_loc7_.redOffset = !!param2?Number(0):Number(255);
				_loc7_.greenOffset = !!param2?Number(0):Number(255);
				_loc7_.blueOffset = !!param2?Number(0):Number(255);
				this.FadeRect_mc.transform.colorTransform = _loc7_;
				this.fFadeDuration = param3;
				this.fMinNumSeconds = param4;
				this.SpinnerIcon_mc.visible = param2 && !param6;
				this.FadeValue = this.fStartAlpha;
				if(this.bShaderFadeActivated)
				{
					this.FadeRect_mc.alpha = 0;
					this.SpinnerIcon_mc.alpha = 0;
				}
				else
				{
					this.FadeRect_mc.alpha = this.fStartAlpha;
					this.SpinnerIcon_mc.alpha = this.fStartAlpha;
				}
			}
		}


		public function updateFade(param1:Number) : *
		{
			if (displayShown)
			{
				trace("[FaderMenu.psc] updateFade: Ignoring native calls while the display is shown.");
				return;
			}
			else
			{
				trace("[FaderMenu.psc] updateFade: Called by native code.");
				this.fTotalElapsedSecs = this.fTotalElapsedSecs + param1;
				if(this.iPostFadeCountdown > 0)
				{
					this.iPostFadeCountdown--;
					if(this.iPostFadeCountdown == 0)
					{
						this.iPostFadeCountdown = -1;
						this.BGSCodeObj.onFadeDone();
					}
				}
				else if(this.fTotalElapsedSecs >= this.fMinNumSeconds)
				{
					this.fFadeElapsedSecs = Math.min(this.fFadeElapsedSecs + param1, this.fFadeDuration);
					this.FadeValue = GlobalFunc.Lerp(this.fStartAlpha, this.fEndAlpha, 0, this.fFadeDuration, this.fFadeElapsedSecs, true);
					if(this.fFadeElapsedSecs == this.fFadeDuration)
					{
						this.FadeValue = this.fEndAlpha;
						this.iPostFadeCountdown = 1;
					}
					if(this.bShaderFadeActivated)
					{
						this.FadeRect_mc.alpha = 0;
						this.SpinnerIcon_mc.alpha = 0;
					}
					else
					{
						this.FadeRect_mc.alpha = this.FadeValue;
						this.SpinnerIcon_mc.alpha = this.FadeValue;
					}
				}
			}
		}


	}
}
