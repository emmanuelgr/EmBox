package emBox.actions{
  import flash.display.DisplayObjectContainer;
  import flash.display.InteractiveObject;
  import flash.display.Sprite;
  import flash.events.Event;
  import flash.events.MouseEvent;

public class MouseOverOutable extends OnOffStage{
  public var icon:InteractiveObject ;
  public var onOver:Function ;
  public var onOut:Function ;

  public function MouseOverOutable(
  icon:InteractiveObject ,
  onOver:Function = null,
  onOut:Function = null
  ){
    this.icon = icon;
    this.onOver = onOver;
    this.onOut = onOut;
    super( icon, onStage, null, offStage,  null );
    init();
  }
  private function init():void {
    icon.tabEnabled = false;
    icon.mouseEnabled = true;
    if(icon is DisplayObjectContainer) (icon as DisplayObjectContainer).mouseChildren = false;
  }

  private function onStage( e:Event = null ):void {
    if(icon is Sprite) (icon as Sprite).buttonMode = true;
    if(onOver != null) icon.addEventListener( MouseEvent.MOUSE_OVER, onOver );
    if(onOut != null) icon.addEventListener( MouseEvent.MOUSE_OUT, onOut );
  }
  private function offStage( e:Event = null ):void {
    if(icon is Sprite) (icon as Sprite).buttonMode = false;
    if(onOver != null) icon.removeEventListener( MouseEvent.MOUSE_OVER, onOver );
    if(onOut != null) icon.removeEventListener( MouseEvent.MOUSE_OUT, onOut );
  }

}
}

