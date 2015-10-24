package view.image
{
	import flash.geom.Point;
	
	import model.ObjectsLocationModel;
	import model.event.LocationEvent;
	
	import org.robotlegs.mvcs.Mediator;
	import model.ImageData;
	
	public class ImageMediator extends Mediator
	{
		[Inject]
		public var imageView : ImageView;
		
		[Inject]
		public var objectLocation : ObjectsLocationModel;
		
		public override function onRegister() : void
		{
			addContextListener(LocationEvent.UPDATE, onLocationUpdated, LocationEvent);
			
			imageView.loadCompleteSignal.add(onLoadComplete);
			imageView.loadFailSignal.add(onLoadFail);
			imageView.clickedSignal.add(onImageClicked);
			imageView.hideCompleteSignal.add(onImageHided);
		}
		
		//
		
		private function onLocationUpdated(e : LocationEvent) : void
		{
			var pos : Point = objectLocation.getPosition(id);
			if (pos)
			{
				imageView.move(pos.x, pos.y);
				imageView.show();
			}
			else
			{
				imageView.visible = false;
			}
		}
		
		//
		
		private function onLoadComplete() : void
		{
			dispatch(new ImageEvent(ImageEvent.LOADED, getImageProps()));
		}
		
		private function onLoadFail() : void
		{
			dispatch(new ImageEvent(ImageEvent.LOAD_FAILED, getImageProps()));
			removeView();
		}
		
		private function onImageClicked():void
		{
			imageView.hide();
			dispatch(new ImageEvent(ImageEvent.HIDING, getImageProps()));
		}
		
		private function onImageHided() : void
		{
			dispatch(new ImageEvent(ImageEvent.REMOVED, getImageProps()));
			removeView();
		}
		
		//
		
		private function getImageProps() : ImageData
		{
			return new ImageData(id, imageView.width, imageView.height);
		}
		
		private function get id() : String
		{
			return imageView.path;
		}
		
		private function removeView() : void
		{
			imageView.dispose();
			imageView.parent.removeChild(imageView);
			imageView = null;
		}
	}
}