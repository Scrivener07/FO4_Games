package Shared
{
	import flash.display.DisplayObjectContainer;
	import flash.display.DisplayObject;
	import flash.display.MovieClip;

	public class Utility
	{

		public static function WalkMovie(movieClip:MovieClip) : String
		{
			return WalkMovieFrom(movieClip, movieClip);
		}


		public static function WalkMovieFrom(from:DisplayObject, to:MovieClip) : String
		{
			var path:String = from.name;
			while (from != to.root)
			{
				from = from.parent;
				path = from.name+"."+path;
			};
			return "stage."+path;
		}


		public static function TraceObject(object:Object, prefix:String = "") : void
		{
			prefix == "" ? prefix = "---" : prefix += "---";
			for (var element:* in object)
			{
				trace (prefix, element + " : " + object[element], "  ");
				if (typeof(object[element]) == "object") TraceObject(object[element], prefix);
			}
		}


	    public static function TraceDisplayList(container:DisplayObjectContainer, options:* = undefined, indentString:String = "", depth:int = 0, childAt:int = 0):void
	    {
	        if (typeof options == "undefined") options = Number.POSITIVE_INFINITY;

	        if (depth > options) return;

	        const INDENT:String = "   ";
	        var i:int = container.numChildren;

	        while (i--)
	        {
	            var child:DisplayObject = container.getChildAt(i);
	            var output:String = indentString+(childAt++)+": "+child.name+" --> "+child;

	            // debug alpha/visible properties
	            output += "\t\talpha: "+child.alpha.toFixed(2)+"/"+child.visible;

	            // debug x and y position
	            output += ", @: ("+child.x+", "+child.y+")";

	            // debug transform properties
	            output += ", w:"+child.width+"px ("+child.scaleX.toFixed(2)+")";
	            output += ", h:"+child.height+"px ("+child.scaleY.toFixed(2)+")";
	            output += ", r:"+child.rotation.toFixed(1)+"";

	            if (typeof options == "number") trace(output);
	                else if (typeof options == "string" && output.match(new RegExp(options, "gi")).length != 0)
	                {
	                    trace(output, "in", container.name, "-->", container);
	                }

	            if (child is DisplayObjectContainer) TraceDisplayList(DisplayObjectContainer(child), options, indentString + INDENT, depth + 1);
	        }
	    }


	}
}
