package Controllers
{
	import flash.display.Bitmap;
	import flash.utils.ByteArray;
	import flash.utils.Dictionary;
	
	import assets.levels.level1Data;
	
	import starling.textures.Texture;
	import starling.textures.TextureAtlas;

	public class AssetsController
	{
	
		private static var gameTextures:Dictionary = new Dictionary();
		private static var gameByteArrays:Dictionary = new Dictionary();
		private static var gameTextureAtlas:TextureAtlas;
		private static var gameTextureAtlasLight:TextureAtlas;
		
		[Embed(source="/assets/spriteSheet.png")]
		public static const AtlasTextureGame:Class;
		[Embed(source="/assets/spriteSheet.xml", mimeType="application/octet-stream")]
		public static const AtlasXmlGame:Class;
		
		[Embed(source="/assets/lightSheet.png")]
		public static const AtlasTextureLight:Class;
		[Embed(source="/assets/lightSheet.xml", mimeType="application/octet-stream")]
		public static const AtlasXmlLight:Class;
		
//		[Embed(source="/assets/TOONISH.ttf", fontFamily="Toonish", embedAsCFF="false")]
//		public static var fontToonish:Class;
		
		[Embed(source="/assets/bg.jpg")]
		public static const bg:Class;
		
		[Embed(source="/assets/tmpStone.png")]
		public static const tmp:Class;
		
		[Embed(source = "../Assets/particles/texture.png")]
		private static const windParticle:Class; 
		
		
		[Embed(source="../Assets/particles/particle.pex", mimeType="application/octet-stream")]
		private static const windConfig:Class; 
		
		/* Levels */
		[Embed(source="/assets/levels/level1.oel", mimeType="application/octet-stream")]
		public static const level1:Class;
		[Embed(source="/assets/levels/level1Decor.png")]
		public static const level1Decor:Class;
		
		[Embed(source="/assets/levels/level2.oel", mimeType="application/octet-stream")]
		public static const level2:Class;
		[Embed(source="/assets/levels/level2Decor.png")]
		public static const level2Decor:Class;
		
		
		public static function getAtlas():TextureAtlas
		{
			if (gameTextureAtlas == null)
			{
				var texture:Texture = getTexture("AtlasTextureGame");
				var xml:XML = XML(new AtlasXmlGame());
				gameTextureAtlas = new TextureAtlas(texture, xml);
			}
			return gameTextureAtlas;
		}
		
		public static function getAtlas2():TextureAtlas
		{
			if (gameTextureAtlasLight == null)
			{	
				var texture:Texture = getTexture("AtlasTextureLight");
				var xml:XML = XML(new AtlasXmlLight());
				gameTextureAtlasLight = new TextureAtlas(texture, xml);
			}
			return gameTextureAtlasLight;
		}

		public static function getTexture(name:String):Texture
		{
			if (gameTextures[name] == undefined)
			{
				var bitmap:Bitmap = new AssetsController[name]();
				gameTextures[name] = Texture.fromBitmap(bitmap);
			}
			return gameTextures[name];
		}
		
		public static function getByteArray(name:String):String
		{
			if (gameByteArrays[name] == undefined)
			{
				var contentfile:ByteArray = new AssetsController[name]();
				var contentstr:String = contentfile.readUTFBytes(contentfile.length);
				gameByteArrays[name] = contentfile;
			}
			return gameByteArrays[name];
		}
	}
}