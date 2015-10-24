package view.animn
{
	import flash.display.DisplayObject;
	
	import org.osflash.signals.ISignal;

	public interface ISimpleAnimator extends IAnimatorBase
	{
		function animate(target : DisplayObject) : void;
	}
}