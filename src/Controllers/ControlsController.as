package Controllers
{
	import flash.text.ReturnKeyLabel;
	
	import Screens.Game;
	
	import starling.core.Starling;
	import starling.display.Button;
	import starling.display.DisplayObject;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.KeyboardEvent;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	import starling.extensions.Gauge;
	
	public class ControlsController extends Sprite
	{
		
		private var container:Sprite;
		
		public var upButton:Button;
		public var leftButton:Button;
		public var rightButton:Button;
		public var game:Game;
		public var gauge:Gauge;
		public var hpGauge:Gauge;
		
		public function ControlsController(mn:Game)
		{
			game = mn;
			
			
			
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
			container.x = 0;
			container.y = 0;
			
			addChild(container);
			
			
			// Restart
			restartButton = new Button(AssetsController.getAtlas().getTexture("btUp"));
			restartButton.scaleX 	= 1.5;
			restartButton.scaleY 	= 1.5;
			restartButton.x		 	= 30;
			restartButton.y		 	= 30;
			container.addChild(restartButton);
			restartButton.addEventListener(TouchEvent.TOUCH,onTouch);
			
			
			
			upButton = new Button(AssetsController.getAtlas().getTexture("btUp"));
			upButton.name = "up";
			upButton.scaleX 	= 1.5;
			upButton.scaleY 	= 1.5;
			upButton.x		 	= 10;
			upButton.y		 	= Constants.STAGE_HEIGHT-100;
			container.addChild(upButton);
			
			leftButton = new Button(AssetsController.getAtlas().getTexture("btLeft"));
			leftButton.name = "left";
			leftButton.scaleX 		= 1.5;
			leftButton.scaleY	 	= 1.5;
			leftButton.y		 	= upButton.y;
			leftButton.x			= Constants.STAGE_WIDTH-200;
			container.addChild(leftButton);
			
			rightButton = new Button(AssetsController.getAtlas().getTexture("btRight"));
			rightButton.name = "right";
			rightButton.scaleX	 = 1.5;
			rightButton.scaleY	 = 1.5;
			rightButton.y		 = upButton.y;
			rightButton.x		 = Constants.STAGE_WIDTH-100;
			container.addChild(rightButton);
			
			upButton.addEventListener(TouchEvent.TOUCH,onTouch);
			leftButton.addEventListener(TouchEvent.TOUCH,onTouch);
			rightButton.addEventListener(TouchEvent.TOUCH,onTouch);
			
			game.stage.addEventListener(KeyboardEvent.KEY_DOWN,keyEvent);
			game.stage.addEventListener(KeyboardEvent.KEY_UP,keyUpEvent);
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
		private var restartButton:Button;
		private function keyEvent(e:KeyboardEvent):void
		{
			// TODO This Code is for just debugging
			var k:Boolean = false;
			if(e.keyCode == 38 || e.keyCode == 87){
				game.playerAction2 = game.player.moveUp;
				k = true;
				
			}
			if(e.keyCode == 37  || e.keyCode == 65){
				game.playerAction = game.player.moveLeft;
				k = true;
			}
			
			if(e.keyCode == 39  || e.keyCode == 68){
				game.playerAction = game.player.moveRight;
				k = true;
			}
			if(k && !debugKey){
				SoundsController.playSound("shhSound");
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
				if(e.currentTarget == restartButton){
					game.finishLevel();
					return;
				}
				
				if(e.currentTarget == upButton)
					game.playerAction2 = game.player.moveUp;
				
				if(e.currentTarget == leftButton)
					game.playerAction = game.player.moveLeft;
				
				if(e.currentTarget == rightButton)
					game.playerAction = game.player.moveRight;	
				
				SoundsController.playSound("shhSound");

			}
			
			if(e.getTouch(target, TouchPhase.ENDED))
			{	
				if(e.currentTarget == upButton)
					this.stopMove("up");
					
				if(e.currentTarget == leftButton || e.currentTarget == rightButton)
					this.stopMove("leftRight");
			}
		}
		
		private function stopMove(mode:String="both"):void
		{	
			game.player.stopParticles();
			switch (mode){
				case "both":
					game.playerAction  = null;
					game.playerAction2 = null;
					break;
				case "up":
					game.playerAction2 = null;
					break;
				case "leftRight":
					game.playerAction  = null;
					break;	
			}
		}
		
		public function kill():void
		{
			game.stage.removeEventListener(KeyboardEvent.KEY_DOWN,keyEvent);
			game.stage.removeEventListener(KeyboardEvent.KEY_UP,keyUpEvent);
			this.removeFromParent(true);
		}
	}
}