package gr.emmanuel.emBoxAS3.actions{
  import flash.display.DisplayObjectContainer;
  import flash.display.InteractiveObject;
  import flash.display.Sprite;
  import flash.events.Event;
  import flash.events.MouseEvent;

public class Clickable extends OnOffStage{
  public var icon:InteractiveObject ;
  public var onClick:Function ;
  public var onDoubleClick:Function ;
  public var onDown:Function ;
  public var onUp:Function ;

  public function Clickable(
  icon:InteractiveObject ,
  onClick:Function = null,
  onDoubleClick:Function = null,
  onDown:Function = null,
  onUp:Function = null
  ){
    this.icon = icon;
    this.onClick = onClick;
    this.onDoubleClick = onDoubleClick;
    this.onDown = onDown;
    this.onUp = onUp;
    super( icon, onStage, null, offStage,  null );
    init();
  }
  private function init():void {
    icon.tabEnabled = false;
    if(icon is DisplayObjectContainer) (icon as DisplayObjectContainer).mouseChildren = false;
  }

  private function onStage( e:Event = null ):void {
    if (icon is Sprite) (icon as Sprite).buttonMode = true;
    if (onDoubleClick != null) icon.doubleClickEnabled = true;
     
    if(onClick != null) icon.addEventListener( MouseEvent.CLICK, goFigure );
    if (onDoubleClick != null) icon.addEventListener( MouseEvent.DOUBLE_CLICK, goFigure );
    if(onDown != null) icon.addEventListener( MouseEvent.MOUSE_DOWN, onDown );
    if(onUp != null) icon.addEventListener( MouseEvent.MOUSE_UP, onUp );
  }
  
  private function offStage( e:Event = null ):void {
    if (icon is Sprite) (icon as Sprite).buttonMode = false;
    if (onDoubleClick != null) icon.doubleClickEnabled = false
    ;
    if(onClick != null) icon.removeEventListener( MouseEvent.CLICK, goFigure );
    if (onDoubleClick != null) icon.addEventListener( MouseEvent.DOUBLE_CLICK, goFigure );
    if(onDown != null) icon.removeEventListener( MouseEvent.MOUSE_DOWN, onDown );
    if(onUp != null) icon.removeEventListener( MouseEvent.MOUSE_UP, onUp );
  }
  
  private function goFigure( e:MouseEvent):void {
    if (e.type == MouseEvent.DOUBLE_CLICK) {
      onDoubleClick(e);
    }else {
      onClick(e);
    }
  }
}
}

