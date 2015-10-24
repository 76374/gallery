package view.image
{
	import com.greensock.TweenLite;
	import com.greensock.easing.Elastic;
	import com.greensock.easing.Expo;
	
	import flash.display.Loader;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.MouseEvent;
	import flash.net.URLRequest;
	import flash.utils.setTimeout;
	
	import org.osflash.signals.ISignal;
	import org.osflash.signals.Signal;
	
	import view.animn.IPositionAnimator;
	import view.animn.ISimpleAnimator;
	
	public class ImageView extends Loader
	{
		private var _showAnimator : ISimpleAnimator;
		private var _hideAnimator : ISimpleAnimator;
		private var _positionAnimator : IPositionAnimator;
		
		private var _loadCompleteSignal : ISignal;
		private var _loadFailSignal : ISignal;
		private var _clickedSignal : ISignal;
		
		private var _path : String;
		private var _loaded : Boolean;
		private var _inProgress : Boolean;
		
		public function ImageView(path : String)
		{
			super();
			
			_showAnimator = new DefaultShowAnimator();
			_hideAnimator = new DefaultHideAnimator();
			_positionAnimator = new DefaultPositionAnimator();
			
			_loadCompleteSignal = new Signal();
			_loadFailSignal = new Signal();
			_clickedSignal = new Signal();
			
			_path = path;
			load(new URLRequest(_path));
			_inProgress = true;
			
			visible = false;
			
			contentLoaderInfo.addEventListener(Event.COMPLETE, onLoadComplete);
			contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, onIOError);
		}
		
		public function get inProgress() : Boolean
		{
			return _inProgress;			
		}
		
		public function get loaded() : Boolean
		{
			return _loaded;			
		}
		
		public function get path() : String 
		{
			return _path;
		}
		
		public function show() : void
		{
			if (_showAnimator.isInProgress || (visible && alpha == 1))
			{
				return;
			}
			if (_hideAnimator.isInProgress)
			{
				_hideAnimator.stop();
			}
			alpha = 0;
			visible = true;
			_showAnimator.animate(this);
		}
		
		public function hide() : void
		{
			if (_hideAnimator.isInProgress || !visible)
			{
				return;
			}
			if (alpha == 0)
			{
				visible = false;
				return;
			}
			if (_showAnimator.isInProgress)
			{
				_showAnimator.stop();
			}
			_hideAnimator.animate(this);
		}
		
		public function move(x : Number, y : Number) : void
		{
			if (this.x == x && this.y == y)
			{
				return;
			}
			_positionAnimator.animate(this, x, y);
		}
		
		public function setShowAnimator(animator : ISimpleAnimator) : void
		{
			if (animator)
			{	
				_showAnimator = animator;
			}
		}
		
		public function setHideAnimator(animator : ISimpleAnimator) : void
		{
			if (animator)
			{	
				_hideAnimator = animator;
			}
		}
		
		public function setPositionAnimator(animator : IPositionAnimator) : void
		{
			if (animator)
			{	
				_positionAnimator = animator;
			}
		}
		
		public function get loadCompleteSignal() : ISignal
		{
			return _loadCompleteSignal;
		}
		
		public function get loadFailSignal() : ISignal
		{
			return _loadFailSignal;
		}
		
		public function get clickedSignal() : ISignal
		{
			return _clickedSignal;
		}
		
		public function get hideCompleteSignal() : ISignal
		{
			return _hideAnimator.completeSignal;
		}//TODO: add signals for other animations
		
		public function dispose() : void
		{
			if (_inProgress)
			{
				removeLoadListeners();
				close();
			}
			else
			{
				removeEventListener(MouseEvent.CLICK, onMouseClick);
				unload();
			}
			_showAnimator.dispose();
			_showAnimator = null;
			_hideAnimator.dispose();
			_hideAnimator = null;
			_positionAnimator.dispose();
			_positionAnimator = null;
			_loadCompleteSignal.removeAll();
			_loadCompleteSignal = null;
			_loadFailSignal.removeAll();
			_loadFailSignal = null;
			_clickedSignal.removeAll();
			_clickedSignal = null;
		}
		
		//
		
		private function onLoadComplete(e : Event) : void
		{
			_loaded = true;
			_inProgress = false;
			removeLoadListeners();
			
			addEventListener(MouseEvent.CLICK, onMouseClick);
			
			_loadCompleteSignal.dispatch();
		}
		
		private function onIOError(e : Event) : void
		{
			_inProgress = false;
			removeLoadListeners();
			trace("[ERROR] failed to load image");
			
			_loadFailSignal.dispatch();
		}
		
		private function onMouseClick(e : MouseEvent) : void
		{
			if (_loaded && !_showAnimator.isInProgress && !_hideAnimator.isInProgress && !_positionAnimator.isInProgress)
			{
				_clickedSignal.dispatch();
			}
		}
		
		//
		
		private function removeLoadListeners() : void
		{
			contentLoaderInfo.removeEventListener(Event.COMPLETE, onLoadComplete);
			contentLoaderInfo.removeEventListener(IOErrorEvent.IO_ERROR, onIOError);
		}
	}
}

import com.greensock.TweenLite;
import com.greensock.easing.Elastic;
import com.greensock.easing.Expo;

import flash.display.DisplayObject;

import org.osflash.signals.ISignal;
import org.osflash.signals.Signal;

import view.animn.IPositionAnimator;
import view.animn.ISimpleAnimator;

class AnimatorBase 
{
	protected  var _tween : TweenLite;
	protected var _completeSignal : ISignal;
	
	public function AnimatorBase()
	{
		_completeSignal = new Signal;
	}
	
	public function get completeSignal() : ISignal
	{
		_completeSignal.removeAll();
		return _completeSignal;
	}
	
	public function stop() : void
	{
		if (_tween)
		{
			_tween.kill();
			_tween = null;
		}
	}
	
	public function get isInProgress() : Boolean
	{
		return _tween != null;
	}
	
	public function dispose() : void
	{
		stop();
		_completeSignal = null;
	}
	
	protected function onComplete() : void
	{
		_tween = null;
		_completeSignal.dispatch();
	}
}

class DefaultShowAnimator extends AnimatorBase implements ISimpleAnimator
{
	public static const SHOW_TIME : Number = 0.7;
	
	public function animate(target : DisplayObject) : void
	{	
		_tween = TweenLite.to(target, SHOW_TIME, {alpha : 1, ease : Expo.easeOut,  onComplete : onComplete});
	}
}

class DefaultHideAnimator extends AnimatorBase implements ISimpleAnimator
{
	public static const HIDE_TIME : Number = 0.7;
	
	public function animate(target : DisplayObject) : void
	{	
		_tween = TweenLite.to(target, HIDE_TIME, {alpha : 0, ease : Expo.easeOut, onComplete : onComplete});
	}
}

class DefaultPositionAnimator extends AnimatorBase implements IPositionAnimator
{
	public static const MOVE_TIME : Number = 1;
	
	public function animate(target : DisplayObject, x : Number, y : Number) : void
	{	
		_tween = TweenLite.to(target, MOVE_TIME, {x : x, y : y, ease : Elastic.easeOut, onComplete : onComplete});
	}
}