package view.image
{
	import flash.events.Event;
	import model.ImageData;
	
	public class ImageEvent extends Event
	{
		public static const LOADED : String = "loaded";
		public static const LOAD_FAILED : String = "loadFailed";
		public static const HIDING : String = "hiding";
		public static const REMOVED : String = "removed";
		
		private var _imageProps : ImageData;
		
		public function ImageEvent(type:String, imageProps : ImageData)
		{
			_imageProps = imageProps;
			super(type, bubbles, cancelable);
		}
		
		public function get imageProps() : ImageData 
		{
			return _imageProps;
		}
		
		public override function clone():Event
		{
			return new ImageEvent(type, imageProps);
		}
	}
}