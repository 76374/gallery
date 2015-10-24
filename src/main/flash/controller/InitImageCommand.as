package controller
{
	import flash.display.Sprite;
	
	import model.AppModel;
	import model.ObjectsLocationModel;
	
	import org.robotlegs.mvcs.Command;
	
	import service.ImagesFactory;

	public class InitImageCommand extends Command
	{
		[Inject]
		public var imageFactory : ImagesFactory;
		
		[Inject]
		public var appData : AppModel;
		
		[Inject (name="imagesArea")]
		public var imagesArea : Sprite;
		
		[Inject]
		public var locations : ObjectsLocationModel;
		
		
		public override function execute() : void
		{
			var path : String = appData.getNextImagePath();
			var firstPath : String;//to avoid infinity loop when all images fit to area
			//getting next path of image that is not displayed
			while (locations.contain(path) || path == firstPath)
			{
				if (!firstPath)
				{
					firstPath = path;
				}
				path = appData.getNextImagePath();
			}
			if (path)
			{
				imagesArea.addChild(imageFactory.getImage(path));
			}
		}
	}
}