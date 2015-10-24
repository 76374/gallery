package controller
{
	import model.AppModel;
	import view.image.ImageEvent;
	import model.ObjectsLocationModel;
	
	import org.robotlegs.mvcs.Command;
	
	import model.ImageData;
	
	public class ImageHidingCommand extends Command
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
			
			if (appModel.hasImageQueue()) 
			{
				var imageData : ImageData = appModel.shiftImageFromQueue();
				var isImageAdded : Boolean = objectLocation.addObjectIfItFit(imageData.id, imageData.width, imageData.height);
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