package
{
	
	import flash.media.Sound;
	import flash.utils.Dictionary;

	public class Sounds
	{
		private static var gameSounds:Dictionary = new Dictionary();
		private static var gameSoundChannels:Dictionary = new Dictionary();
		
		[Embed(source='assets/sounds/shhh.mp3')] 		 
		private static const shhSound:Class; 
		
		[Embed(source='assets/sounds/boom.mp3')] 		 
		private static const boomSound:Class; 
		
		[Embed(source='assets/sounds/loop.mp3')] 		 
		private static const loopSound:Class;
		
		[Embed(source='assets/sounds/pop.mp3')] 		 
		private static const popSound:Class;
		
		
		private static var enabled:Boolean = true;
		
		
		public static function playSound(name:String,loop:Number=0):void
		{
			if(!enabled)
				return;
			
			if (gameSounds[name] == undefined)
			{
				var sound:Sound = new Sounds[name]();
				gameSounds[name] = sound;
			}else{
				gameSoundChannels[name].stop();	
			}
			
			gameSoundChannels[name] = gameSounds[name].play(0,loop);
			
		}
		
		
		public static function stopSound(name:String):void
		{
			if(!enabled)
				return;
			
			gameSoundChannels[name].stop();
		}
	}
}