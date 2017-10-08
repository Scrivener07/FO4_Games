package
{
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.text.TextField;
	import hudframework.IHUDWidget;
	import Shared.IDisplay;

	public class Blackjack extends MovieClip implements IDisplay, IHUDWidget, IBlackjack
	{
		private static const WIDGET_IDENTIFIER:String = "Blackjack.swf";

		// IDisplay
		public function get Exists():Boolean { return true; }
		public function get Visible():Boolean { return this.visible; }
		public function set Visible(argument:Boolean):void { this.visible = argument; }


		// Status
		public var PhaseFader_mc:MovieClip;
		public var Text_mc:MovieClip;

		// Info
		public var Player_mc:MovieClip;
		public var Dealer_mc:MovieClip; // TODO: unused

		// Commands
		private static const Command_UpdatePhase:int = 100;
		private static const Command_UpdateText:int = 200;
		private static const Command_UpdateName:int = 300;
		private static const Command_UpdateScore:int = 400;
		private static const Command_UpdateBet:int = 500;
		private static const Command_UpdateCaps:int = 600;
		private static const Command_UpdateEarnings:int = 700;


		public function Blackjack()
		{
			trace("[Blackjack] Constructor");
			addEventListener(Event.ADDED_TO_STAGE, OnAddedToStage);
		}


		private function OnAddedToStage(e:Event):void
		{
			trace("[Blackjack] OnAddedToStage");
		}

		public function derpDerp(argString:String):void
		{
			// @IBlackjack, TODO: f4se interop
		}
		
		public function processMessage(command:String, params:Array):void
		{
			trace("[Blackjack] processMessage");
			switch(command)
			{
				case String(Command_UpdatePhase):
				{
					PhaseFader_mc.Phase_mc.Name = String(params[0]);
					PhaseFader_mc.gotoAndPlay("Show")
					break;
				}

				case String(Command_UpdateName):
				{
					Player_mc.Info_mc.Name = String(params[0]);
					break;
				}
				case String(Command_UpdateText):
				{
					Text_mc.Text = String(params[0]);
					break;
				}
				case String(Command_UpdateScore):
				{
					Player_mc.Info_mc.Score = String(int(params[0]));
					break;
				}
				case String(Command_UpdateBet):
				{
					Player_mc.Info_mc.Bet = String(int(params[0]));
					break;
				}
				case String(Command_UpdateCaps):
				{
					Player_mc.Info_mc.Caps = String(int(params[0]));
					break;
				}
				case String(Command_UpdateEarnings):
				{
					Player_mc.Info_mc.Earnings = String(int(params[0]));
					break;
				}
			}
		}


	}
}
