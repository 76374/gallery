package service
{
	import mx.controls.Image;
	
	import view.image.ImageView;

	//TODO: it is seemed to be unnecessary
	public class ImagesFactory
	{
		public function ImagesFactory()
		{
		}
		
		public function getImage(path : String) : ImageView
		{
			return new ImageView(path); 
		}
	}
}