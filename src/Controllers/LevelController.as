package Controllers
{
	
	
	import com.greensock.TweenLite;
	import com.greensock.easing.Bounce;
	
	import flash.utils.ByteArray;
	import flash.utils.getDefinitionByName;
	
	import Objects.Coin;
	import Objects.Lightning;
	import Objects.Platform;
	import Objects.Player;
	
	import Screens.Game;
	
	import assets.levels.level1Data;
	import assets.levels.level2Data;
	
	import nape.geom.Vec2;
	import nape.phys.Body;
	import nape.phys.BodyType;
	import nape.shape.Circle;
	import nape.shape.Polygon;
	
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Event;
	
	public class LevelController extends Sprite
	{
		
		
		// Level Data Classes
		private var level1DataClass:level1Data;
		private var level2DataClass:level2Data;
		
		
		
		
		
		
		
		public var player:Player;
		public var platform:Platform;
		public var coins:Sprite;
		public var main:Game;
		public var score:Number = 0;
		public var levelNumber:int;
		public var decorImage:Image;
		
		
		private var _xml:XML;
		private var goodLanding:Boolean = false;
		private var boomImage:Sprite;
		private var finished:Boolean = false;
		
		
		public function LevelController(mn:Game)
		{
			main = mn;	
			
			main.addEventListener("pyFinishTouch",finishTouched);
			main.addEventListener("pyCrashCollision",crashCollision);
			
			
		}
		
		
		
		public function loadLevel(lvlNumber:int):void
		{
			this.levelNumber = lvlNumber;
			_xml =  new XML(AssetsController.getByteArray("level"+this.levelNumber));
		
			this.createLights();
			
			// Create Decor
			decorImage = new Image(AssetsController.getTexture("level"+this.levelNumber+"Decor"));
			addChild(decorImage);
			
			
			
			this.createPlayer();
			this.createCoins();
			this.createMounts();
			
			
			// Create Borders
			var borders:Body = new Body(BodyType.STATIC);
			borders.shapes.add(new Polygon(Polygon.rect(-30,-10,20,800))); 		//left
			borders.space = main.space;
			
			
			
			
			/*
			Temporarry Stone
			*/
			var bgImg:Image = new Image(AssetsController.getTexture("tmp"));
			//correct bg pos
			addChild(bgImg);
			bgImg.pivotX = 70;
			bgImg.pivotY = 70;
			
			
			var floor:Body = new Body(BodyType.DYNAMIC,new Vec2(1000,200));
			floor.shapes.add(new Circle(70)); 	//bottom
			floor.space = main.space;
			floor.mass = 1.5;
			floor.graphic = bgImg;
			floor.graphicUpdate = updateGraphics;
			
		}
		
		// Create obstacles
		private function createMounts():void
		{
			// Get Level Data Class
			var dataClass:Class = getDefinitionByName("assets.levels.level"+this.levelNumber+"Data") as Class;
			
			// Create Mounts
			trace("Create Mounts:");
			for each(var c:Object in _xml.Objects.mount)
			{
				trace(c.@id);
				var b:Body = dataClass.createBody(c.@id);
				b.position = new Vec2(c.@x,c.@y);
				b.space   = main.space;
				b.cbTypes.add(main.collision);
			}	
		}
		
		// Update Graphics for templorarry stone
		private function updateGraphics(b:Body):void
		{
			b.graphic.x 		= b.position.x;
			b.graphic.y 		= b.position.y;
			b.graphic.rotation	= b.rotation;
			
		}
		
		
		// Create Lights
		private function createLights():void
		{
			for each(var c:Object in _xml.Objects.lightning)
			{
				var light:Lightning = new Lightning(main,{
					x:c.@x,
					y:c.@y
				});
				addChild(light);
			}
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
			main.addEventListener("coinCollected",coinCollected);
		}
		
		
		
		
		private function coinCollected():void
		{
			score++;
			trace("Score: "+score);
			if(score == 2)
				this.createPlatform();
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
			// Move Particles to front
			swapChildren(player, platform);
		}
		
		private function finishTouched(e:Event):void
		{
			if(!this.goodLanding)
				return;
			if(this.finished)
				return;
			
			trace("Finish Touched Inside Level Controller");
			this.finished = true;
			main.space.listeners.remove(main.itListenerSensor);
			TweenLite.to(main.player,1,{alpha:0,delay:1.5});
			TweenLite.to(platform.body.graphic,1,{alpha:0,delay:1.5,onComplete:function():void{
				main.finishLevel();
			}});
			
			
			
		}
		
		private function crashCollision(e:Event):void
		{
			var vel:Number = Math.round(this.main.player.body.velocity.y);
			if(vel > -40 && vel < 40){
				this.goodLanding = true;
			}else{
				trace("crash");
				player.consumeHP(34);
				this.goodLanding = false;


				//Sounds.playSound("boomSound");
				main.camera.shake(0.07,30);
				//main.player.consumeFuel(30);
				
				//trace("remove listener");
				//main.space.listeners.remove(main.itListener);
			}
			
		}
		
		
		
	}
}