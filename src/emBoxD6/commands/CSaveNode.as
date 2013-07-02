package emBoxD6.commands{

	public class CSaveNode extends ACServiceCall {

		public function CSaveNode(node:Object){
			super("node.save",
			node
			);
		}
	}
}

