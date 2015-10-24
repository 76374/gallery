package controller.event
{
	import flash.events.Event;
	
	public class AppEvent extends Event
	{
		public static const IMAGES_CONFIG_LOADED : String = "imagesConfigLoaded";
		public static const IMAGES_CONFIG_PARSED : String = "imagesConfigParsed";
		
		public function AppEvent(type : String)
		{
			super(type);
		}
		
		public override function clone() : Event
		{
			return new AppEvent(type);
		}
	}
}