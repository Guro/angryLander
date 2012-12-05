package Objects
{
	import com.greensock.TweenLite;
	import com.greensock.easing.Sine;
	
	import flash.geom.Rectangle;
	
	import nape.geom.Vec2;
	
	import starling.core.Starling;
	import starling.display.MovieClip;
	import starling.display.Sprite;
	import starling.events.Event;
	
	public class Lightning extends Sprite
	{
		
		private var container:Sprite;
		private var main:Main;
		
		
		public var options:Object;
		public var lightMC:MovieClip
		
		public function Lightning(mn:Main,opts:Object)
		{
			main 	= mn;
			options	= opts;
			
			
			
			lightMC = new  MovieClip(Assets.getAtlas2().getTextures("light_"),30);
			lightMC.pivotX = lightMC.width/2;
			lightMC.pivotY = lightMC.width/2;
			lightMC.x = opts.x;
			lightMC.y = opts.y;
			
			Starling.juggler.add(lightMC);
			
			addEventListener(Event.ENTER_FRAME, loop)

			addChild(lightMC);
		}
		
		private function loop(e:Event):void
		{
			// TODO Auto Generated method stub
			if(main.player.container.bounds.intersects(new Rectangle(lightMC.x,lightMC.y,lightMC.width,lightMC.height)))
			{
				main.player.body.applyLocalImpulse(new Vec2(-1400,0), new Vec2(0,0));
				main.camera.shake(0.03,30);
			}
		}
	}
}