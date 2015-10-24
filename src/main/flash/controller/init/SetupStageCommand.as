package controller.init
{
	import flash.display.Sprite;
	import flash.display.StageScaleMode;
	
	import org.robotlegs.mvcs.Command;
	
	public class SetupStageCommand extends Command
	{
		public override function execute() : void
		{
			contextView.stage.scaleMode = StageScaleMode.NO_SCALE;
			
			var imagesArea : Sprite = new Sprite();
			contextView.addChild(imagesArea);
			injector.mapValue(Sprite, imagesArea, "imagesArea");
		}
	}
}