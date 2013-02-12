package gr.emmanuel.dispatchers {
import gr.emmanuel.events.DictionaryEvent;
import flash.events.EventDispatcher;
import flash.utils.Dictionary;

public class DictionaryDispatcher extends EventDispatcher {
	private var dictionary:Dictionary;
	
	public function DictionaryDispatcher() {
		dictionary = new Dictionary();
	}
	
	public function getValue(key:String):* {
		return dictionary[key];
	}
	
	public function addValue(key:String, value:*):void {
		
		var oldValue:* = dictionary[key];
		dictionary[key] = value;
		
		if (oldValue != value) {
			if (oldValue === undefined) {
				dispatchEvent(new DictionaryEvent(DictionaryEvent.VALUE_ADDED, key, value));
			} else {
				dispatchEvent(new DictionaryEvent(DictionaryEvent.VALUE_CHANGED, key, value, oldValue));
			}
		}
	}
	
	public function removeValue(key:String):void {
		if (key == null) return;
		
		var value:* = dictionary[key];
		if (value !== undefined) {
			delete dictionary[key];
			dispatchEvent(new DictionaryEvent(DictionaryEvent.VALUE_REMOVED, key, value));
		}
	}
	
	public function get keys():Vector.<String> {
		var allKeys:Vector.<String> = new Vector.<String>;
		if (dictionary != null) {
			for (var key:Dictionary in dictionary) {
				allKeys.push(key);
			}
		}
		return allKeys;
	}

}
}
