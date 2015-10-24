package controller.event
{
	import flash.events.Event;
	
	public class InitEvent extends Event
	{
		public static const IMAGES_CONFIG_LOADED : String = "imagesConfigLoaded";
		public static const IMAGES_CONFIG_PARSED : String = "imagesConfigParsed";
		
		public function InitEvent(type : String)
		{
			super(type);
		}
		
		public override function clone() : Event
		{
			return new InitEvent(type);
		}
	}
}