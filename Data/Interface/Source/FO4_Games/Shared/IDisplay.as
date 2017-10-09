package Shared
{
	public interface IDisplay
	{
		function get Exists() : Boolean; // depreciate
		function get Visible() : Boolean;
		function set Visible(argument:Boolean) : void;
		function BringToFront() : void;
	}
}
