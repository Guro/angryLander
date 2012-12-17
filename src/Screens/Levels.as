package Screens
{
	import com.greensock.TweenLite;
	
	import Controllers.AssetsController;
	
	import starling.animation.Tween;
	import starling.core.Starling;
	import starling.display.BlendMode;
	import starling.display.Button;
	import starling.display.DisplayObject;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	import starling.text.TextField;
	
	

	public class Levels extends Sprite
	{

		
		
		public var main:Main;
		
		
		private var allButtons:Sprite = new Sprite();
		
		public function Levels(mn:Main)
		{
			this.main = mn;
			
			trace("levels Screen");

			addEventListener(Event.ADDED_TO_STAGE,onAdded);
			
		}
		
		private function onAdded(e:Event):void
		{
			var bgImg:Image = new Image(AssetsController.getTexture("bg"));
			bgImg.touchable = false;
			bgImg.blendMode = BlendMode.NONE;
			addChild(bgImg);
			
			addChild(allButtons);
			allButtons.y = -200;
			allButtons.x = 100;
			
		
			
			
			var upButton:Button;
			// Generate Buttons
			for (var i:Number = 0; i<10; i++)
			{
				
				if(i < this.main.maxLevels){
					upButton = new Button(AssetsController.getAtlas().getTexture("levelButton"));
					// Gen Text
					var tx:TextField = new TextField(158,135,String(i+1),"Toonish",64,0xffffff);
					upButton.addChild(tx);
					
				}else{
					upButton = new Button(AssetsController.getAtlas().getTexture("levelButtonLock"));
					upButton.enabled = false;
				}
				
				
				upButton.name = ""+(i+1);
				if(i >= 5){
					TweenLite.to(upButton,0.2,{y:600,delay:0.1*i});
					upButton.x		= (i*170)-850;
				}else{
					TweenLite.to(upButton,0.2,{y:400,delay:0.1*i});
					upButton.x		= i*170;
				}
				allButtons.addChild(upButton);
				
				
			}
			allButtons.addEventListener(TouchEvent.TOUCH,onTouch);
		}
		
		private function onTouch(e:TouchEvent):void
		{
			
			var target:DisplayObject = e.target as DisplayObject;
			if(e.getTouch(target, TouchPhase.ENDED))
			{
				if(int(target.parent.parent.name) > this.main.maxLevels)
					return;
				
				this.main.changeScreen("Game",{
					level:target.parent.parent.name
				});
			}
		}
	}
}