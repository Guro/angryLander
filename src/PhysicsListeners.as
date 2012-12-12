package
{
	import nape.callbacks.CbEvent;
	import nape.callbacks.CbType;
	import nape.callbacks.InteractionCallback;
	import nape.callbacks.InteractionListener;
	import nape.callbacks.InteractionType;
	
	import starling.events.Event;
	import Screens.Game;

	public class PhysicsListeners
	{
		public var collision:CbType = new CbType();
		public var sensor:CbType = new CbType();
		
		
		public var itListener:InteractionListener;
		public var itListenerSensor:InteractionListener;
		
		
		public var main:Game;
		
		public function PhysicsListeners(mn:Game)
		{
			
			this.main = mn;
			
			
			// Add Listeners
			this.itListener = new InteractionListener(CbEvent.ONGOING, InteractionType.COLLISION,this.collision,this.collision,crashCollision);
			this.main.space.listeners.add(itListener);
			
			this.itListenerSensor = new InteractionListener(CbEvent.ONGOING,InteractionType.SENSOR,sensor,collision,finishTouch);
			this.main.space.listeners.add(itListenerSensor);
		}
		
		private function finishTouch(cb:InteractionCallback):void
		{
			trace ("FINISH");
			this.main.space.listeners.remove(itListenerSensor);
		}
	}
}