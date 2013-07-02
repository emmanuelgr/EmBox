package emBox.sprites.thumbs.buttons.twoSides{
	import emBox.sprites.icons.twoSideIcons.ATwoSideIcon;
	import emBox.sprites.textFields.*;

	public class RadioButtonLabel extends ARadioButton{

		public function RadioButtonLabel(
    icon:ATwoSideIcon,
    labelV:String = "Label",
    state:Boolean = false,
		nineGrid:String = null
    ){
			super(icon, state, nineGrid);
			var lbl:Label = new Label(labelV);
			lbl.x = width;
			addChild(lbl);
			icon.y = Math.round(Math.abs(lbl.height - icon.height) / 2);
		}

	}
}

