package emBox.commands {
import emBox.interfaces.ILoaderDO;
import emBox.sprites.EmBoxSprite;
import emBox.locations.ILocation;

/**
 * ...
 * @author Emmanuel
 */
public class CAddRemoveChildren extends COverlap {
	protected var location:ILocation;
	protected var instancesList:Array;
	
	public function CAddRemoveChildren(
		instancesList:Array,
		location:ILocation
	){
		this.instancesList = instancesList;
		this.location = location;
		super();
		customize();
	}
	
	protected function customize():void {
		var anEmBoxSprite:EmBoxSprite;
		for (var i:int = 0; i < instancesList.length; i++){
			anEmBoxSprite = instancesList[i] as EmBoxSprite;
      // Check to see if its an image
			if(anEmBoxSprite is ILoaderDO){
				add(new CStartStop((anEmBoxSprite as ILoaderDO).loaderDO));
			}
			add(new CAppear(anEmBoxSprite, location.container, anEmBoxSprite.appears));
		}
	}
	
}
}

