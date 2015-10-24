package controller.init
{
	import controller.event.AppEvent;
	
	import model.AppModel;
	import model.constant.ConfigItemId;
	
	import org.robotlegs.mvcs.Command;
	
	import service.LoadService;
	
	public class ParseImagesXMLCommand extends Command
	{
		[Inject]
		public var loadService : LoadService;
		
		[Inject]
		public var appData : AppModel;
		
		public override function execute() : void
		{
			var xml : XML = loadService.getLoadedXML(ConfigItemId.IMAGES_XML);
			var imagesList : XMLList = xml.image;
			for each(var imageXML : XML in imagesList)
			{
				var path : String = imageXML.@path;
				if (path)
				{
					appData.pushImagePath(path);
				}
			}
			appData.setLoopedPath(xml.@loop == "true" || xml.@loop != "1");
			
			dispatch(new AppEvent(AppEvent.IMAGES_CONFIG_PARSED));
		}
	}
}