package gr.emmanuel.emBoxAS3.core{
import flash.text.Font;
import flash.text.TextFormat;

import gr.emmanuel.emBoxAS3.utils.Colors;



public class ATextFormat extends TextFormat    {
		
	
	public function ATextFormat(
		font:Font,
		size:Object = 12,
		color:Number = NaN,
		align:String = null,
		leftMargin:Object = null,
		rightMargin:Object = null,
		indent:Object = null,
		leading:Object = null
	){
		super(
			font.fontName,
			size,
			color ? color as uint : Colors.Color_AcL1,
			bold, italic,
			underline, url,
			target, align,
			leftMargin, rightMargin,
			indent, leading
		);
	}
}
}

