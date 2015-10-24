package controller.init
{
	import flash.display.Sprite;
	import flash.display.StageScaleMode;
	
	import model.constant.AppConstants;
	
	import org.robotlegs.mvcs.Command;
	
	public class SetupStageCommand extends Command
	{
		public override function execute() : void
		{
			contextView.stage.scaleMode = StageScaleMode.NO_SCALE;
			
			var imagesArea : Sprite = new Sprite();
			contextView.addChild(imagesArea);
			injector.mapValue(Sprite, imagesArea, AppConstants.IMAGES_AREA_NAME);
		}
	}
}