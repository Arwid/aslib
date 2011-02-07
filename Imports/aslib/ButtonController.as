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
	
	public class ButtonController {
		
		private var _button:MovieClip;
		private var _isEnabled:Boolean = true;
		private var _Id:int = -1;
		
		public function ButtonController(_button:MovieClip)
		{
			this._button = _button;
			Setup();
		}
		
		private function Setup():void 
		{
			_button.hotspot.alpha = 0;
			
			_button.hotspot.addEventListener(MouseEvent.MOUSE_OVER, MouseEventHandler);
			_button.hotspot.addEventListener(MouseEvent.MOUSE_DOWN, MouseEventHandler);
			_button.hotspot.addEventListener(MouseEvent.MOUSE_OUT, MouseEventHandler);
			_button.hotspot.addEventListener(MouseEvent.MOUSE_UP, MouseEventHandler);
			
			setState(MouseEvent.MOUSE_OUT);
		}
		
		public function set Enabled(_isEnabled:Boolean):void
		{
			this._isEnabled = _isEnabled;
		}
		
		public function get Enabled():Boolean
		{
			return this._isEnabled;
		}
		
		protected function MouseEventHandler(evt:MouseEvent):void
		{
			if (_isEnabled)
			{
				setState(evt.type);
			}
			else
			{
				_button.gotoAndStop("disabled");
			}
		}
		
		private function setState(type:String):void
		{
			//Handle mouse event
			if (type == MouseEvent.MOUSE_OVER)
			{
				_button.gotoAndStop("over");
			}
			else if (type == MouseEvent.MOUSE_DOWN)
			{
				_button.gotoAndStop("down");
			}
			else
			{
				_button.gotoAndStop("up");
			}
		}
       
        public function set ID(id:int):void {
            _Id = id;
        }
       
        public function get ID():int {
			return _Id;
        }
	}	
}

