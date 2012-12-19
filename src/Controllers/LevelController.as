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
	import assets.levels.level3Data;
	import assets.levels.level4Data;
	
	import nape.constraint.PivotJoint;
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
		private var level3DataClass:level3Data;
		private var level4DataClass:level4Data;
		
		
		
		
		
		
		
		public var player:Player;
		public var platform:Platform;
		public var coins:Sprite;
		public var game:Game;
		public var score:Number = 0;
		public var levelNumber:int;
		public var decorImage:Image;
		
		
		private var _xml:XML;
		private var goodLanding:Boolean = false;
		private var boomImage:Sprite;
		private var finished:Boolean = false;
		private var handJoint:PivotJoint;
		
		
		public function LevelController(mn:Game)
		{
			game = mn;	
			
			game.addEventListener("pyFinishTouch",finishTouched);
			game.addEventListener("pyCrashCollision",crashCollision);
			
			
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
			borders.space = game.space;
			
			
			
			
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
			floor.space = game.space;
			floor.mass = 1.5;
			floor.userData.graphic = bgImg;
			floor.userData.graphicUpdate = updateGraphics;
			
//			handJoint = new PivotJoint(game.space.world, null, Vec2.weak(), Vec2.weak());
//			handJoint.space = game.space;
//			handJoint.active = false;
			//handJoint.stiff = false;
			
			
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
				b.space   = game.space;
				b.cbTypes.add(game.collision);
			}	
		}
		
		// Update Graphics for templorarry stone
		private function updateGraphics(b:Body):void
		{
			b.userData.graphic.x 		= b.position.x;
			b.userData.graphic.y 		= b.position.y;
			b.userData.graphic.rotation	= b.rotation;
			
		}
		
		
		// Create Lights
		private function createLights():void
		{
			for each(var c:Object in _xml.Objects.lightning)
			{
				var light:Lightning = new Lightning(game,{
					x:c.@x,
					rotation:c.@rotation,
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
				var coin:Coin = new Coin(game,{
					x:c.@x,
					y:c.@y
				});
				coins.addChild(coin);
			}
			addChild(coins);
			game.addEventListener("coinCollected",coinCollected);
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
			player = new Player(game,{
				x:_xml.Objects.player.attribute("x"),
				y:_xml.Objects.player.attribute("y")
			});
			game.player = player;
			addChild(player);
			
		}
		
		// Create Finish Platform
		private function createPlatform():void
		{
			platform = new Platform(game.space,game.stage,game,{
				x:_xml.Objects.platform.attribute("x"),
				y:_xml.Objects.platform.attribute("y")
			});
			addChild(platform);
			// Move Particles to front
			swapChildren(player, platform);
		}
		
		private function finishTouched(e:Event):void
		{
			trace("Finish Touched");
			if(!this.goodLanding)
				return;
			if(this.finished)
				return;
			
			trace("With Good Landing");
			this.finished = true;
			game.space.listeners.remove(game.itListenerSensor);
			TweenLite.to(game.player,1,{alpha:0,delay:1.5});
			TweenLite.to(platform.body.userData.graphic,1,{alpha:0,delay:1.5,onComplete:function():void{
				game.finishLevel();
			}});
			
			
			
		}
		
		private function crashCollision(e:Event):void
		{
			
			var vel:Number = Math.round(this.game.player.body.velocity.y);
			if(vel > -40 && vel < 40){
				this.goodLanding = true;
			}else{
				trace("crash");
				player.consumeHP(34);
				this.goodLanding = false;


				//Sounds.playSound("boomSound");
				game.camera.shake(0.07,30);
				//game.player.consumeFuel(30);
				
				//trace("remove listener");
				//game.space.listeners.remove(game.itListener);
			}
			
		}
		
		
		
	}
}