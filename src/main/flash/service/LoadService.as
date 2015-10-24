package service
{
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.SecurityErrorEvent;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.utils.Dictionary;
	
	import org.robotlegs.mvcs.Actor;
	
	import service.event.LoadServiceEvent;

	public class LoadService extends Actor
	{
		//storing urlloaders for finding out ids after load complete/failed
		private var _xmlLoaders : Dictionary;
		private var _loadedXMLs : Dictionary;
		
		public function LoadService()
		{
			_xmlLoaders = new Dictionary();
			_loadedXMLs = new Dictionary();
		}
		
		/**
		 * @param path
		 * @param id  - used for identifing in LoadServiceEvent what exact item has been loaded 
		 * for retrieving it in getLoadedXML
		 */		
		public function loadXML(path : String, id : String) : void
		{
			trace("loadXML "+path+" "+id);
			if (!path || !id)
			{
				throw new ArgumentError("null or empty argument");
			}
			if (_xmlLoaders[id])
			{
				//TODO: notify about attempt to load xml with id that already in progress
				return;				
			}
			var request : URLRequest = new URLRequest(path);
			var loader : URLLoader = new URLLoader(request);
			loader.addEventListener(Event.COMPLETE, onXMLLoadComplete);
			loader.addEventListener(IOErrorEvent.IO_ERROR, onXMLLoadIOError);
			loader.addEventListener(SecurityErrorEvent.SECURITY_ERROR, onXMLLoadSecurityError);
			_xmlLoaders[id] = loader;
		}
		
		/**
		 * @param id - expected to be received in loadXML method and LoadServiceEvent after load is complete
		 * @return loaded XML or null if it hasn't been loaded yet.
		 */				
		public function getLoadedXML(id : String) : XML 
		{
			return _loadedXMLs[id] || null;
		}
		
		//
		
		private function onXMLLoadComplete(e : Event) : void 
		{	
			var loader : URLLoader = e.target as URLLoader;
			var id : String = getLoaderId(loader);
			_loadedXMLs[id] = XML(loader.data);
			clearXMLLoader(loader, id);
			
			dispatch(new LoadServiceEvent(LoadServiceEvent.COMPLETE, id));
		}
		
		private function onXMLLoadIOError(e : IOErrorEvent) : void 
		{
			handleFailedXMLLoad(e);
		}
		
		private function onXMLLoadSecurityError(e : SecurityErrorEvent) : void 
		{
			handleFailedXMLLoad(e);	
		}
		
		//
		
		private function handleFailedXMLLoad(e : Event) : void 
		{
			trace("handleFailedXMLLoad");
			var loader : URLLoader = e.target as URLLoader;
			var id : String = getLoaderId(loader);
			clearXMLLoader(loader, id);
			
			dispatch(new LoadServiceEvent(LoadServiceEvent.FAIL, id));
		}
		
		private function getLoaderId(loader : URLLoader) : String
		{
			for (var key : String in _xmlLoaders) {
				if (_xmlLoaders[key] == loader)
				{
					return key;
				}
			}
			return null;
		}
		
		private function clearXMLLoader(loader : URLLoader, id : String) : void {
			loader.removeEventListener(Event.COMPLETE, onXMLLoadComplete);
			loader.removeEventListener(IOErrorEvent.IO_ERROR, onXMLLoadIOError);
			loader.removeEventListener(SecurityErrorEvent.SECURITY_ERROR, onXMLLoadSecurityError);
			delete _xmlLoaders[id];
		}
	}
}