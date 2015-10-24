package
{
	import controller.ImageHidingCommand;
	import controller.ImageLoadCompleteCommand;
	import controller.ImageLoadFailCommand;
	import controller.InitImageCommand;
	import controller.event.AppEvent;
	import controller.init.InitLocationModelCommand;
	import controller.init.LoadCompleteCommand;
	import controller.init.LoadImagesXMLCommand;
	import controller.init.ParseImagesXMLCommand;
	import controller.init.SetupStageCommand;
	
	import flash.display.DisplayObjectContainer;
	import flash.display.Sprite;
	
	import model.AppModel;
	import view.image.ImageEvent;
	import model.ObjectsLocationModel;
	
	import org.robotlegs.base.ContextEvent;
	import org.robotlegs.mvcs.Context;
	
	import service.ImagesFactory;
	import service.LoadService;
	import service.event.LoadServiceEvent;
	
	import view.image.ImageMediator;
	import view.image.ImageView;
	
	public class GalleryContext extends Context
	{
		public function GalleryContext(contextView : DisplayObjectContainer)
		{
			super(contextView);
		}
		
		public override function startup() : void
		{
			injector.mapSingleton(LoadService);
			injector.mapSingleton(AppModel);
			injector.mapSingleton(ImagesFactory);
			injector.mapSingleton(ObjectsLocationModel);
			
			commandMap.mapEvent(ContextEvent.STARTUP_COMPLETE, LoadImagesXMLCommand, ContextEvent);
			commandMap.mapEvent(ContextEvent.STARTUP_COMPLETE, SetupStageCommand, ContextEvent);
			commandMap.mapEvent(ContextEvent.STARTUP_COMPLETE, InitLocationModelCommand, ContextEvent);
			commandMap.mapEvent(LoadServiceEvent.COMPLETE, LoadCompleteCommand, LoadServiceEvent);
			commandMap.mapEvent(AppEvent.IMAGES_CONFIG_LOADED, ParseImagesXMLCommand, AppEvent);
			commandMap.mapEvent(AppEvent.IMAGES_CONFIG_PARSED, InitImageCommand, AppEvent);
			commandMap.mapEvent(ImageEvent.LOADED, ImageLoadCompleteCommand, ImageEvent);
			commandMap.mapEvent(ImageEvent.LOAD_FAILED, ImageLoadFailCommand, ImageEvent);
			commandMap.mapEvent(ImageEvent.HIDING, ImageHidingCommand, ImageEvent);
			//commandMap.mapEvent(ImageEvent.REMOVED, ImageRemovedCommand, ImageEvent);
			
			mediatorMap.mapView(ImageView, ImageMediator);
			
			super.startup();
		}
	}
}