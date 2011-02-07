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
	import Imports.ScrollBarController;
	import Imports.events.ScrollBarEvent;

	//import Math;
	public class SmoothScrollBarController extends ScrollBarController {

		//Scroll speed
		private var _easeAmount:int = 4;

		//Vertical Progress Y
		private var _delayedProgressVertical:Number = 0;


		private var _emptyClip:MovieClip = new MovieClip();

		public function SmoothScrollBarController(area:Object, areaMask:Object) {
			super(area, areaMask);
		}
		private function scrollTrackListener(evt:MouseEvent):void {

			this.currentAction = ACTIONS.SCROLL_TRACK;
			if (!_emptyClip.hasEventListener(Event.ENTER_FRAME)) {
				_emptyClip.addEventListener(Event.ENTER_FRAME, smoothScrollingHandler);
			}
			//evt.updateAfterEvent();
		}
		
		public override function setupTrack(track:ScrollTrack):void
		{
			track.addEventListener(ScrollBarEvent.SCROLL_DRAG,scrollDragListener);
			function scrollDragListener(event:ScrollBarEvent)
			{
				currentAction = ACTIONS.SCROLL_DRAG;
				_delayedProgressVertical = track.percentage * scrollableHeight;
				
				if (!_emptyClip.hasEventListener(Event.ENTER_FRAME)) {
					_emptyClip.addEventListener(Event.ENTER_FRAME, smoothScrollingHandler);
				}
				//Update();
			}
			_track = track;
		}
		
		protected override function scrollBy(step:Number) {
			trace("scrollby:"+step);
			currentAction = step < 0 ? ACTIONS.SCROLL_UP : ACTIONS.SCROLL_DOWN;

			_delayedProgressVertical = Math.max(_delayedProgressVertical + step,0);
			trace("dasdfasfd:"+_delayedProgressVertical+":"+scrollableHeight);
			_delayedProgressVertical = Math.min(_delayedProgressVertical,scrollableHeight);

			if (!_emptyClip.hasEventListener(Event.ENTER_FRAME)) {
				_emptyClip.addEventListener(Event.ENTER_FRAME, smoothScrollingHandler);
			}
			//Update();
		}
		
		public override function scrollToTop():void
		{
			currentAction = ACTIONS.NONE;
			_progressVertical = 0;
			_delayedProgressVertical = 0;
			if (!_emptyClip.hasEventListener(Event.ENTER_FRAME)) {
				_emptyClip.addEventListener(Event.ENTER_FRAME, smoothScrollingHandler);
			}

		}
		
		private function smoothScrollingHandler(evt:Event) {
			var updateSlider:Boolean = true;
			switch(currentAction) {
				case ACTIONS.SCROLL_UP:
					scrollBy(-step);
					break;
				case ACTIONS.SCROLL_DOWN:
					scrollBy(step);
					break;
				case ACTIONS.SCROLL_DRAG:
					updateSlider = false;
					break;
				case ACTIONS.SCROLL_DRAG_NONE:
					updateSlider = false;
				case ACTIONS.NONE:
					if (Math.abs(_delayedProgressVertical - _progressVertical) < 0.5) {
						currentAction = ACTIONS.NONE;
						_emptyClip.removeEventListener(Event.ENTER_FRAME, smoothScrollingHandler);
					}
					break;
			}
			
			_progressVertical += (_delayedProgressVertical - _progressVertical)/_easeAmount;
			var percVerticalReal:Number = Number(_progressVertical / scrollableHeight * 100);
			var percVertical:Number = Number(_delayedProgressVertical / scrollableHeight * 100);
			Update(updateSlider);
			//updateArea(percVerticalReal);
		}
		
		// sets the amout of ease to use
       
        public function set ease(e:int):void {
            _easeAmount = (e <=0 ) ? 1 : Math.ceil(e);
        }
       
        public function get ease():int {
			return _easeAmount;
        }
	}
}