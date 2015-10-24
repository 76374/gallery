package view.animn
{
	import org.osflash.signals.ISignal;
	
	import view.IDisposable;

	internal interface IAnimatorBase extends IDisposable
	{
		function get completeSignal() : ISignal;
		function stop() : void;
		function get isInProgress() : Boolean;
	}
}