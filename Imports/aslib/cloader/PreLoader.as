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

package Imports.aslib.cloader{
	import flash.display.MovieClip;
	import flash.events.*;
	
	public class PreLoader extends MovieClip{
		
		private var _mv:MovieClip;
		
		public function PreLoader(mv:MovieClip) {
			_mv = mv;
			_mv.loaderInfo.addEventListener( Event.INIT, initApplication );
			_mv.loaderInfo.addEventListener( ProgressEvent.PROGRESS, handleProgress );
			_mv.loaderInfo.addEventListener( Event.COMPLETE, handleComplete );
			
		}
		
		// Handle opening the file
		private function initApplication( event:Event ):void{
			_mv.setProgress(0);
		}
		
		// Handle load progress
		private function handleProgress( event:ProgressEvent ):void{
			var percent:Number = Math.round(event.bytesLoaded / event.bytesTotal * 100);
			_mv.setProgress(percent);
		}
		
		// Handle load complete
		private function handleComplete( event:Event ):void{
			dispatchEvent(new Event(Event.COMPLETE));
		}
	}
}