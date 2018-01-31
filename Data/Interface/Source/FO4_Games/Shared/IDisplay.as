package Shared
{
	public interface IDisplay
	{
		function get Exists() : Boolean;
		function get Visible() : Boolean;
		function set Visible(argument:Boolean) : void;
	}
}
