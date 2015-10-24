package model
{
	public class ImageData
	{
		private var _id : String;
		private var _width : Number;
		private var _height : Number;
		
		public function ImageData(id : String, width : Number, height : Number)
		{
			_id = id;
			_width = width;
			_height = height;
		}
		
		public function get id() : String
		{
			return _id;
		}
		
		public function get width() : Number
		{
			return _width;
		}
		
		public function get height() : Number
		{
			return _height;
		}
	}
}