package
{
	import flash.display.Bitmap;
	import flash.utils.Dictionary;
	
	import starling.textures.Texture;
	import starling.textures.TextureAtlas;

	public class Assets
	{
	
		private static var gameTextures:Dictionary = new Dictionary();
		private static var gameTextureAtlas:TextureAtlas;
		private static var gameTextureAtlasLight:TextureAtlas;
		
		[Embed(source="assets/spriteSheet.png")]
		public static const AtlasTextureGame:Class;
		[Embed(source="assets/spriteSheet.xml", mimeType="application/octet-stream")]
		public static const AtlasXmlGame:Class;
		
		[Embed(source="assets/lightSheet.png")]
		public static const AtlasTextureLight:Class;
		[Embed(source="assets/lightSheet.xml", mimeType="application/octet-stream")]
		public static const AtlasXmlLight:Class;
		
		
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
				var bitmap:Bitmap = new Assets[name]();
				gameTextures[name] = Texture.fromBitmap(bitmap);
			}
			return gameTextures[name];
		}
	}
}