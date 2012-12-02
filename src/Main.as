package
{
	import com.greensock.TweenLite;
	import com.greensock.easing.Bounce;
	import com.joeonmars.camerafocus.StarlingCameraFocus;
	
	import flash.display.MovieClip;
	
	import Objects.Player;
	
	import nape.callbacks.CbEvent;
	import nape.callbacks.CbType;
	import nape.callbacks.InteractionCallback;
	import nape.callbacks.InteractionListener;
	import nape.callbacks.InteractionType;
	import nape.dynamics.InteractionFilter;
	import nape.geom.Vec2;
	import nape.phys.Body;
	import nape.phys.BodyType;
	import nape.shape.Polygon;
	import nape.space.Space;
	import nape.util.ShapeDebug;
	
	import starling.core.Starling;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Event;
	
	public class Main extends Sprite
	{
		[Embed(source="Assets/bg.jpg")]
		private var bg:Class;
		
		[Embed(source="Assets/tmp.png")]
		private var tmp:Class;
		
		public var space:Space;
		private var mouseX:Number;
		private var mouseY:Number;
		private var debugSpace:ShapeDebug;
		private var debug:ShapeDebug;
		
		
		public var controls:Controls;
		public var enableDebugDraw:Boolean = false;
		public var mouseDown:Boolean;
		public var playerAction:Function;
		public var player:Player;
		public var stageCont:Sprite;
		public var camera:StarlingCameraFocus;
		
		// Physics Listeners
		public var collision:CbType = new CbType();
		public var sensor:CbType = new CbType();
		public var itListener:InteractionListener;
		public var itListenerSensor:InteractionListener;
		
		public function Main()
		{
			addEventListener(Event.ADDED_TO_STAGE,onAdded);
		}
		
		private function onAdded(e:Event):void
		{
			trace("Added To Stage");
			stageCont = new Sprite();
			var bgImg:Image = Image.fromBitmap(new bg());
			//correct bg pos
			bgImg.x = -50;
			bgImg.y = -50;
			addChild(bgImg);
			
			
			var tmpImg:Image = Image.fromBitmap(new tmp());
			stageCont.addChild(tmpImg);
			
			
			
			// Space
			space 		= new Space(new Vec2(0,300));
			space.worldLinearDrag = 1;
			space.worldAngularDrag = 1;
			this.initPyListeners();
			
			// Debug Draw
			this.debugDraw();
		
			
			addEventListener(Event.ENTER_FRAME, loop)
			
			
			// Level Controller
			var lv:LevelController = new LevelController(this);
			lv.loadLevel();
			stageCont.addChild(lv);
			
			
			
			// Camera
			Starling.current.stage.addChild(stageCont);
			camera = new StarlingCameraFocus( Starling.current.stage, stageCont,
				player.container, [ {name:'bg',instance:bgImg,ratio:0.03}
				], true );
			//camera.setFocusPosition(0,0);
			
			this.createControls();
			
			
			
			//Sounds.playSound("loopSound",9999);
			//camera.zoomFocus(1);
			camera.setBoundary(tmpImg);
			
			
			
			var b:Body = PyDataLv1.createBody("tmp");
			b.position = new Vec2(1080,120);
			b.space   = space;
			b.cbTypes.add(collision);
			
			
			b = PyDataLv1.createBody("tmp2");
			b.position = new Vec2(895,615);
			b.space   = space;
			b.cbTypes.add(collision);
			
		}
		
		// Create Controls
		private function createControls():void
		{
			controls = new Controls(this); 
			Starling.current.stage.addChild(controls);
		}
		
	
	
		// Main Loop
		private function loop(e:Event):void
		{			
			if(mouseDown)
			{
				// This function is called from child classes
				playerAction();
			}
			if(player.fuel <= 0){
				controls.disableControls();
				controls.dispose();
			}
			
			
			camera.update();
			space.step(1/60);
			
			
			if(this.enableDebugDraw)
			{
				debug.clear();
				debug.draw(space);
				debug.flush();
			}
		}
		
		// Debug Draw
		private function debugDraw():void
		{
			if(!this.enableDebugDraw)
				return;
			debug = new ShapeDebug(800, 480, 0x33333333);
			debug.draw(space);
			var MovieClipDebug:flash.display.MovieClip = new flash.display.MovieClip();
			MovieClipDebug.addChild(debug.display);
			Starling.current.nativeOverlay.addChild(MovieClipDebug);
		}
		
		// Phisics listeners
		private function initPyListeners():void
		{	
			this.itListener = new InteractionListener(CbEvent.ONGOING, InteractionType.COLLISION,this.collision,this.collision,crashCollision);
			this.space.listeners.add(itListener);
			
			this.itListenerSensor = new InteractionListener(CbEvent.ONGOING,InteractionType.SENSOR,this.sensor,this.collision,pyFinishTouch);
			this.space.listeners.add(itListenerSensor);
		}
		
		private function pyFinishTouch(cb:InteractionCallback):void
		{	
			this.dispatchEvent(new Event("pyFinishTouch"));
		}
		
		private function crashCollision(cb:InteractionCallback):void
		{
			this.dispatchEvent(new Event("pyCrashCollision"));
		}
	}
}