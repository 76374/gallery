package controller.init
{
	import model.constant.AppConstants;
	
	import org.robotlegs.mvcs.Command;
	
	import service.LoadService;

	public class LoadImagesXMLCommand extends Command
	{
		[Inject]
		public var loadService : LoadService;
		
		public override function execute() : void
		{
			loadService.loadXML(AppConstants.IMAGES_XML_PATH, AppConstants.IMAGES_XML_ID);
		}
	}
}