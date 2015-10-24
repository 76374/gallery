package controller
{
	import org.robotlegs.mvcs.Command;
	
	public class ImageLoadFailCommand extends Command
	{	
		public override function execute() : void
		{
			//if attempt to load was failed, load next image
			commandMap.execute(InitImageCommand);
		}
	}
}