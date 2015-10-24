package model.event
{
	import flash.events.Event;
	
	public class LocationEvent extends Event
	{
		public static const UPDATE:String = "update";
		
		public function LocationEvent(type : String)
		{
			super(type);
		}
		
		public override function clone() : Event
		{
			return new LocationEvent(type);
		}
	}
}