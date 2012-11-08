package
{
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.geom.Rectangle;
	
	import starling.core.Starling;
	
	[SWF(frameRate=60, width=1024, height=768, backgroundColor=0x000000)]
	public class FingerSoccer extends Sprite
	{
		public function FingerSoccer()
		{
			trace("STARLING IS COMING 2");
			stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.align = StageAlign.TOP_LEFT;
			
			
			var screenWidth:int  = stage.fullScreenWidth;
			var screenHeight:int = stage.fullScreenHeight;
			var viewPort:Rectangle = new Rectangle(0, 0, screenWidth, screenHeight)
			
			Starling.multitouchEnabled = true;
			
				
			var star:Starling = new Starling(Main, stage, viewPort);
			
			
			star.stage.stageWidth  = 1024;
			star.stage.stageHeight = 768;
			star.showStats = true;
			star.start();
			
		}
	}
}