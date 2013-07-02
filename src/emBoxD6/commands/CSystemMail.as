package emBoxD6.commands{
  import emBoxD6.vos.VOAMFSendEmail;

	public class CSystemMail extends ACServiceCall {
		private var vo:VOAMFSendEmail;

		public function CSystemMail(vo:VOAMFSendEmail){
			trace("Sending..." );
			this.vo = vo;
			super("system.mail",
			"a mailKey!!",
			vo.to,
			vo.subject,
			vo.body,
			vo.from
			);
		}
		
	}
}

