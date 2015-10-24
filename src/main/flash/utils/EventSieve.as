package utils
{
	import flash.events.Event;
	import flash.events.IEventDispatcher;
	import flash.events.TimerEvent;
	import flash.utils.Dictionary;
	import flash.utils.Timer;
	

	/**
	 * Simple class for slowing events down.
	 * When an event dispatches, it holds for specified period of time.
	 * If other event with same type is dispatched during this delay,
	 * it is canceled and the delay starts from the beginning.
	 * After the delay is over, the very first event is dispatched only.
	 * Can be used for decreasing amout of updates for some period of time
	 * or avoid multiply events in one frame etc.
	 */	
	public class EventSieve//TODO: think about better name
	{
		private static var _sieves : Dictionary = new Dictionary(true);
		
		public static function sieveEvent(dispatcher : IEventDispatcher, eventType : String) : void
		{
			_sieves[new EventSieve(dispatcher, eventType)] = true;
		}
		
		public static function removeDamper(dispatcher : IEventDispatcher, eventType : String = null) : void
		{
			for (var key : Object in _sieves) 
			{
				var damper : EventSieve = _sieves[key];
				if (damper.dispatcher == dispatcher && (!eventType || eventType == damper.eventType))
				{
					damper.dispose();
					delete _sieves[damper];
					if (eventType)
					{
						return;
					}
				}
			}
		}
		
		private static const DEFAULT_DELAY : Number = 300;
		
		private var _dispatcher : IEventDispatcher;
		private var _timer : Timer;
		private var _onHold : Event;
		private var _eventType : String;
		
		public function EventSieve(dispatcher : IEventDispatcher, eventType : String)
		{
			_timer = new Timer(DEFAULT_DELAY, 1);
			_timer.addEventListener(TimerEvent.TIMER_COMPLETE, onTimerComplete);
			
			_eventType = eventType;
			
			_dispatcher = dispatcher;
			_dispatcher.addEventListener(eventType, onEvent, false, int.MAX_VALUE);
		}
		
		public function get delay() : Number
		{
			return _timer.delay;
		}
		
		public function set delay(value : Number) : void
		{
			_timer.delay = value;
		}
		
		public function get dispatcher() : IEventDispatcher 
		{
			return _dispatcher;
		}
		
		public function get eventType() : String 
		{
			return _eventType;
		}
		
		public function dispose() : void
		{
			_timer.removeEventListener(TimerEvent.TIMER_COMPLETE, onTimerComplete);
			_timer.reset();
			_timer = null;
			
			_dispatcher.removeEventListener(eventType, onEvent);
			_dispatcher = null;
		}
		
		private function onEvent(e : Event) : void
		{
			if (e == _onHold)
			{
				_onHold = null;
				return;
			}
			e.stopPropagation();
			e.stopImmediatePropagation();
			if (_onHold)
			{
				_timer.reset();
			}
			else
			{
				_onHold = e;
			}
			_timer.start();
		}
		
		private function onTimerComplete(e : TimerEvent):void
		{
			_timer.reset();
			_onHold = _onHold.clone()
			_dispatcher.dispatchEvent(_onHold);
		}
	}
}