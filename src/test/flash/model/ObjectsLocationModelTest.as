package model
{
	import flash.events.EventDispatcher;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	
	import model.packer.SimplePacker;
	
	import org.flexunit.asserts.assertFalse;
	import org.flexunit.asserts.assertNotNull;
	import org.flexunit.asserts.assertNull;
	import org.flexunit.asserts.assertTrue;

	public class ObjectsLocationModelTest
	{
		private var _locations : ObjectsLocationModel;
		
		[Before]
		public function setUp() : void
		{
			_locations = new ObjectsLocationModel();
			_locations.init(new SimplePacker, 100, 100, 10);
			_locations.eventDispatcher = new EventDispatcher();
		}
		
		[Test]
		public function testObjectsFit() : void
		{
			assertTrue(_locations.addObject("id1", 40, 40),	_locations.addObject("id2", 40, 40));
			assertFalse(_locations.addObject("id3", 80, 80));//too big to fit
			assertTrue(_locations.contain("id1"), _locations.contain("id2"));
			assertFalse(_locations.contain("id3"));
			
			_locations.remove("id1");
			assertFalse(_locations.contain("id1"));
			assertNull(_locations.getPosition("id1"));
			
			assertNotNull(_locations.getPosition("id2"));
		}
		
		[After]
		public function tearDown() : void
		{
			_locations = null;
		}
	}
}