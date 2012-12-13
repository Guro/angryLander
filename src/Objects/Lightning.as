package Objects
{
	import com.greensock.TweenLite;
	import com.greensock.easing.Sine;
	
	import flash.geom.Rectangle;
	import flash.utils.setInterval;
	
	import nape.geom.Vec2;
	
	import starling.core.Starling;
	import starling.display.MovieClip;
	import starling.display.Sprite;
	import starling.events.Event;
	import Screens.Game;
	import Controllers.AssetsController;
	
	public class Lightning extends Sprite
	{
		
		private var container:Sprite;
		private var main:Game;
		
		
		public var options:Object;
		public var lightMC:MovieClip
		
		public function Lightning(mn:Game,opts:Object)
		{
			main 	= mn;
			options	= opts;
			
			
			
			lightMC = new  MovieClip(AssetsController.getAtlas2().getTextures("light"),30);
			lightMC.pivotX = lightMC.width/2;
			lightMC.pivotY = lightMC.width/2;
			lightMC.x = opts.x;
			lightMC.y = opts.y;
			lightMC.visible = false;
			
			setInterval(toggle,3000);
			
			addChild(lightMC);
		}
		
		public function toggle():void
		{
		
			if(lightMC.visible == false)
			{
				lightMC.visible = true;
				Starling.juggler.add(lightMC);
				addEventListener(Event.ENTER_FRAME, loop)
			}else{
				lightMC.visible = false;
				Starling.juggler.remove(lightMC);
				this.dispose();
			}
		}
		
		
		
		private function loop(e:Event):void
		{
			if(main.player.container.bounds.intersects(new Rectangle(lightMC.x-20,lightMC.y,lightMC.width/2,lightMC.height)))
			{
				main.player.body.applyLocalImpulse(new Vec2(-1400,0), new Vec2(0,0));
				main.camera.shake(0.03,30);
			}
		}
	}
}