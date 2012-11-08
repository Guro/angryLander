package
{
	
	
	import com.greensock.TweenLite;
	import com.greensock.easing.Bounce;
	
	import flash.utils.ByteArray;
	
	import Objects.Coin;
	import Objects.Platform;
	import Objects.Player;
	
	import nape.callbacks.InteractionCallback;
	import nape.phys.Body;
	import nape.phys.BodyType;
	import nape.shape.Polygon;
	
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Event;

	public class LevelController extends Sprite
	{
		
		[Embed(source="assets/levels/level1.oel", mimeType="application/octet-stream")]
		public static const level1:Class;
		
		
		public var player:Player;
		public var platform:Platform;
		public var coins:Sprite;
		
		public var main:Main;
		
		private var _xml:XML;
		private var goodLanding:Boolean = false;
		private var boomImage:Sprite;
		
		public function LevelController(mn:Main)
		{
			main = mn;	
			var contentfile:ByteArray = new level1();
			var contentstr:String = contentfile.readUTFBytes( contentfile.length );
			_xml =  new XML(contentstr);
			
			main.addEventListener("pyFinishTouch",finishTouched);
			main.addEventListener("pyCrashCollision",crashCollision);
			
			this.initBoom();
		}
		
		
		
		public function loadLevel():void
		{
			this.createPlayer();
			this.createPlatform();
			this.createCoins();
			
			// Create Floor
			var floor:Body = new Body(BodyType.STATIC);
			floor.shapes.add(new Polygon(Polygon.rect(-100,760,1200,200))); 	//bottom
			floor.space = main.space;
			floor.cbTypes.add(main.collision);
			
			// Move Particles to front
			swapChildren(player, platform);
			
			
		}
		
		// Create Coins
		private function createCoins():void
		{
			coins = new Sprite();
			for each(var c:Object in _xml.Objects.coin)
			{
				//trace("Bla:"+c.@id);
				var coin:Coin = new Coin(main,{
					x:c.@x,
					y:c.@y
				});
				coins.addChild(coin);
			}
			addChild(coins);
		}
		
		// Create Player
		private function createPlayer():void
		{
			player = new Player(main,{
					x:_xml.Objects.player.attribute("x"),
					y:_xml.Objects.player.attribute("y")
				});
			main.player = player;
			addChild(player);
		}
		
		// Create Finish Platform
		private function createPlatform():void
		{
			platform = new Platform(main.space,main.stage,main,{
				x:_xml.Objects.platform.attribute("x"),
				y:_xml.Objects.platform.attribute("y")
			});
			addChild(platform);
		}
		
		private function finishTouched(e:Event):void
		{
			if(!this.goodLanding)
				return;
			
			// TODO Auto Generated method stub
			trace("Finish Touched Inside Level Controller");
			main.space.listeners.remove(main.itListenerSensor);
		}
		
		private function crashCollision(e:Event):void
		{
			var vel:Number = Math.round(this.main.player.body.velocity.y);
			if(vel > -40 && vel < 40){
				this.goodLanding = true;
			}else{
				trace("crash");
				this.goodLanding = false;
				this.boomImage.visible = true;
				var t:Object = this;
				Sounds.playSound("boomSound");
				main.camera.shake(0.07,30);
				//main.player.consumeFuel(30);
				TweenLite.to(this.boomImage,0.7,{
					alpha:1,
					scaleX:1.5,
					scaleY:1.5,
					ease:Bounce.easeOut,
					onComplete:function():void
					{	
						trace("add Listener");
						main.space.listeners.add(main.itListener);
						t.initBoom();
					}
				});
				trace("remove listener");
				main.space.listeners.remove(main.itListener);
			}
			
		}
		
		
		private function initBoom():void
		{
			if(!boomImage)
			{
				boomImage = new Sprite();
				addChild(boomImage);
				boomImage.addChild(new Image(Assets.getAtlas().getTexture("boom")));
				boomImage.x = main.stage.stageWidth/2;
				boomImage.y = main.stage.stageHeight/2;
				boomImage.pivotX = boomImage.width 	>> 1;
				boomImage.pivotY = boomImage.height >> 1;
			}
			boomImage.visible = 0;
			boomImage.alpha = 0;
			boomImage.scaleX = 4;
			boomImage.scaleY = 4;
		}
		
	}
}