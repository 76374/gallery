package controller
{
	import model.AppModel;
	import view.image.ImageEvent;
	import model.ObjectsLocationModel;
	
	import org.robotlegs.mvcs.Command;
	
	import model.ImageData;

	public class HandleImageLoadedCommand extends Command
	{
		[Inject]
		public var event : ImageEvent;
		
		[Inject]
		public var objectLocation : ObjectsLocationModel;
		
		[Inject]
		public var appModel : AppModel;
		
		public override function execute() : void
		{
			var imageData : ImageData = event.imageProps;
			//TODO: check if image is too big
			var isImageAdded : Boolean = objectLocation.addObject(imageData.id, imageData.width, imageData.height);
			//if image fits to the area, load next one. Add to queue otherwise
			if (isImageAdded)
			{
				commandMap.execute(InitImageCommand);
			}
			else
			{
				appModel.addImageToQueue(imageData);
			}
		}
	}
}