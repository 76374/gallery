package service.event
{
	import flash.events.Event;
	
	public class LoadServiceEvent extends Event
	{
		public static const COMPLETE:String = "complete";
		public static const FAIL:String = "fail";
		
		private var _targetId : String;
		
		public function LoadServiceEvent(type:String, targetId : String)
		{
			super(type);
			_targetId = targetId;
		}
		
		public function get targetId() : String
		{
			return _targetId;			
		}
		
		public override function clone():Event
		{
			return new LoadServiceEvent(type, targetId);
		}
	}
}