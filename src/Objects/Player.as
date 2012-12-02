package Objects
{
	
	import com.greensock.TweenLite;
	
	import nape.geom.Vec2;
	import nape.phys.Body;
	import nape.phys.BodyType;
	import nape.phys.Material;
	import nape.shape.Circle;
	
	import starling.core.Starling;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.extensions.PDParticleSystem;
	import starling.textures.Texture;
	
	
	
	public class Player extends Sprite
	{
		
		
		[Embed(source="../Assets/particles/particle.pex", mimeType="application/octet-stream")]
		private static const windConfig:Class; 
		
		[Embed(source = "../Assets/particles/texture.png")]
		private static const windParticle:Class; 
		
		public var body:Body;
		public var mParticleSystem:PDParticleSystem;
		public var options:Object;
		public var fuel:Number = 100;
		public var fuelConsumption:Number = 0.05;
		
		public var container:Sprite;
		private var main:Main;
		
		public function Player(mn:Main,opts:Object)
		{
			options = opts;
			main	= mn;
			
			
			// Gnereate graphics object
			container = new Sprite();
			
			// Generate Particle
			var drugsConfig:XML = XML(new windConfig());
			var drugsTexture:Texture = Texture.fromBitmap(new windParticle());
			
			mParticleSystem = new PDParticleSystem(drugsConfig, drugsTexture);
//			addChild(mParticleSystem);
			mParticleSystem.alpha = 0.5;
			
			var playerImage:Image = new Image(Assets.getAtlas().getTexture("pl"));
			container.addChild(playerImage);
			
		
			
			// Correct Positions
			playerImage.x -= playerImage.width/2;
			playerImage.y -= playerImage.height/2;
			
			
			
		
			
			//Create Physics Body
			this.body = new Body(BodyType.DYNAMIC,new Vec2(options.x,options.y));
			//this.body.shapes.add(new Polygon(Polygon.rect(-50,-35,100,70),new Material(1)));
			this.body.shapes.add(new Circle(40,null,new Material(1)));
			this.body.space = main.space;
			this.body.graphic 			= container;
			this.body.graphicUpdate 	= updateGraphics;
			
			// Add cbTypes
			
			this.body.cbTypes.add(main.collision);
			this.body.cbTypes.add(main.sensor);
			
			addChild(this.body.graphic);
		}
		
		private function updateGraphics(b:Body):void
		{
			b.graphic.x 		= b.position.x;
			b.graphic.y 		= b.position.y;
			b.graphic.rotation	= b.rotation;
			mParticleSystem.emitterX = b.position.x;
			mParticleSystem.emitterY = b.position.y;
			
		}
		
		public function consumeFuel(consume:Number):void
		{
			fuel = fuel - consume;
			main.controls.gauge.ratio = fuel/100;	
		}
		
		public function moveUp():void
		{
			this.body.applyLocalForce(new Vec2(0,-3000),new Vec2(0,0));
			this.startParticles();
			TweenLite.to(this.body,1,{rotation:0});
			consumeFuel(fuelConsumption);
		}
		
		public function moveLeft():void
		{
			this.body.applyLocalForce(new Vec2(-1000,-2200),new Vec2(0,0));
			
			
			
			this.startParticles();
			//this.body.rotation = -0.1;
			this.body.graphic.scaleX = -1;
			TweenLite.to(this.body,1,{rotation:-0.3});
			consumeFuel(fuelConsumption);
		}
		
		public function moveRight():void
		{
			this.body.applyLocalForce(new Vec2(1000,-2200),new Vec2(0,0));
			this.startParticles();
			this.body.graphic.scaleX = 1;
			TweenLite.to(this.body,1,{rotation:0.3});
			consumeFuel(fuelConsumption);
		}
		
		
		public function startParticles():void
		{
			mParticleSystem.maxNumParticles = 50;
			
			// add it to the stage and the juggler
			Starling.juggler.add(mParticleSystem);
			
			// start emitting particles
			mParticleSystem.start();
		}
		
		public function stopParticles():void
		{
			
			mParticleSystem.maxNumParticles = 5;
			
			TweenLite.to(this.body,1,{rotation:0,onComplete:function():void{
					// Remove From Juggler
					Starling.juggler.remove(mParticleSystem);
					mParticleSystem.stop();
					trace("Completed");
				}});
			Sounds.stopSound("shhSound");
		}
	}
}