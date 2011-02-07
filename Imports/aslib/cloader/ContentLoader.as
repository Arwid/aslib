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

/* ContentLoader.as - Part of cloader package */

package Imports.aslib.cloader{
	import flash.display.*;
	import flash.text.*;
	import flash.net.URLRequest;
	import flash.events.*;
	
	public class ContentLoader extends MovieClip{
		
		private var _loader:Loader;
		private var _loaderStatus:TextField;
		
		private var progressHandler:Function;
		private var completeHandler:Function;
		
		private var _mv:Sprite;
		
		public function ContentLoader(mv:Sprite, url:String = ""){
			_loader = new Loader();
			_mv = mv;
			addChild( _loader );
			
			_loader.contentLoaderInfo.addEventListener( Event.OPEN, handleOpen );
			_loader.contentLoaderInfo.addEventListener( ProgressEvent.PROGRESS, handleProgress );
			_loader.contentLoaderInfo.addEventListener( Event.COMPLETE, handleComplete );
			//_loader.contentLoaderInfo.addEventListener( Event.INIT, handleInit );
			
			if (url != "")
				this.Load(url)
		}
		
		private function Load(url:String):void
		{
			_loader.load( new URLRequest( url ) );
		}
		
		// Handle opening the file
		private function handleOpen( event:Event ):void{
			_loaderStatus = new TextField();
			_loaderStatus.width = 100;
			_loaderStatus.text = "Loading: 0%";
			trace("percent is open : " + _mv.getProgress());
			_mv.setProgress(0);
		}
		
		// Handle load progress
		private function handleProgress( event:ProgressEvent ):void{
			var percent:Number = Math.round(event.bytesLoaded / event.bytesTotal * 100);
			_loaderStatus.text = "Loading: " + percent + "%";
			trace("loading: " + _loaderStatus.text);
			trace("progress is : " + _mv.getProgress());
			_mv.setProgress(percent);
		}
		
		// Handle load complete
		private function handleComplete( event:Event ):void{
			//removeChild( _loaderStatus );
			dispatchEvent(new Event(Event.COMPLETE));
			_loaderStatus = null;
		}
	}
}