package
{
	import com.joeonmars.camerafocus.StarlingCameraFocus;
	
	import flash.display.MovieClip;
	
	import Objects.Player;
	
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
		
		//Interaction Filters
		//public var sensorFilter:InteractionFilter = new InteractionFilter(0,0,1);
		
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
			stageCont.addChild(bgImg);
			
			
			
			
			
			
			// Space
			space 		= new Space(new Vec2(0,300));
			space.worldLinearDrag = 1;
			space.worldAngularDrag = 1;
			
			
			// Debug Draw
			this.debugDraw();
			
			var floor:Body = new Body(BodyType.STATIC);
			floor.shapes.add(new Polygon(Polygon.rect(-100,760,1200,200))); 	//bottom
			floor.space = space;
			
			addEventListener(Event.ENTER_FRAME, loop)
			
			
			// Level Controller
			var lv:LevelController = new LevelController(this);
			lv.loadLevel();
			stageCont.addChild(lv);
			
			
			
			// Camera
			Starling.current.stage.addChild(stageCont);
			camera = new StarlingCameraFocus( Starling.current.stage, stageCont,
				player, [ {name:'bg',instance:bgImg,ratio:0.1}
				], true );
			camera.setFocusPosition(0,0);
			
			this.createControls();
			//Sounds.playSound("loopSound",9999);
			
		}
		
		
		
		// Create Controls
		private function createControls():void
		{
			controls = new Controls(this); 
			stageCont.addChild(controls);
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
	
	}
}