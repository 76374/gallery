package model
{
	import flash.geom.Rectangle;
	
	import model.packer.SimplePacker;
	
	import org.flexunit.asserts.assertFalse;
	import org.flexunit.asserts.assertNotNull;
	import org.flexunit.asserts.assertNull;

	public class SimplePackerTest
	{		
		[Test]
		public function testPacker() : void
		{
			var rects : Vector.<Rectangle> = new <Rectangle> [
				new Rectangle(0, 0, 50, 50),
				new Rectangle(0, 0, 20, 40),
				new Rectangle(0, 0, 30, 30),
				new Rectangle(0, 0, 20, 40),
				new Rectangle(0, 0, 10, 10),
				new Rectangle(0, 0, 10, 10)
			];
			var packer : SimplePacker = new SimplePacker();
			assertNull(packer.pack(rects, 100, 100, 10));
			
			//test if rectangles dont cross each other
			for each (var r1 : Rectangle in rects) 
			{
				for each (var r2 : Rectangle in rects) 
				{
					if (r1 != r2)
					{
						assertFalse(r1.contains(r2.x, r2.y));
						assertFalse(r1.contains(r2.x + r2.width, r2.y));
						assertFalse(r1.contains(r2.x, r2.y + r2.height));
						assertFalse(r1.contains(r2.x + r2.width, r2.y + r2.height));
					}
				}
			}
		}
	}
}