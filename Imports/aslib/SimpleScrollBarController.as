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
	public class SimpleScrollBarController extends ScrollBarController {
		//private var timer:Timer;
		
		//Constructor
		// areaMask: either a DisplayObject or Stage
		public function SimpleScrollBarController(area:Object, areaMask:Object,
											upMC:MovieClip, downMC:MovieClip, 
											sliderMC:MovieClip, trackMC:MovieClip)
		{
			super(area, areaMask, upMC, downMC, sliderMC, trackMC);
		}
	}
}