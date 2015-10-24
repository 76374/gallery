package model
{
	import flash.display.Sprite;
	import flash.geom.Rectangle;

	public class TestGP
	{
		public function TestGP(drawArea : Sprite)
		{
			testSP(drawArea);
		}
		
		private function testSP(drawArea : Sprite) : void
		{
			var rects : Vector.<Rectangle> = new Vector.<Rectangle>();
			for (var i : int = 0; i < 10; i++)
			{
				rects.push(getRandomRect(400, 400));
			}
			var packer : SimplePacker = new SimplePacker();
			var noFit : Vector.<Rectangle> = packer.pack(rects, 800, 600);
			trace(rects);
			trace(noFit);
			for each (var rect : Rectangle in rects) 
			{
				drawArea.graphics.beginFill(Math.random() * 0xCCCCCC + 0x333333);
				drawArea.graphics.drawRect(rect.x, rect.y, rect.width, rect.height);
				drawArea.graphics.endFill();
			}
		}
		
		private function testGP(drawArea : Sprite) : void
		{
			var rects : Vector.<Rectangle> = new Vector.<Rectangle>();
			for (var i : int = 0; i < 10; i++)
			{
				rects.push(getRandomRect(500, 500));
			}
			var packer : GrowingPacker = new GrowingPacker();
			var noFit : Vector.<Rectangle> = packer.pack(rects, drawArea.width, drawArea.height);
			trace(noFit);
			for each (var rect : Rectangle in rects) 
			{
				drawArea.graphics.beginFill(Math.random() * 0xCCCCCC + 0x333333);
				drawArea.graphics.drawRect(rect.x, rect.y, rect.width, rect.height);
				drawArea.graphics.endFill();
			}
		}
		
		private function getRandomRect(maxWidth : Number, maxHeight : Number) : Rectangle
		{
			return new Rectangle(0, 0, int(Math.random() * maxWidth), int(Math.random() * maxHeight))
		}
	}
}