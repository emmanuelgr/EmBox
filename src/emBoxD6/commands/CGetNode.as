package emBoxD6.commands {

public class CGetNode extends ACServiceCall {
	
	public function CGetNode(nid:int){
		super("node.get", nid);
	}
}
}

