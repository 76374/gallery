package controller.init
{
	import controller.event.InitEvent;
	
	import model.constant.AppConstants;
	
	import org.robotlegs.mvcs.Command;
	
	import service.event.LoadServiceEvent;

	public class LoadCompleteCommand extends Command
	{
		[Inject]
		public var event : LoadServiceEvent;
		
		public override function execute() : void 
		{
			if (event.targetId == AppConstants.IMAGES_XML_ID)
			{
				dispatch(new InitEvent(InitEvent.IMAGES_CONFIG_LOADED));
			}
		}
	}
}