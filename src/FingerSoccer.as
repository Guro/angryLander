package
{
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.geom.Rectangle;
	
	import starling.core.Starling;
	
	
	
	[SWF(frameRate=60,  backgroundColor=0x000000)]
	public class FingerSoccer extends Sprite
	{
		public function FingerSoccer()
		{
			trace("STARLING IS COMING 2");
			stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.align = StageAlign.TOP_LEFT;
			stage.color = 0x000000;
			
			var screenWidth:int  = stage.fullScreenWidth;
			var screenHeight:int = stage.fullScreenHeight;
			var viewPort:Rectangle = new Rectangle(0, 0, screenWidth, screenHeight)
			
//			var viewPort:Rectangle = RectangleUtil.fit(
//				new Rectangle(0, 0, 1024, 768),
//				new Rectangle(0, 0, stage.fullScreenWidth, stage.fullScreenHeight));
			
			Starling.multitouchEnabled = true;
			
				
			var star:Starling = new Starling(Main, stage, viewPort);
			star.stage.stageWidth  = Constants.STAGE_WIDTH;
			star.stage.stageHeight = Constants.STAGE_HEIGHT;
			star.showStats = true;
			star.start();
			
		}
	}
}