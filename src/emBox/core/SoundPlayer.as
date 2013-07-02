package emBox.core {
import emBox.loaders.LoadSound;
import flash.events.Event;
import flash.events.EventDispatcher;
import flash.media.Sound;
import flash.media.SoundChannel;
import flash.media.SoundTransform;
import flash.net.URLRequest;
import com.greensock.*;
import com.greensock.plugins.*;
TweenPlugin.activate([VolumePlugin]);

public class SoundPlayer {
	static private var fxSoundChannel:SoundChannel = new SoundChannel();
	static private var musicSoundChannel:SoundChannel = new SoundChannel();
	static private var musicSoundTransform:SoundTransform = new SoundTransform(1);
	static private var fxSoundTransform:SoundTransform = new SoundTransform(1);
	static public var loadSound:LoadSound = new LoadSound();
	static private var isInit:Boolean = false;
	static private var isSoundFxPlaying:Boolean = false;
	static private var isMusicPlaying:Boolean = false;
	
	public function SoundPlayer() {
	}
	
	private static function init():void {
    isInit = true;
    fxSoundChannel.soundTransform = fxSoundTransform;
    fxSoundChannel.addEventListener(Event.SOUND_COMPLETE, onSoundFxComplete);
    musicSoundChannel.soundTransform = musicSoundTransform;
    musicSoundChannel.addEventListener(Event.SOUND_COMPLETE, onMusicComplete);
	}
  
  static private function onMusicComplete(e:Event):void {
    isMusicPlaying = false;
  }
  static private function onSoundFxComplete(e:Event):void {
    isSoundFxPlaying = false;
  }
	
	public static function playSoundFx(soundFx:Sound, overridePlayingSound:Boolean = false):void {
		if(!isInit) init();
    if(overridePlayingSound && isSoundFxPlaying) {
      isSoundFxPlaying = false;
      fxSoundChannel.stop();
    }
    isSoundFxPlaying = true;
    if (fxSoundTransform.volume!=0) {
      fxSoundChannel = soundFx.play();
    }
	}
	
	public static function muteSFX():void {
		if(!isInit) init();
		if(fxSoundTransform.volume > 0) {
			fxSoundTransform.volume = 0;
		}
	}
	
	public static function unmuteSFX():void {
		if(!isInit) init();
		if(fxSoundTransform.volume == 0) {
			fxSoundTransform.volume = 1;
		}
	}
	
	/**
	 * Loads and plays the requsted file
	 * @param	path the path for the audio file   */
	public static function loadAndPlayMusicFile(path:String):void {
		if(!isInit) init();
		loadSound.urlNew(path);
		loadSound.start();
		if(loadSound.hasStarted) {
			loadSound.sound.addEventListener(Event.COMPLETE, musicLoadComplete);
		} else {
			musicSoundChannel = loadSound.sound.play(0, int.MAX_VALUE);
		}
	}
	private static function musicLoadComplete(e:Event):void {
		loadSound.sound.removeEventListener(Event.COMPLETE, musicLoadComplete);
		musicSoundChannel = loadSound.sound.play(0, int.MAX_VALUE);
	}
	
	public static function muteMusic():void {
		if(!isInit) init();
		TweenLite.to(musicSoundChannel, 1, {volume: 0});
	}
	
	public static function unmuteMusic():void {
		if(!isInit) init();
		TweenLite.to(musicSoundChannel, 1, {volume: 1});
	}

}
}

