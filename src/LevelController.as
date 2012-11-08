package
{
	
	import flash.utils.ByteArray;
	
	import Objects.Coin;
	import Objects.Platform;
	import Objects.Player;
	
	import starling.display.Sprite;

	public class LevelController extends Sprite
	{
		
		[Embed(source="assets/levels/level1.oel", mimeType="application/octet-stream")]
		public static const level1:Class;
		
		
		public var player:Player;
		public var platform:Platform;
		public var coins:Sprite;
		
		public var main:Main;
		private var _xml:XML;
		
		public function LevelController(mn:Main)
		{
			main = mn;	
			
			
			var contentfile:ByteArray = new level1();
			var contentstr:String = contentfile.readUTFBytes( contentfile.length );
			_xml =  new XML(contentstr);
			
		}
		
		public function loadLevel():void
		{
			this.createPlayer();
			this.createPlatform();
			this.createCoins();
			
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
	}
}