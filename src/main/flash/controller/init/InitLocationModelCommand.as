package controller.init
{
	import model.ObjectsLocationModel;
	import model.packer.SimplePacker;
	import model.event.LocationEvent;
	
	import org.robotlegs.mvcs.Command;
	
	import utils.EventSieve;
	
	public class InitLocationModelCommand extends Command
	{
		//TODO : move this to constants or config
		private static const SPACE_BETWEEN_IMAGES : Number = 10;
		
		[Inject]
		public var objectLocation : ObjectsLocationModel;
		
		public override function execute() : void
		{
			//TODO: calculate and use images container width and height (now they are 0)
			objectLocation.init(new SimplePacker, contextView.stage.stageWidth, contextView.stage.stageHeight, SPACE_BETWEEN_IMAGES);
			//since app area size can be changed and images can be loaded fast,
			//a lot of updates can be fired in a short period of time.
			//so 'sieve' is added to slow them down
			EventSieve.sieveEvent(objectLocation.eventDispatcher, LocationEvent.UPDATE);
		}
	}
}