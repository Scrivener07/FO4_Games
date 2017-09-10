package
{
	public interface IButtonHint
	{
		function SetButtons(argument:Object) : void;
		function SetButton(argument:Object) : void;
		function get IsLoaded() : Boolean;
		function get Visible() : Boolean;
		function set Visible(argument:Boolean) : void
	}
}
