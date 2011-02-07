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
	import flash.events.MouseEvent;
	import flash.events.Event;
	import Imports.ButtonController;
	
	public class PageLink extends ButtonController {
		
		private var _button:MovieClip;
		private var _pageTarget:MovieClip;
		private var _frameLabel:String;
		
		public function PageLink(_button:MovieClip, _pageTarget:MovieClip, _frameLabel="1")
		{
			this._button = _button;
			this._pageTarget = _pageTarget;
			this._frameLabel = _frameLabel;
			Setup();
		}
		
		private function Setup():void 
		{
			_button.addEventListener(MouseEvent.MOUSE_DOWN, MouseEventHandler);
		}
		
		protected override function MouseEventHandler(evt:MouseEvent):void
		{
			if (_isEnabled && evt.type == MouseEvent.MOUSE_DOWN)
			{
				_pageTarget.gotoAndPlay(_frameLabel);
			}
		}
	}	
}

