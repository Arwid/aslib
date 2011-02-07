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
	
	public class ScrollTrack extends Sprite {

		// the draggable object
		private var _navSliderMC:MovieClip;
		// the track on which sits the slider
		private var _navTrackMC:MovieClip;

		// Center drag property
		private var _dragCenter:Boolean=false;
		// Drag offset property. Used if drag center.
		private var _dragOffset:Number=0;

		private var _percentage:Number=0;
		private var _percVisible:Number=0.2;

		//Constructor
		//retain references of both slider and track
		public function ScrollTrack(sliderMC:MovieClip,trackMC:MovieClip) {
			setupNav(sliderMC,trackMC);
			positionNavs();
			update();
		}
		//Setup navigation buttons. Add event listeners.
		private function setupNav(sliderMC:MovieClip,trackMC:MovieClip):void {
			_navSliderMC=sliderMC;
			_navTrackMC=trackMC;

			_navSliderMC.addEventListener(MouseEvent.MOUSE_DOWN,dragSliderListener);
			_navSliderMC.stage.addEventListener(MouseEvent.MOUSE_UP,noAction);
			_navTrackMC.addEventListener(MouseEvent.MOUSE_DOWN,scrollTrackListener);
		}
		private function noAction(evt:MouseEvent) {
			_navSliderMC.setDraggingState(false);
			_navSliderMC.stopDrag();
			_navSliderMC.stage.removeEventListener(MouseEvent.MOUSE_MOVE,dragSliderListenerMove);
		}
		/*
		 Scroll Track Listener
		 */
		private function scrollTrackListener(evt:MouseEvent):void {
			var perc:Number=evt.localY * _navTrackMC.scaleY / _navTrackMC.height;
			perc=Math.max(0,perc);
			perc=Math.min(1,perc);
			percentage=perc;
			update();

			dispatchEvent(new ScrollBarEvent(ScrollBarEvent.SCROLL_TRACK));
		}
		/*
		 Start Drag Slider Listener
		 */
		private function dragSliderListener(evt:MouseEvent) {
			var rect:Rectangle=new Rectangle(this.x,this.y,0,this.height - _navSliderMC.height);
			_navSliderMC.startDrag(false,rect);

			_dragOffset=_navSliderMC.mouseY * _navSliderMC.scaleY;

			_navSliderMC.stage.addEventListener(MouseEvent.MOUSE_MOVE,dragSliderListenerMove);

			dispatchEvent(new ScrollBarEvent(ScrollBarEvent.SCROLL_DRAG));
		}
		/*
		 Drag Slider Listener
		 */
		private function dragSliderListenerMove(evt:MouseEvent) {
			_navSliderMC.setDraggingState(true);
			var center:Number=_dragOffset;
			var perc:Number=_navTrackMC.mouseY * _navTrackMC.scaleY - center / _navTrackMC.height - _navSliderMC.height;
			perc=Math.max(0,perc);
			perc=Math.min(1,perc);
			percentage=perc;

			dispatchEvent(new ScrollBarEvent(ScrollBarEvent.SCROLL_DRAG));

			evt.updateAfterEvent();
		}
		/*
		 Position navs
		 */
		private function positionNavs():void {
			trace("positioning navs");
			_navSliderMC.x=_navTrackMC.x;
			_navSliderMC.y=_navTrackMC.top;
		}
		/*
		 Update slider position & height according to percentage scrolled
		 @param percVisible: between 0 and 1
		 */
		public function update():void {
			trace("updating slider:");
			var percRounded:int=Math.round(_percentage * 100);
			_navSliderMC.setHeight(int(_percVisible * this.height));
			_navSliderMC.y=_navTrackMC.top + int(this.height - this.height * percRounded / 100);
		}
		public function positionButtons(upBtn:MovieClip,downBtn:MovieClip) {
			this.y=this.y + upBtn.height;
			this.height=this.height - upBtn.height - downBtn.height;
			positionNavs();
			update();

			upBtn.x=downBtn.x=_navTrackMC.x;
			upBtn.y=_navTrackMC.top;
			downBtn.y=_navTrackMC.bottom;
		}
		// sets/gets the percentage scrolled

		public function set percentage(targ:Number):void {
			_percentage=targ;
		}
		public function get percentage():Number {
			return _percentage;
		}
		// sets/gets the percentage scrolled

		public function set percVisible(targ:Number):void {
			_percVisible=targ;
		}
		public function get percVisible():Number {
			return _percVisible;
		}
		// sets/gets y

		public override function set y(targ:Number):void {
			_navTrackMC.y=targ;
		}
		public override function get y():Number {
			return _navTrackMC.y;
		}
		// sets/gets x

		public override function set x(targ:Number):void {
			_navTrackMC.x=targ;
		}
		public override function get x():Number {
			return _navTrackMC.x;
		}
		// sets/gets height

		public override function set height(targ:Number):void {
			_navTrackMC.height=targ;
		}
		public override function get height():Number {
			return _navTrackMC.height;
		}
		// sets/gets width

		public override function set width(targ:Number):void {
			_navTrackMC.width=targ;
		}
		public override function get width():Number {
			return _navTrackMC.width;
		}
		// sets/gets width

		public override function set visible(targ:Boolean):void {
			_navSliderMC.visible=_navTrackMC.visible=targ;
		}
		public override function get visible():Boolean {
			return _navTrackMC.visible;
		}
	}
}