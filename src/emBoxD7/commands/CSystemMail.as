package emBoxD7.commands {
import emBoxD7.vos.VOAMFSendEmail;

public class CSystemMail extends ACServiceCall {
	private var vo:VOAMFSendEmail;
	
	public function CSystemMail(vo:VOAMFSendEmail){
		trace("Sending...");
		this.vo = vo;
		super("emboxd7.mail", 
    //"manosss@gmail.com",
    //"the subject",
    //"the body blah balhbalhbalhbalh balh",
    //"fromemail@gmail.com"
    
    "Subject: " + vo.subject + "\n" + vo.msg,
    vo.emailfrom
    
    //vo.to,
    //vo.subject,
    //vo.body,
    //vo.from
    );
	}

}
}

