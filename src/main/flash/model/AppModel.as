package model
{

	public class AppModel
	{
		private var _imagePaths : Vector.<String>;
		private var _imagePathCount : int;
		private var _imageQueue : Vector.<ImageData>;
		private var _loopedPath : Boolean;
		
		public function AppModel()
		{
			_imagePaths = new Vector.<String>();
			_imageQueue = new Vector.<ImageData>();
		}
		
		public function pushImagePath(path : String) : void
		{
			_imagePaths.push(path);
		}
		
		public function getNextImagePath() : String
		{
			if (!_imagePaths.length)
			{
				return null;
			}
			if (_imagePathCount >= _imagePaths.length)
			{
				if (_loopedPath)
				{
					_imagePathCount = 0;
				}
				else
				{
					return null;
				}
			}
			var path : String = _imagePaths[_imagePathCount];
			_imagePathCount++;
			return path;
		}
		
		public function resetPathCount() : void 
		{
			_imagePathCount = 0;
		}
		
		public function setLoopedPath(value : Boolean) : void
		{
			_loopedPath = value;
		}
		
		public function addImageToQueue(data : ImageData) : void 
		{
			_imageQueue.push(data);
		}
		
		public function shiftImageFromQueue() : ImageData
		{
			return _imageQueue.shift();
		}
		
		public function hasImageQueue() : Boolean
		{
			return _imageQueue.length > 0;
		}
	}
}