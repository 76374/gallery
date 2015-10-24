package controller
{
	import model.AppModel;
	import view.image.ImageEvent;
	import model.ObjectsLocationModel;
	
	import org.robotlegs.mvcs.Command;
	
	import model.ImageData;

	public class ImageLoadCompleteCommand extends Command
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
			var isImageAdded : Boolean = objectLocation.addObjectIfItFit(imageData.id, imageData.width, imageData.height);
			//objectLocation.updatePlacement();
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