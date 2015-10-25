package model
{
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.utils.Dictionary;
	
	import model.event.LocationEvent;
	import model.packer.IRectPacker;
	
	import org.robotlegs.mvcs.Actor;

	/**
	 *  Finds and reperesents positions of display objects.
	 */	
	public class ObjectsLocationModel extends Actor
	{
		private static const DEFAULT_SPACE : Number = 0;
		
		private var _width : Number;
		private var _height : Number;
		private var _space : Number;
		private var _packer : IRectPacker;
		private var _locations : Dictionary;
		
		public function ObjectsLocationModel()
		{
			_locations = new Dictionary();
		}
		
		public function init(packer : IRectPacker, width : Number, height : Number, space : Number) : void
		{
			if (!packer)
			{
				throw new ArgumentError("packer is null");
			}
			if (!isValidPositiveNumber(width))
			{
				throw new ArgumentError("invalid width: " + width);
			}
			if (!isValidPositiveNumber(height))
			{
				throw new ArgumentError("invalid height: " + height);
			}
			if (isNaN(space))
			{
				throw new ArgumentError("invalid space: " + space);
			}
			_packer = packer;
			_width = width;
			_height = height;
			_space = space;
		}
		
		/**
		 * @param id - used to identify image in remove(), getPosition(), LocationEvent 
		 * @param width
		 * @param height
		 * @return true if object has been added and false otherwise
		 */		
		public function addObject(id : String, width : Number, height : Number) : Boolean
		{
			if (!_packer)
			{
				throw new Error("Packer hasn't been set. Possibly init() wasn't called");
			}
			if (!id)
			{
				throw new ArgumentError("invalid id: " + id);
			}
			if (!isValidPositiveNumber(width))
			{
				throw new ArgumentError("invalid width: " + width);
			}
			if (!isValidPositiveNumber(height))
			{
				throw new ArgumentError("invalid height: " + height);
			}
			if (_locations[id])
			{
				//TODO: notify about location is already added
				return false;
			}
			var testLocations : Vector.<Rectangle> =  dicToRectVec(_locations);
			var rectToAdd : Rectangle = new Rectangle(0, 0, width, height);
			testLocations.push(rectToAdd);
			var extraObjects : Vector.<Rectangle> = pack(testLocations);
			//checking if new rect fits to total area
			if (extraObjects)
			{
				//position can be broken after adding object that doesn't fit
				//so repack old objects
				pack(dicToRectVec(_locations));
				return false;
			} 
			_locations[id] = rectToAdd;
			dispatch(new LocationEvent(LocationEvent.UPDATE));
			return true;
		}
		
		public function remove(id : String) : void
		{
			for (var key : String in _locations)
			{
				if (key == id)
				{
					delete _locations[id];
					pack(dicToRectVec(_locations));
					dispatch(new LocationEvent(LocationEvent.UPDATE));
					return;
				}
			}
		}
		
		public function contain(id : String) : Boolean
		{
			return _locations[id] != undefined;
		}
		
		public function getPosition(imageId : String) : Point
		{
			for (var id : String in _locations)
			{
				if (id == imageId)
				{
					var rect : Rectangle = _locations[id];
					return new Point(rect.x, rect.y);
				}
			}
			return null;
		}
		
		public function get width() : Number
		{
			return _width;
		}
		
		public function set width(value : Number) : void
		{
			if (!validSizeValue(value) || _width == value)
			{
				return;
			}
			_width = value;
		}
		
		public function get height() : Number
		{
			return _height;
		}
		
		public function set height(value : Number) : void
		{
			if (!validSizeValue(value) || _height == value)
			{
				return;
			}
			_height = value;
		}
		
		
		public function get space() : Number
		{
			return _space;
		}
		
		public function set space(value : Number) : void
		{
			if (_space == value)
			{
				return;
			}
			_space = value;
		}
		
		private function dicToRectVec(dic : Dictionary) : Vector.<Rectangle>
		{
			var result : Vector.<Rectangle> = new Vector.<Rectangle>();
			for each (var rect : Rectangle in dic) 
			{
				result.push(rect);
			}
			return result;
		}
		
		private function validSizeValue(value : Number) : Boolean
		{
			return !isNaN(value) && value > 0;
		}
		
		private function pack(rects : Vector.<Rectangle>) : Vector.<Rectangle> {
			return _packer.pack(rects, _width, _height, _space);
		}
		
		private function isValidPositiveNumber(num : Number) : Boolean {
			return !isNaN(num) && num > 0;
		}
	}
}