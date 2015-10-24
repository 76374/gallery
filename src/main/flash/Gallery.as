package
{	
	import flash.display.Sprite;
	
	import org.robotlegs.core.IContext;
	
	[SWF(backgroundColor="#FFFCFC", width="1024", height="768", frameRate="30")]
	public class Gallery extends Sprite
	{
		private var _context : IContext;
		
		public function Gallery()
		{
			_context = new GalleryContext(this);
		}
	}
}