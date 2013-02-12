package gr.emmanuel.interfaces {
    import flash.geom.Point;
	
	/**
	 * ...
	 * @author Emmanuel
	 */
	public interface INineGrid {
    /**
     * the offset ratio in  a point object
     * multiply this value to the width and height of the offseted element
     */
		function get nineGridPoint():Point
    
    /**
     *  a string representiting the desired offset
     */
		function get nineGrid():String
		function set nineGrid(value:String):void 
    
		/**
     * The calculated offset for the X value its 
		 * a negative value in pixels to add to child.x  in ui
		 */
		function get nineGridOffsetX():Number
    
		/**
     * The calculated offset for the Y value its 
		 * a negative value in pixels to add to child.y in ui
		 */
		function get nineGridOffsetY():Number 

	}
	
}