package emBox.sprites.thumbs.buttons.twoSides{
    import flash.display.DisplayObject;
    import flash.display.StageDisplayState;
    import flash.events.MouseEvent;
    import emBox.commands.CTweenLiteInPoseOut;
    import emBox.commands.vfxs.VFXScale;
    import emBox.sprites.icons.twoSideIcons.ATwoSideIcon;
    import emBox.sprites.icons.twoSideIcons.FullNormalScreenIcon;
    import emBox.core.NineGrid;
    import emBox.shapes.FullScreen;

	public class FullScreenButton extends ATwoSideButton    {
		private var aTwoSideIcon:ATwoSideIcon;

		public function FullScreenButton(
    state:Boolean = false,
    color:Number = NaN,
    colorIn:Number = NaN,
    transparency:Number = 1,
		nineGrid:String = null
    ){
			aTwoSideIcon =   new FullNormalScreenIcon(color, colorIn);
			super(aTwoSideIcon, state);
		}

		override protected function onClick(event:MouseEvent  = null) : void        {
			super.onClick(event);
			if (stage.displayState == StageDisplayState.NORMAL) 	stage.displayState = StageDisplayState.FULL_SCREEN;
			else	stage.displayState = StageDisplayState.NORMAL;
		}

	}
}

