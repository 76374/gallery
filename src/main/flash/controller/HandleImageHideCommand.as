package controller
{
	import model.AppModel;
	import view.image.ImageEvent;
	import model.ObjectsLocationModel;
	
	import org.robotlegs.mvcs.Command;
	
	import model.ImageData;
	
	public class HandleImageHideCommand extends Command
	{
		[Inject]
		public var event : ImageEvent;
		
		[Inject]
		public var objectLocation : ObjectsLocationModel;
		
		[Inject]
		public var appModel : AppModel;
		
		public override function execute() : void
		{
			var imageProps : ImageData = event.imageProps;
			objectLocation.remove(imageProps.id);
			
			//check if there is image that is already loaded and hided
			if (appModel.hasImagesInQueue()) 
			{
				var imageData : ImageData = appModel.shiftImageFromQueue();
				var isImageAdded : Boolean = objectLocation.addObject(imageData.id, imageData.width, imageData.height);
				if (!isImageAdded)
				{
					appModel.addImageToQueue(imageData);
				}
			}
			else
			{
				commandMap.execute(InitImageCommand);
			}
		}
	}
}