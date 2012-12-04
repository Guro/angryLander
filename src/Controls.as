package
{
	import starling.display.Button;
	import starling.display.DisplayObject;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.KeyboardEvent;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	import starling.extensions.Gauge;
	
	public class Controls extends Sprite
	{
		
		private var container:Sprite;
		
		public var upButton:Button;
		public var leftButton:Button;
		public var rightButton:Button;
		public var main:Main;
		public var gauge:Gauge;
		public var hpGauge:Gauge;
		
		public function Controls(mn:Main)
		{
			main = mn;
			
			
			
			pivotX = width >> 1;
			pivotY = height >>1;
			
			// Gauge
			gauge = new Gauge(Assets.getAtlas().getTexture("fuelBar"));
			gauge.ratio = 1;
			gauge.x 	= 400;
			gauge.y		= 20;
			addChild(gauge);
			
			//Gauge Border
			var gb:Image = new Image(Assets.getAtlas().getTexture("fuelBorder"));
			gb.x		= 400;
			gb.y		= 20;
			addChild(gb);
			
			
			// Gauge
			hpGauge = new Gauge(Assets.getAtlas().getTexture("fuelBar"));
			hpGauge.ratio 	= 1;
			hpGauge.x 		= 700;
			hpGauge.y		= 20;
			addChild(hpGauge);
			
			//Gauge Border
			gb			= new Image(Assets.getAtlas().getTexture("fuelBorder"));
			gb.x		= 700;
			gb.y		= 20;
			addChild(gb);
			
			
			// Controls Container
			container 	= new Sprite;
			container.x = 900;
			container.y = 630;
			
			addChild(container);
			
			
			
			
			upButton = new Button(Assets.getAtlas().getTexture("btUp"));
			upButton.x		 	= -850;
			upButton.y		 	= 60;
			container.addChild(upButton);
			
			leftButton = new Button(Assets.getAtlas().getTexture("btLeft"));
			leftButton.y		 = 60;
			container.addChild(leftButton);
			
			rightButton = new Button(Assets.getAtlas().getTexture("btRight"));
			rightButton.y		 = 60;
			rightButton.x		 = 60;
			container.addChild(rightButton);
			
			upButton.addEventListener(TouchEvent.TOUCH,onTouch);
			leftButton.addEventListener(TouchEvent.TOUCH,onTouch);
			rightButton.addEventListener(TouchEvent.TOUCH,onTouch);
			
			main.stage.addEventListener(KeyboardEvent.KEY_DOWN,keyEvent);
			main.stage.addEventListener(KeyboardEvent.KEY_UP,keyUpEvent);
		}
		
		private function keyUpEvent():void
		{
			// TODO Auto Generated method stub
			this.stopMove();
			debugKey = false;
		}
		
		private var debugKey:Boolean = false;
		private function keyEvent(e:KeyboardEvent):void
		{
			// TODO This Code is for just debugging
			var k:Boolean = false;
			if(e.keyCode == 38){
				main.playerAction = main.player.moveUp;
				k = true;
			}
			if(e.keyCode == 37){
				main.playerAction = main.player.moveLeft;
				k = true;
			}
			
			if(e.keyCode == 39){
				main.playerAction = main.player.moveRight;
				k = true;
			}
			if(k && !debugKey){
				Sounds.playSound("shhSound");
				main.mouseDown = true;
				debugKey = true;
			}
			
		}
		
		public function disableControls():void
		{
			upButton.enabled = false;
			leftButton.enabled = false;
			rightButton.enabled = false;
			this.stopMove();
		}
		
		private function onTouch(e:TouchEvent):void
		{
			var target:DisplayObject = e.target as DisplayObject;
			
			if(e.getTouch(target, TouchPhase.BEGAN))
			{
				if(e.currentTarget == upButton)
					main.playerAction = main.player.moveUp;
				
				if(e.currentTarget == leftButton)
					main.playerAction = main.player.moveLeft;
				
				if(e.currentTarget == rightButton)
					main.playerAction = main.player.moveRight;	
				
				Sounds.playSound("shhSound");
				main.mouseDown = true;
			}
			
			if(e.getTouch(target, TouchPhase.ENDED))
			{	
				this.stopMove();
			}
		}
		
		private function stopMove():void
		{	
			main.mouseDown 	= false;
			main.player.stopParticles();
		}
	}
}