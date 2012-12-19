package
{
	import flash.system.System;

		
	import Screens.Game;
	import Screens.Levels;
	
	import starling.core.Starling;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Event;
	
	public class Main extends Sprite
	{
		[Embed(source="/Assets/loadingimage.jpg")]
		private var bg:Class;
		
		public var curScreen:Sprite;
		
		// Public config Vars
		public var maxLevels:Number = 4;
		
		// All Available Screens
		public var levels:Levels;
		public var game:Game;
		private var loadingImg:Image;
		
		public function Main()
		{
			
			// Get Stats Sprite
			addEventListener(Event.ADDED_TO_STAGE,onAdded);
			
			loadingImg 				= Image.fromBitmap(new bg());
			loadingImg.touchable 	= false;
			// Todo: add stage.stageWidth
			loadingImg.x 			= 1024/2 - loadingImg.width/2;
			loadingImg.y 			= 768/2 - loadingImg.height/2;
		}
		
		private function onAdded(e:Event):void
		{
			
			trace("Init Root");
			
			this.curScreen = new Levels(this);
			addChild(this.curScreen);
			
			
		}
		
		public function changeScreen(screen:String,options:Object=null):void
		{
			addChild(loadingImg);
			
			
			trace("ChangeLvel");
			removeChild(this.curScreen);
			
			this.curScreen.dispose();
			this.curScreen = null;
			System.gc();
			
			switch (screen){
				case "Game":
						this.curScreen = new Game(this,options.level);
					break;
				case "Levels":
						this.curScreen = new Levels(this);
				break;
			}
			
			Starling.juggler.delayCall(function():void{
				trace("Delay Call");
				addChild(curScreen);
				//Starling.current.stage.addChildAt(Starling.current.mStatsDisplay,Starling.current.stage.numChildren);
			},0.5);
		}
		
	}
}