package emBoxD6.commands{

	public class CGetTaxonomy extends ACServiceCall{

		public function CGetTaxonomy(
		tids:Array,
		fields:Array = null,
		operators:String = ""
		){
			super("taxonomy.selectNodes",
			tids,
			fields,
			operators,
      "all",
      false
			);
		}
	}
}


