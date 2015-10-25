package model
{
	import org.flexunit.assertThat;
	import org.flexunit.asserts.assertEquals;
	import org.flexunit.asserts.assertFalse;
	import org.flexunit.asserts.assertNotNull;
	import org.flexunit.asserts.assertNull;
	import org.flexunit.asserts.assertTrue;

	public class AppModelTest
	{	
		private var _appModel : AppModel;
		
		[Before]
		public function setUp() : void
		{
			_appModel = new AppModel();
		}
		
		[Test]
		public function testPaths() : void 
		{
			_appModel.pushImagePath("path1");
			_appModel.pushImagePath("path2");
			
			assertEquals(_appModel.getNextImagePath(), "path1");
			assertEquals(_appModel.getNextImagePath(), "path2");
			assertNull(_appModel.getNextImagePath());
			
			_appModel.setLoopedPath(true);
			assertEquals(_appModel.getNextImagePath(), "path1");
			assertEquals(_appModel.getNextImagePath(), "path2");
			assertEquals(_appModel.getNextImagePath(), "path1");
			
			_appModel.resetPathCount();
			assertEquals(_appModel.getNextImagePath(), "path1");
		}
		
		[Test]
		public function testImageQueue() : void
		{
			assertFalse(_appModel.hasImagesInQueue());
			
			_appModel.addImageToQueue(new ImageData("id1", 1, 1));
			_appModel.addImageToQueue(new ImageData("id2", 2, 2));
			
			assertTrue(_appModel.hasImagesInQueue());
			var imageData : ImageData = _appModel.shiftImageFromQueue();
			assertNotNull(imageData);
			if (imageData)
			{
				assertEquals(imageData.id, "id1");
			}
			assertTrue(_appModel.hasImagesInQueue());
			
			imageData = _appModel.shiftImageFromQueue();
			assertNotNull(imageData);
			if (imageData)
			{
				assertEquals(imageData.id, "id2");
			}
			assertFalse(_appModel.hasImagesInQueue());
		}
		
		[After]
		public function tearDown() : void
		{
			_appModel = null;
		}		
	}
}