package view.animn
{
	import flash.display.DisplayObject;
	
	import org.osflash.signals.ISignal;

	public interface IPositionAnimator extends IAnimatorBase
	{
		function animate(target : DisplayObject, x : Number, y : Number) : void;
	}
}