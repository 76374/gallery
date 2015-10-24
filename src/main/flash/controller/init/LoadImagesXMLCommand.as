package controller.init
{
	import model.constant.ConfigItemId;
	
	import org.robotlegs.mvcs.Command;
	
	import service.LoadService;

	public class LoadImagesXMLCommand extends Command
	{
		public static const IMAGES_XML_PATH : String = "config/images.xml";
		
		[Inject]
		public var loadService : LoadService;
		
		public override function execute() : void
		{
			loadService.loadXML(IMAGES_XML_PATH, ConfigItemId.IMAGES_XML);
		}
	}
}