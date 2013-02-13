package   {
import flash.display.Sprite;
import flash.display.StageScaleMode;
import flash.events.Event;

import gr.emmanuel.emBoxAS3.utils.Objects;


/**
 * ...
 * @author emmanuel
 */
[SWF(width="400", height="900", frameRate="25", backgroundColor="#222222")]

public class TestObjects extends Sprite {

  public function TestObjects() {
    if (stage) init();
    else addEventListener(Event.ADDED_TO_STAGE, init);
  }
  private function init(e:Event = null):void {
    removeEventListener(Event.ADDED_TO_STAGE, init);
    stage.scaleMode = StageScaleMode.NO_SCALE;

    var obj:Object = {
      x:5,
      array:[1, 2, 3, {prop:"asdf"}, ["a","b"]
      ]
    }

    trace( Objects.getValue(obj,"x"));
    trace( Objects.getValue(obj,"array"));
    trace( Objects.getValue(obj,"array.3.prop"));
    trace( Objects.getValue(obj,"array.4.1"));
    trace( Objects.getValue(obj,"array.4.3"));
  }

}
}

