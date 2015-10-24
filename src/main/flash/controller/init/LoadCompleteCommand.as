package controller.init
{
	import controller.event.AppEvent;
	
	import model.constant.ConfigItemId;
	
	import org.robotlegs.mvcs.Command;
	
	import service.event.LoadServiceEvent;

	public class LoadCompleteCommand extends Command
	{
		[Inject]
		public var event : LoadServiceEvent;
		
		public override function execute() : void 
		{
			if (event.targetId == ConfigItemId.IMAGES_XML)
			{
				dispatch(new AppEvent(AppEvent.IMAGES_CONFIG_LOADED));
			}
		}
	}
}