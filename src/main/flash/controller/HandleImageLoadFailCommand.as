package controller
{
	import org.robotlegs.mvcs.Command;
	
	public class HandleImageLoadFailCommand extends Command
	{	
		public override function execute() : void
		{
			//if attempt to load was failed, load next image
			commandMap.execute(InitImageCommand);
		}
	}
}