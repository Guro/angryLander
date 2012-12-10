package
{
	import com.joeonmars.camerafocus.StarlingCameraFocus;
	
	import flash.display.MovieClip;
	
	import Objects.Player;
	
	import nape.callbacks.CbEvent;
	import nape.callbacks.CbType;
	import nape.callbacks.InteractionCallback;
	import nape.callbacks.InteractionListener;
	import nape.callbacks.InteractionType;
	import nape.geom.Vec2;
	import nape.space.Space;
	import nape.util.ShapeDebug;
	
	import starling.core.Starling;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.filters.SpotlightFilter;
	
	public class Main extends Sprite
	{
		[Embed(source="Assets/bg.jpg")]
		private var bg:Class;
		
		public var space:Space;
		private var mouseX:Number;
		private var mouseY:Number;
		private var debugSpace:ShapeDebug;
		private var debug:ShapeDebug;
		private var curLevel:int = 1;
		private var maxLevels:int = 2;
		
		public var controls:Controls;
		public var enableDebugDraw:Boolean = false;
		public var mouseDown:Boolean;
		public var playerAction:Function;
		public var playerAction2:Function;
		public var player:Player;
		public var stageCont:Sprite;
		public var camera:StarlingCameraFocus;
		
		
		// Physics Listeners
		public var collision:CbType = new CbType();
		public var sensor:CbType = new CbType();
		public var itListener:InteractionListener;
		public var itListenerSensor:InteractionListener;
		private var lv:LevelController;
		private var sF:SpotlightFilter;
		
		public function Main()
		{
			addEventListener(Event.ADDED_TO_STAGE,onAdded);
		}
		
		private function onAdded(e:Event):void
		{
			trace("Added To Stage");
			stageCont = new Sprite()
			stageCont.touchable = false;	
			
			
			var bgImg:Image = Image.fromBitmap(new bg());
			//correct bg pos
			bgImg.x = -400;
			bgImg.y = -200;
			bgImg.touchable = false;
			addChild(bgImg);
			
			
			
			
			
			
			// Space
			space 		= new Space(new Vec2(0,300));
			space.worldLinearDrag = 1;
			space.worldAngularDrag = 1;
			this.initPyListeners();
			
			// Debug Draw
			this.debugDraw();
			
			// Enter Frame Loop	
			addEventListener(Event.ENTER_FRAME, loop)
			
			// Generate Level
			this.createLevel();
			
			
			
			// Camera
			Starling.current.stage.addChild(stageCont);
			camera = new StarlingCameraFocus( Starling.current.stage, stageCont,
				player.container, [ {name:'bg',instance:bgImg,ratio:0.1}
				], true );
			//camera.setFocusPosition(0,0);
			
			this.createControls();
			
			//sF = new SpotlightFilter(0,0,1,3,0.6);
			//stageCont.filter = sF;
			//bgImg.filter = sF;
//			
			

			
			//Sounds.playSound("loopSound",9999);
			//camera.zoomFocus(0.7);
			
			camera.setBoundary(lv.decorImage);
			
			
			
			
		}
		
		// Create Controls
		private function createControls():void
		{
			controls = new Controls(this); 
			Starling.current.stage.addChild(controls);
		}
		
		
		// Create Level
		public function createLevel():void
		{
			// Reset Level If Exists
			if(lv)
			{
				lv.dispose();
				stageCont.removeChild(lv);
				lv = null;
				space.clear();
				space = null;
				space 		= new Space(new Vec2(0,300));
				space.worldLinearDrag = 1;
				space.worldAngularDrag = 1;
				this.initPyListeners();
				this.curLevel++;
				if(this.curLevel > this.maxLevels)
					this.curLevel = 1;
			}
			
			
			//Create Level
			lv = new LevelController(this);
			lv.loadLevel(curLevel);
			stageCont.addChild(lv);
			
			
			
			if(camera){
				camera.focusTarget = player.container;
				camera.setBoundary(lv.decorImage);
			}
		}
		
		
		// Main Loop
		private function loop(e:Event):void
		{			
			if(mouseDown)
			{
				// This function is called from child classes
				if(this.playerAction)
					playerAction();
				
				if(this.playerAction2)
					playerAction2();
			}
			if(player.fuel <= 0){
				controls.disableControls();
				controls.dispose();
			}
			
			if(player.hp <= 0){
				controls.disableControls();
				controls.dispose();
			}
			
//			sF.centerX = player.body.graphic.x;
//			sF.centerY = player.body.graphic.y;
			
			
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