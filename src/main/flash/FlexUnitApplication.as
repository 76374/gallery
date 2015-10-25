package
{
	import Array;
	
	import flash.display.Sprite;
	
	import flexunit.flexui.FlexUnitTestRunnerUIAS;
	
	import model.AppModelTest;
	import model.ObjectsLocationModelTest;
	import model.SimplePackerTest;
	
	public class FlexUnitApplication extends Sprite
	{
		public function FlexUnitApplication()
		{
			onCreationComplete();
		}
		
		private function onCreationComplete():void
		{
			var testRunner:FlexUnitTestRunnerUIAS=new FlexUnitTestRunnerUIAS();
			testRunner.portNumber=8765; 
			this.addChild(testRunner); 
			testRunner.runWithFlexUnit4Runner(currentRunTestSuite(), "gallery");
		}
		
		public function currentRunTestSuite():Array
		{
			var testsToRun:Array = new Array();
			testsToRun.push(model.AppModelTest);
			testsToRun.push(model.ObjectsLocationModelTest);
			testsToRun.push(model.SimplePackerTest);
			return testsToRun;
		}
	}
}