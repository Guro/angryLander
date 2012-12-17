package Objects
{
	import com.greensock.TweenLite;
	import com.greensock.easing.Sine;
	
	import flash.geom.Rectangle;
	
	import nape.geom.Vec2;
	
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Event;
	import Screens.Game;
	import Controllers.AssetsController;
	import Controllers.SoundsController;
	
	public class Coin extends Sprite
	{
		
		private var container:Sprite;
		private var main:Game;
		
		
		public var options:Object;
		public var coinImage:Image
		
		public function Coin(mn:Game,opts:Object)
		{
			main 	= mn;
			options	= opts;
			
			
			coinImage = new Image(AssetsController.getAtlas().getTexture("coin"));
			coinImage.pivotX = coinImage.width/2;
			coinImage.pivotY = coinImage.width/2;
			coinImage.x = opts.x;
			coinImage.y = opts.y;
			
			
			addEventListener(Event.ENTER_FRAME, loop)
			
			
			
			addChild(coinImage)
			this.flatten();
		}
		
		private function loop(e:Event):void
		{
			// TODO Auto Generated method stub
			if(main.player.container.bounds.intersects(new Rectangle(coinImage.x,coinImage.y,1,1)))
			{
				var t:Sprite = this;
				TweenLite.to(this.coinImage,0.4,{
									alpha:0,
									scaleX:1.5,
									scaleY:1.5,
									y:this.coinImage.y - 80,
									ease:Sine.easeOut,
									onComplete:function():void
									{	
										t.visible = false;
										t.removeFromParent(true);
									}
								});
				this.dispose();
				SoundsController.playSound("popSound");
				main.dispatchEvent(new Event("coinCollected"));
			}
		}
	}
}