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
 
package Imports.aslib.util {
	public class StringUtilities {
		public static function isWhitespace( ch:String):Boolean {
			return ch == '\r' ||
					ch == '\n' ||
					ch == '\f' ||
					ch == '\t' ||
					ch == ' ';
		}

		public static function trim( original:String ):String {
			var characters:Array = original.split( "" );
			for (var i:int = 0; i < characters.length; i++) {
				if (isWhitespace( characters[i] )) {
					characters.splice( i,1 );
					i--;
				} else {
					break;
				}
			}
			for (i = characters.length - 1; i >= 0; i--) {
				if (isWhitespace( characters[i] )) {
					characters.splice(i,1);
				} else {
					break;
				}
			}
			return characters.join("");
		}
	}
}