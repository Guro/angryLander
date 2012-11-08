package Objects
{
	import com.greensock.TweenLite;
	import com.greensock.easing.Bounce;
	import com.greensock.easing.Elastic;
	
	import flash.display.DisplayObject;
	import flash.display.Stage;
	
	import nape.callbacks.CbEvent;
	import nape.callbacks.CbType;
	import nape.callbacks.InteractionCallback;
	import nape.callbacks.InteractionListener;
	import nape.callbacks.InteractionType;
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
		private var boomImage:Sprite;
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
			this.body = new Body(BodyType.STATIC,new Vec2(options.x,options.y));
			this.body.shapes.add(new Polygon(Polygon.rect(-75,-10,150,20),new Material(0)));
			this.body.space = space;
			this.body.graphic 			= container;
			this.body.graphicUpdate 	= updateGraphics;
			this.body.cbTypes.add(collision);
			
			var fn:Body = new Body(BodyType.STATIC,new Vec2(options.x,options.y-5));
			var p:Polygon = new Polygon(Polygon.rect(-20,-5,40,10),null,new InteractionFilter(0));
			fn.shapes.add(p);
			fn.space = space;
			fn.cbTypes.add(sensor);
			
			
			// Add Interaction Listenrs to player
			this.main.player.body.cbTypes.add(collision);
			this.main.player.body.cbTypes.add(sensor);
			
			
			
			var mount:Body = PhysicsData.createBody("mountain");
			mount.graphic = Image.fromBitmap(new test());
			mount.space   = space;
			mount.cbTypes.add(collision);
			mount.graphicUpdate = updateGraphics2;
			addChild(mount.graphic);
			
			
			
			addChild(this.body.graphic);
			
			this.itListener = new InteractionListener(CbEvent.ONGOING, InteractionType.COLLISION,collision,collision,crashCollision);
			space.listeners.add(itListener);
			
			this.itListenerSensor = new InteractionListener(CbEvent.ONGOING,InteractionType.SENSOR,sensor,collision,finishTouch);
			space.listeners.add(itListenerSensor);
			
			this.initBoom();
			
		}
		
		private function finishTouch(cb:InteractionCallback):void
		{
			if(!this.goodLanding)
				return;
			
			trace ("FINISH");
			space.listeners.remove(itListenerSensor);
		}
		
		private function crashCollision(cb:InteractionCallback):void
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
														t.space.listeners.add(itListener);
														t.initBoom();
													}
												});
				this.space.listeners.remove(itListener);
			}
			
		}
		
		private function updateGraphics(b:Body):void
		{
			b.graphic.x 		= b.position.x;
			b.graphic.y 		= b.position.y;
			b.graphic.rotation	= b.rotation;
		}
		
		private function updateGraphics2(b:Body):void
		{
			b.graphic.x 		= b.position.x-b.bounds.width/2;
			b.graphic.y 		= (b.position.y-b.bounds.height/2)-23;
			b.graphic.rotation	= b.rotation/2;
		}
		
		private function initBoom():void
		{
			if(!boomImage)
			{
				boomImage = new Sprite();
				addChild(boomImage);
				boomImage.addChild(new Image(Assets.getAtlas().getTexture("boom")));
				boomImage.x = this.stage.stageWidth/2;
				boomImage.y = this.stage.stageHeight/2;
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