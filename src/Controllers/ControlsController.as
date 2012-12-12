package Controllers
{
	import starling.display.Button;
	import starling.display.DisplayObject;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.KeyboardEvent;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	import starling.extensions.Gauge;
	import Screens.Game;
	
	public class ControlsController extends Sprite
	{
		
		private var container:Sprite;
		
		public var upButton:Button;
		public var leftButton:Button;
		public var rightButton:Button;
		public var main:Game;
		public var gauge:Gauge;
		public var hpGauge:Gauge;
		
		public function ControlsController(mn:Game)
		{
			main = mn;
			
			
			
			pivotX = width >> 1;
			pivotY = height >>1;
			
			// Gauge
			gauge = new Gauge(AssetsController.getAtlas().getTexture("fuelBar"));

			gauge.ratio = 1;
			gauge.x 	= 400;
			gauge.y		= 20;
			addChild(gauge);
			
			//Gauge Border
			var gb:Image = new Image(AssetsController.getAtlas().getTexture("fuelBorder"));
			gb.x		= 400;
			gb.y		= 20;
			addChild(gb);
			
			
			// Gauge
			hpGauge = new Gauge(AssetsController.getAtlas().getTexture("fuelBar"));
			hpGauge.ratio 	= 1;
			hpGauge.x 		= 700;
			hpGauge.y		= 20;
			addChild(hpGauge);
			
			//Gauge Border
			gb			= new Image(AssetsController.getAtlas().getTexture("fuelBorder"));
			gb.x		= 700;
			gb.y		= 20;
			addChild(gb);
			
			
			// Controls Container
			container 	= new Sprite;
			container.x = 870;
			container.y = 600;
			
			addChild(container);
			
			
			
			
			upButton = new Button(AssetsController.getAtlas().getTexture("btUp"));
			upButton.name = "up";
			upButton.scaleX 	= 1.5;
			upButton.scaleY 	= 1.5;
			upButton.x		 	= -850;
			upButton.y		 	= 60;
			container.addChild(upButton);
			
			leftButton = new Button(AssetsController.getAtlas().getTexture("btLeft"));
			leftButton.name = "left";
			leftButton.scaleX 		= 1.5;
			leftButton.scaleY	 	= 1.5;
			leftButton.y		 	= 60;
			leftButton.x			= -50;
			container.addChild(leftButton);
			
			rightButton = new Button(AssetsController.getAtlas().getTexture("btRight"));
			rightButton.name = "right";
			rightButton.scaleX	 = 1.5;
			rightButton.scaleY	 = 1.5;
			rightButton.y		 = 60;
			rightButton.x		 = 60;
			container.addChild(rightButton);
			
			upButton.addEventListener(TouchEvent.TOUCH,onTouch);
			leftButton.addEventListener(TouchEvent.TOUCH,onTouch);
			rightButton.addEventListener(TouchEvent.TOUCH,onTouch);
			
			main.stage.addEventListener(KeyboardEvent.KEY_DOWN,keyEvent);
			main.stage.addEventListener(KeyboardEvent.KEY_UP,keyUpEvent);
		}
		
		private function keyUpEvent(e:KeyboardEvent):void
		{
			trace(e.keyCode);
			if(e.keyCode == 38 || e.keyCode == 87){
				this.stopMove("up");
			}
			if(e.keyCode == 37  || e.keyCode == 65){
				this.stopMove("leftRight");
			}
			
			if(e.keyCode == 39  || e.keyCode == 68){
				this.stopMove("leftRight");
			}
			debugKey = false;
		}
		
		private var debugKey:Boolean = false;
		private function keyEvent(e:KeyboardEvent):void
		{
			// TODO This Code is for just debugging
			var k:Boolean = false;
			if(e.keyCode == 38 || e.keyCode == 87){
				main.playerAction2 = main.player.moveUp;
				k = true;
			}
			if(e.keyCode == 37  || e.keyCode == 65){
				main.playerAction = main.player.moveLeft;
				k = true;
			}
			
			if(e.keyCode == 39  || e.keyCode == 68){
				main.playerAction = main.player.moveRight;
				k = true;
			}
			if(k && !debugKey){
				SoundsController.playSound("shhSound");
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
					main.playerAction2 = main.player.moveUp;
				
				if(e.currentTarget == leftButton)
					main.playerAction = main.player.moveLeft;
				
				if(e.currentTarget == rightButton)
					main.playerAction = main.player.moveRight;	
				
				SoundsController.playSound("shhSound");
				main.mouseDown = true;
			}
			
			if(e.getTouch(target, TouchPhase.ENDED))
			{	
				if(target.name == "up");
					this.stopMove("up");
					
				if(target.name == "left" || target.name == "right");
					this.stopMove("leftRight");
			}
		}
		
		private function stopMove(mode:String="both"):void
		{	
			main.mouseDown 	= false;
			main.player.stopParticles();
			
			switch (mode){
				case "both":
					main.playerAction  = null;
					main.playerAction2 = null;
					break;
				case "up":
					main.playerAction2 = null;
					break;
				case "leftRight":
					main.playerAction  = null;
					break;	
			}
		}
	}
}