package
{
	import Screens.Game;
	import Screens.Levels;
	
	import starling.core.Starling;
	import starling.display.Sprite;
	import starling.events.Event;
	
	public class Main extends Sprite
	{
		
		public var curScreen:Sprite;
		
		// Public config Vars
		public var maxLevels:Number = 2;
		
		// All Available Screens
		public var levels:Levels;
		public var game:Game;
		
		public function Main()
		{
			// Get Stats Sprite
				
			addEventListener(Event.ADDED_TO_STAGE,onAdded);
		}
		
		private function onAdded(e:Event):void
		{
			
			trace("Init Root");
			
			this.curScreen = new Levels(this);
			addChild(this.curScreen);
			
		}
		
		public function changeScreen(screen:String,options:Object=null):void
		{
			trace("ChangeLvel");
			removeChild(this.curScreen);
			this.curScreen.dispose();
			this.curScreen = null;
			
			switch (screen){
				case "Game":
						this.curScreen = new Game(this,options.level);
					break;
				case "Levels":
						this.curScreen = new Levels(this);
				break;
			}
			
			addChild(this.curScreen);
			
			Starling.current.stage.addChildAt(Starling.current.mStatsDisplay,Starling.current.stage.numChildren);
			
		}
	}
}