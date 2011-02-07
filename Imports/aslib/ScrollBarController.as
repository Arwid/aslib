/******************************************************************************
 *   aslib
 *   Copyright (C) 2011  Arwid Bancewicz <arwid@arwid.ca>
 *
 *   This program is free software: you can redistribute it and/or modify
 *   it under the terms of the GNU General Public License as published by
 *   the Free Software Foundation, either version 3 of the License, or
 *   (at your option) any later version.
 *
 *   This program is distributed in the hope that it will be useful,
 *   but WITHOUT ANY WARRANTY; without even the implied warranty of
 *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 *   GNU General Public License for more details.
 *
 *   You should have received a copy of the GNU General Public License
 *   along with this program.  If not, see <http://www.gnu.org/licenses/>.
 *****************************************************************************/
 
package Imports.aslib {		

	import flash.display.MovieClip;
	import flash.display.Stage;
	import flash.geom.Rectangle;
    import flash.display.DisplayObjectContainer;
	import flash.events.MouseEvent;
	import flash.events.Event;
    import flash.display.Sprite;
    import Imports.events.ScrollBarEvent;
    import Imports.ScrollTrack;
	
	
	//import Math;
	public class ScrollBarController extends Sprite {
		
		//Scroll area
		protected var _contentMask:Object;
		protected var _content:Object;
		protected var _contentMaskHeight:Number;
		
		//Vertical Progress Y
		protected var _progressVertical:Number = 0;

		//Vertical Steps
		protected var _step:Number = 10;
		protected var _stepWheel:Number = 10;
		
		//Always Show
		protected var _alwaysShow:Boolean = false;
		
		//Actions
		protected var ACTIONS:Object = {NONE:0,SCROLL_UP:1,SCROLL_DOWN:2,SCROLL_DRAG:3,SCROLL_DRAG_NONE:4,SCROLL_TRACK:5,SCROLL_WHEEL:6};
		protected var currentAction:int = ACTIONS.NONE;
		
		protected var scrollableHeight:int = 0;
		
		protected var _track:ScrollTrack;
		protected var _up:MovieClip;
		protected var _down:MovieClip;
		
		//private var timer:Timer;
		
		//Constructor
		// areaMask: either a DisplayObject or Stage
		public function ScrollBarController(area:Object, areaMask:Object)
		{
			setupArea(area,areaMask);
			Update();
		}
		
		//Setup area vars
		private function setupArea(area:Object, areaMask:Object, useMouseWheel:Boolean = true)
		{
			this._content = area;
			this._contentMask = areaMask;
			
			if (!(areaMask is Stage))this._content.x = this._contentMask.x;
			this._content.y = this._contentMask.y;
			try {
				this._content.setWidth(this._contentMask.width);
			} catch(e:Error) {
			}
			
			if (useMouseWheel) this._content.addEventListener(MouseEvent.MOUSE_WHEEL, mouseWheelListener);
		}
		
		public function setupTrack(track:ScrollTrack):void
		{
			track.addEventListener(ScrollBarEvent.SCROLL_DRAG,scrollDragListener);
			function scrollDragListener(event:ScrollBarEvent)
			{
				_progressVertical = track.percentage * scrollableHeight;
				Update();
			}
			_track = track;
		}
		
		//Setup navigation buttons
		public function setupButtons(upMC:MovieClip, downMC:MovieClip):void
		{
			//Add event listeners
			upMC.addEventListener(MouseEvent.MOUSE_DOWN,scrollUpListener);
			downMC.addEventListener(MouseEvent.MOUSE_DOWN,scrollDownListener);
			
			upMC.stage.addEventListener(MouseEvent.MOUSE_UP,noAction);
			
			function scrollUpListener(evt:MouseEvent)
			{
				scrollBy(-step);
			}
			
			function scrollDownListener(evt:MouseEvent)
			{
				scrollBy(step);
			}
			
			_up = upMC;
			_down = downMC;
		}
		
		       
        private function mouseWheelListener(me:MouseEvent):void {
			trace("mouseWheelListener:"+ me);
			var delta:Number = me.delta;
			trace("Deltaaaaaaaaaaaaaa:"+delta);
			scrollBy(-delta*_stepWheel);
			dispatchEvent(new ScrollBarEvent(ScrollBarEvent.SCROLL_WHEEL));
			currentAction = ACTIONS.NONE;
		}
		
		protected function noAction(evt:MouseEvent)
		{
			trace("noAction() - " + this.currentAction );
			
			if (this.currentAction == ACTIONS.SCROLL_DRAG)
				this.currentAction = ACTIONS.SCROLL_DRAG_NONE;
			else
				this.currentAction = ACTIONS.NONE;
		}
		
		private function scrollUpListener(evt:MouseEvent)
		{
			
			trace("scrollUpListener(..)");
			scrollUp();
            dispatchEvent(new ScrollBarEvent(ScrollBarEvent.SCROLL_UP));
		}
		
		private function scrollDownListener(evt:MouseEvent)
		{
			trace("scrollDownListener(..)");
			scrollDown();
            dispatchEvent(new ScrollBarEvent(ScrollBarEvent.SCROLL_DOWN));
		}
		
		public function scrollUp()
		{
			scrollBy(-_step);
		}
		public function scrollDown()
		{
			scrollBy(_step);
		}
		
		protected function scrollBy(step:Number)
		{
			trace("scrolling by:"+step);
			currentAction = ACTIONS.NONE;
			_progressVertical = Math.max(_progressVertical + step,0);
			_progressVertical = Math.min(_progressVertical,scrollableHeight);
			//var percVertical:Number = Number(_progressVertical / scrollableHeight * 100);
			Update();
		}
		
		public function Update(updateTrack:Boolean = true):Boolean
		{
			trace("Update()");
			_contentMaskHeight =_contentMask is Stage ? _contentMask.stageHeight :  _contentMask.height;
			
			scrollableHeight = Math.ceil(_content.height-_contentMaskHeight);
			scrollableHeight = Math.max(scrollableHeight,0);
			trace("height:"+scrollableHeight+":"+_content.height+":"+_contentMaskHeight);
			
			var percVertical:Number = Number(_progressVertical / scrollableHeight * 100);
			trace("percV:"+percVertical);
			if (_contentMask is Stage)
			{
				if (_content.height >  _contentMaskHeight)
				{
					if (_content.height + _content.y < _contentMaskHeight)
					{
						var diff:Number = _content.height + _content.y - _contentMaskHeight;
						var perc:Number = ( _contentMask.y-(_content.y-diff))*100.0 / scrollableHeight;
						percVertical = perc;
						_progressVertical = percVertical * scrollableHeight / 100;
					}
				}else{
					percVertical = 0;
					_progressVertical = 0;
				}
			}
			updateArea(percVertical);
			trace("track:"+_track);
			if (updateTrack && _track != null) {
				_track.percentage = percVertical / 100;
				var percVisible:Number = _contentMaskHeight/_content.height;
				percVisible = Math.min(percVisible,1.0);
				percVisible = Math.max(percVisible,0.0);
				_track.percVisible = percVisible;
				_track.update();
				trace("updated track");
			}
			trace(_content.height +":"+  _contentMaskHeight);
			//if (_alwaysShow) {
				if (_up != null) _up.visible = (_content.height > _contentMaskHeight) ? true : _alwaysShow;
				if (_down != null) _down.visible = (_content.height > _contentMaskHeight) ? true : _alwaysShow;
				if (_track != null) _track.visible = (_content.height > _contentMaskHeight) ? true : _alwaysShow;
			//}
			return (_content.height >  _contentMaskHeight);
		}
		
		protected function updateArea(percVertical:Number):void
		{
			//trace("ScrollBarController updateArea(..,..)");
			var roundedPerc:int = Math.round(percVertical);
			var scrollToPos:Number = Number(scrollableHeight * roundedPerc / 100);
			_content.y = _contentMask.y - scrollToPos;
		}
		
		public function updateNavs():void
		{
			setupArea(_content,_contentMask);
			Update();
		}
		
		public function scrollToTop():void
		{
			currentAction = ACTIONS.NONE;
			_progressVertical = 0;
			Update();
		}
		       
        // sets the display object that will be scrolled
       
        public function set scrollTarget(targ:Object):void {
            _content = targ;
            //adjustSize();
        }
       
        public function get scrollTarget():Object {
            return _content;
        }
		
		// sets the display object that will be scrolled
       
        public function set step(targ:Number):void {
            _step = targ;
            //adjustSize();
        }
       
        public function get step():Number {
            return _step;
        }
		
		// sets the display object that will be scrolled
       
        public function set alwaysShow(targ:Boolean):void {
            _alwaysShow = targ;
            //adjustSize();
        }
       
        public function get alwaysShow():Boolean {
            return _alwaysShow;
        }
		
		public function set stepWheel(targ:Number):void {
            _stepWheel = targ;
            //adjustSize();
        }
       
        public function get stepWheel():Number {
            return _stepWheel;
        }
	}
}