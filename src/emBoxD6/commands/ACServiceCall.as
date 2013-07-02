package emBoxD6.commands{
import com.adobe.crypto.*;
import emBoxD6.EmBoxD6;
import emBox.commands.ACommand;
import emBox.commands.CEvent;
import emBox.commands.CEvent;
import emBox.utils.Objects;
import emBox.utils.Strings;
import flash.events.IOErrorEvent;
import flash.events.NetStatusEvent;
import flash.events.SecurityErrorEvent;
import flash.net.NetConnection;
import flash.net.ObjectEncoding;
import flash.net.Responder;
import flash.utils.getTimer;

public class ACServiceCall extends ACommand {
  public static var authenticate:Boolean = true;// Authentication for d7 doesnt exist switch off
  protected static var session_id:String;// stores session id when it is returned from "system.connect"
  private var netConnection:NetConnection ;
  private var responder:Responder ;
  private var hash:String;
  private var time:String;
  private var nonce:String;
  private var args:Array;
  private var method:String;
  private var methodArguments:Array;

  public function ACServiceCall(method:String, ...methodArguments){
    this.method = method;
    this.methodArguments = [];
    for (var i:int = 0; i < methodArguments.length; i++){
      this.methodArguments.push(methodArguments[i]);
    }
    super();
    init();
  }
  private function init():void {
    responder = new Responder( onResult, onStatus);
    netConnection = new NetConnection();
    netConnection.objectEncoding = ObjectEncoding.AMF3;
    netConnection.addEventListener( NetStatusEvent.NET_STATUS, onNetStatus);
    netConnection.addEventListener( SecurityErrorEvent.SECURITY_ERROR, onSecurityError);
    netConnection.addEventListener( IOErrorEvent.DISK_ERROR, onDiskError);
    netConnection.addEventListener( IOErrorEvent.IO_ERROR, onIOError);
    netConnection.addEventListener( IOErrorEvent.NETWORK_ERROR, onNetworkError);
    netConnection.addEventListener( IOErrorEvent.VERIFY_ERROR, onVerifyError);
    netConnection.connect(CConnect.GATEWAY_URL);
    
  }

  override protected function doIn():void  {
    super.doIn();
    time = Math.round(new Date().getTime() / 1000).toString();
    nonce = Strings.randomString(10);
    var msg:String = time + ";";
    msg = msg + (CConnect.DOMAIN + ";");
    msg = msg + (this.nonce + ";");
    msg = msg + method;
    hash = HMAC.hash(CConnect.API_KEY, msg, SHA256);

    var argsToApply:Array = [];
    if (authenticate) {
      argsToApply.push(method);
      argsToApply.push(responder);
      argsToApply.push(hash);
      argsToApply.push(CConnect.DOMAIN);
      argsToApply.push(time);
      argsToApply.push(nonce);
      argsToApply.push(session_id);
      argsToApply = argsToApply.concat( methodArguments);
    }else {
      argsToApply.push(method);
      argsToApply.push(responder);
      argsToApply = argsToApply.concat( methodArguments);
    }
    netConnection.call.apply( null, argsToApply);
    trace("argsToApply : " + argsToApply);
  }

  protected function onResult( o:Object = null ):void {
    netConnection.removeEventListener( NetStatusEvent.NET_STATUS, onNetStatus);
    netConnection.removeEventListener( SecurityErrorEvent.SECURITY_ERROR, onSecurityError);
    netConnection.removeEventListener( IOErrorEvent.DISK_ERROR, onDiskError);
    netConnection.removeEventListener( IOErrorEvent.IO_ERROR, onIOError);
    netConnection.removeEventListener( IOErrorEvent.NETWORK_ERROR, onNetworkError);
    netConnection.removeEventListener( IOErrorEvent.VERIFY_ERROR, onVerifyError);
    traceDuration("Drupal  SUCCEED when called ")
    executeInComplete( o );
  }

  protected  function onStatus( o:Object = null ):void {
    dispatchEvent(new CEvent(CEvent.EXECUTE_ERROR, o));
    trace("ServiceCall  ERROR ");
    Objects.traceDynamicAtributes(o);
  }

  private function onNetStatus(e:NetStatusEvent):void {
    trace("onNetStatus : " + e);
    Objects.traceDynamicAtributes(e.info);
    trace("attempting again... ");
    doIn();
  }
  private function onSecurityError(e:SecurityErrorEvent):void {
    trace("onSecurityError : " + e);
  }
  private function onDiskError(e:IOErrorEvent):void {
    trace("onDiskError : " + e);
  }
  private function onIOError(e:IOErrorEvent):void {
    trace("onIOError : " + e);
  }
  private function onNetworkError(e:IOErrorEvent):void {
    trace("onNetworkError : " + e);
  }
  private function onVerifyError(e:IOErrorEvent):void {
    trace("onVerifyError : " + e);
  }

}
}

