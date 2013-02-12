package gr.emmanuel.instanciators {
import gr.emmanuel.interfaces.IClonable;

/**
 * ...
 * @author Emmanuel Vohaitis
 */
public class InstanciatorImages extends InstanciatorClonables {
	private var prependedPath:String;
	
	public function InstanciatorImages(
		prependedPath:String,
		clonable:IClonable,
		source:Array = null,
		defineInstance:Function = null,
		instances:Array = null
	){
		this.prependedPath = prependedPath;
		this.clonable = clonable;
		super( clonable, source, defineInstance, instances);
	}
	
	override protected function localDefineInstance(index:int):Object {
		vars = source[index];
		var imgPath:String;
		if (vars.hasOwnProperty("image")){
			imgPath = prependedPath + vars.image;
		} else if (vars.hasOwnProperty("images")){
			var loadImg:int = 0;
			if (vars.hasOwnProperty("storyboad_thumb")){
				loadImg = vars.storyboad_thumb;
			}
			imgPath = prependedPath + vars.images[loadImg];
		}
		if (vars is String){
			imgPath = prependedPath + vars as String;
		}
		return clonable.clone({thumbPath:imgPath})
	}
}
}