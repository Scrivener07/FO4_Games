package Games
{
	public class Debug
	{
		public static function WriteLine(prefix:Object, line:Object="", ... rest) : void
		{
				if (rest != null)
				{
					for (var i:uint = 0; i < rest.length; i++)
					{
							line += " "+rest[i];
					}
				}
			trace("[Games] "+prefix+" "+line);
		}
	}
}
