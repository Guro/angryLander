package Objects
{
	import com.greensock.TweenLite;
	import com.greensock.easing.Bounce;
	import com.greensock.easing.Elastic;
	
	import nape.callbacks.CbType;
	import nape.callbacks.InteractionListener;
	import nape.dynamics.InteractionFilter;
	import nape.geom.Vec2;
	import nape.phys.Body;
	import nape.phys.BodyType;
	import nape.phys.Material;
	import nape.shape.Polygon;
	import nape.space.Space;
	
	import starling.display.Image;
	import starling.display.Sprite;
	
	
	public class Platform extends Sprite
	{
		[Embed(source="../Assets/mountain.png")]
		private var test:Class;	
	
		public var body:Body;
		public var options:Object;
		
		
		private var collision:CbType = new CbType();
		private var sensor:CbType = new CbType();
		private var container:Sprite;
		private var main:Main;
		private var space:Space;
		private var itListener:InteractionListener;
		private var itListenerSensor:InteractionListener;
		private var stage:Object;
		
		
		private var goodLanding:Boolean = false;
		
		public function Platform(sp:Space,st,mn:Main,opts:Object)
		{
			this.main = mn;
			this.space = sp;
			this.stage = st;
			this.options = opts;
			
			// Gnereate graphics object
			container = new Sprite();
			
		
			
			var playerImage:Image = new Image(Assets.getAtlas().getTexture("platform"));
			container.addChild(playerImage);
			
			
			
			
			// Correct Pivots
			playerImage.x	-= playerImage.width/2;
			playerImage.y	-= playerImage.height/2;
			
			
			
			//Create Physics Body
//			this.body = new Body(BodyType.STATIC,new Vec2(options.x,options.y));
//			this.body.shapes.add(new Polygon(Polygon.rect(-75,-10,150,20),new Material(0)));
//			this.body.space = space;
//			this.body.graphic 			= container;
//			this.body.graphicUpdate 	= updateGraphics;
//			this.body.cbTypes.add(main.collision);
			
		
			
			this.body = PyDataPlatform.createBody("platform");
			this.body.position = new Vec2(options.x,options.y);
			this.body.space   = space;
			this.body.cbTypes.add(main.collision);
			this.body.graphic 			= container;
			this.body.graphicUpdate 	= updateGraphics;
			
			var fn:Body = new Body(BodyType.STATIC,new Vec2(options.x,options.y-20));
			var p:Polygon = new Polygon(Polygon.rect(-20,-5,40,10),null,new InteractionFilter(0));
			fn.shapes.add(p);
			fn.space = space;
			fn.cbTypes.add(main.sensor);
			
			

			
			
			
			addChild(this.body.graphic);
			
		}
		
		
		private function updateGraphics(b:Body):void
		{
			b.graphic.x 		= b.position.x;
			b.graphic.y 		= b.position.y;
			b.graphic.rotation	= b.rotation;
		}
	
	
	}
}