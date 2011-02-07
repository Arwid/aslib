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
 
package Imports.aslib.events
{
	import flash.events.Event;
	
	public class ScrollBarEvent extends Event
	{
		public static const SCROLL_DOWN:String = "onDown";
		public static const SCROLL_UP:String = "onUp";
		public static const SCROLL_DRAG:String = "drag";
		public static const SCROLL_TRACK_UP:String = "trackUp";
		public static const SCROLL_TRACK_DOWN:String = "trackDown";
		public static const SCROLL_TRACK:String = "track";
		public static const SCROLL_WHEEL:String = "wheel";
       
        public function ScrollBarEvent(dir:String) {
            super(dir);
        }
    }
}