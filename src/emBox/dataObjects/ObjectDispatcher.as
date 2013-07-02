package emBox.dataObjects{
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.utils.Dictionary;

	/**
	 * Dispatched when a new value is added to the object.
	 * @eventType events.MetadataEvent.VALUE_ADD
	 */
	[Event(name='valueAdd', type='dataObjects.MetadataEvent')]

	/**
	 * Dispatched when a value is removed from the object.
	 * @eventType events.MetadataEvent.VALUE_REMOVE
	 */
	[Event(name='valueRemove', type='dataObjects.MetadataEvent')]

	/**
	 * Dispatched when a value within the object changes.
	 * @eventType events.MetadataEvent.VALUE_CHANGE
	 */
	[Event(name='valueChange', type='dataObjects.MetadataEvent')]

	/**
	 * The class encapsulates a related collection of metadata.
	 *
	 * <p>Metadata consists of key-value pairs, where keys are Strings
	 * and values are arbitrary Objects.  The class provides a
	 * strongly-typed API for working with these key-value pairs, as well
	 * as events for detecting changes to the metadata.</p>
	 */
	public class ObjectDispatcher extends EventDispatcher	{
		public function ObjectDispatcher()		{		}

		/**
		 * Returns the value associate with the specified key.
		 * Returns 'undefined' if theobject fails to resolve the key.
		 * @throws ArgumentError If key is null.
		 */
		public function getValue(key:String):*{
			if (key == null){ throw new ArgumentError("ObjectDispatcher getValue value is NULL");}
			return data != null ? data[key] : null
		}

		/**
		 * Stores the specified value in this object, using the specified
		 * key.  The key can subsequently be used to retrieve the value.  If the
		 * key is equal to the key of another object already in the object
		 * this will overwrite the association with the new value.
		 *
		 * @param key The key to associate the value with.
		 * @param value The value to add to the object.
		 * @throws ArgumentError If key is null or somehow invalid.
		 */
		public function addValue(key:String, value:Object):void{
			if (key == null){ throw new ArgumentError("ObjectDispatcher addValue value is NULL");}

			if (data == null) data = new Dictionary();

			var oldValue:* = data[key];
			data[key] = value;

			if (oldValue != value){
				var event:Event= oldValue === undefined
				? new MetadataEvent( MetadataEvent.VALUE_ADD, false, false, key, value)
				: new MetadataEvent( MetadataEvent.VALUE_CHANGE, false, false, key, value, oldValue);
				dispatchEvent(event);
			}
		}

		/**
		 * Removes the value associated with the specified key from this
		 * object. Returns undefined if there is no value
		 * associated with the key in this object.
		 *
		 * @param key The key associated with the value to be removed.
		 * @returns The removed item, null if no such item exists.
		 * @throws ArgumentError If key is null.
		 */
		public function removeValue(key:String):*{
			if (key == null){ throw new ArgumentError("ObjectDispatcher removeValue value is NULL");}

			var value:* = data[key];
			if (value !== undefined){
				delete data[key];
				dispatchEvent( new MetadataEvent( MetadataEvent.VALUE_REMOVE, false, false, key, value));
			}
			return value;
		}

		/**
		 * The keys stored in this object.
		 */
		public function get keys():Vector.<String>{
			var allKeys:Vector.<String> = new Vector.<String>;
			if (data != null){
				for (var key:Object in data){
					allKeys.push(key);
				}
			}
			return allKeys;
		}

		private var data:Dictionary;
	}
}
