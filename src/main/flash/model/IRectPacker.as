package model
{
	import flash.geom.Rectangle;

	public interface IRectPacker
	{
		/**
		 * 
		 * @param rects
		 * @param width - total area width to fit
		 * @param height - total area height to fit
		 * @return - extra rects that don't fit to area
		 */		
		function pack(rects : Vector.<Rectangle>, width : Number, height : Number, space : Number) : Vector.<Rectangle>;
	}
}