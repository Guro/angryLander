package {

import flash.display.DisplayObject;
import flash.geom.Rectangle;
import flash.utils.Dictionary;

import nape.callbacks.CbType;
import nape.dynamics.InteractionFilter;
import nape.geom.AABB;
import nape.geom.Vec2;
import nape.phys.Body;
import nape.phys.BodyType;
import nape.phys.FluidProperties;
import nape.phys.Material;
import nape.shape.Circle;
import nape.shape.Polygon;
import nape.shape.Shape;

public class PhysicsData {

	public static function createBody(name:String,graphic:DisplayObject=null):Body {
		var xret:BodyPair = lookup(name);
		if(graphic==null) return xret.body.copy();

		var ret:Body = xret.body.copy();
		graphic.x = graphic.y = 0;
		graphic.rotation = 0;
		var bounds:Rectangle = graphic.getBounds(graphic);
		var offset:Vec2 = Vec2.get(bounds.x-xret.anchor.x, bounds.y-xret.anchor.y);

		ret.graphic = graphic;
		ret.graphicUpdate = function(b:Body):void {
			var gp:Vec2 = b.localToWorld(offset);
			graphic.x = gp.x;
			graphic.y = gp.y;
			graphic.rotation = (b.rotation*180/Math.PI)%360;
		}	

		return ret;
	}

	public static function registerMaterial(name:String,material:Material):void {
		if(materials==null) materials = new Dictionary();
		materials[name] = material;	
	}
	public static function registerFilter(name:String,filter:InteractionFilter):void {
		if(filters==null) filters = new Dictionary();
		filters[name] = filter;
	}
	public static function registerFluidProperties(name:String,properties:FluidProperties):void {
		if(fprops==null) fprops = new Dictionary();
		fprops[name] = properties;
	}
	public static function registerCbType(name:String,cbType:CbType):void {
		if(types==null) types = new Dictionary();
		types[name] = cbType;
	}

	//----------------------------------------------------------------------	

	private static var bodies   :Dictionary;
	private static var materials:Dictionary;
	private static var filters  :Dictionary;
	private static var fprops   :Dictionary;
	private static var types    :Dictionary;
	private static function material(name:String):Material {
		if(name=="default") return new Material();
		else {
			if(materials==null || materials[name] === undefined)
				throw "Error: Material with name '"+name+"' has not been registered";
			return materials[name] as Material;
		}
	}
	private static function filter(name:String):InteractionFilter {
		if(name=="default") return new InteractionFilter();
		else {
			if(filters==null || filters[name] === undefined)
				throw "Error: InteractionFilter with name '"+name+"' has not been registered";
			return filters[name] as InteractionFilter;
		}
	}
	private static function fprop(name:String):FluidProperties {
		if(name=="default") return new FluidProperties();
		else {
			if(fprops==null || fprops[name] === undefined)
				throw "Error: FluidProperties with name '"+name+"' has not been registered";
			return fprops[name] as FluidProperties;
		}
	}
	private static function cbtype(name:String):CbType {
		if(name=="null") return null;
		else {
			if(types==null || types[name] === undefined)
				throw "Error: CbType with name '"+name+"' has not been registered";
			return types[name] as CbType;
		}	
	}

	private static function lookup(name:String):BodyPair {
		if(bodies==null) init();
		if(bodies[name] === undefined) throw "Error: Body with name '"+name+"' does not exist";
		return bodies[name] as BodyPair;
	}

	//----------------------------------------------------------------------	

	private static function init():void {
		bodies = new Dictionary();

		var body:Body;
		var mat:Material;
		var filt:InteractionFilter;
		var prop:FluidProperties;
		var cbType:CbType;
		var s:Shape;
		var anchor:Vec2;

		
			body = new Body(BodyType.STATIC);
			//body.cbTypes.add(cbtype("null"));

			
				mat = material("default");
				filt = filter("default");
				prop = fprop("default");
				cbType = cbtype("null");

				
					
						s = new Polygon(
							[   Vec2.weak(0,266.5)   ,  Vec2.weak(4.5,268)   ,  Vec2.weak(15.5,225)   ,  Vec2.weak(1.5,255)   ,  Vec2.weak(-0.5,261)   ],
							mat,
							filt
						);
						s.body = body;
						s.fluidEnabled = false;
						s.fluidProperties = prop;
						////s.cbTypes.add(cbType);
					
						s = new Polygon(
							[   Vec2.weak(596.5,272)   ,  Vec2.weak(599.5,267)   ,  Vec2.weak(599.5,261)   ,  Vec2.weak(595.5,252)   ,  Vec2.weak(590,273.5)   ],
							mat,
							filt
						);
						s.body = body;
						s.fluidEnabled = false;
						s.fluidProperties = prop;
						//s.cbTypes.add(cbType);
					
						s = new Polygon(
							[   Vec2.weak(590,273.5)   ,  Vec2.weak(595.5,252)   ,  Vec2.weak(594.5,235)   ,  Vec2.weak(552,292.5)   ,  Vec2.weak(571,284.5)   ],
							mat,
							filt
						);
						s.body = body;
						s.fluidEnabled = false;
						s.fluidProperties = prop;
						//s.cbTypes.add(cbType);
					
						s = new Polygon(
							[   Vec2.weak(554.5,164)   ,  Vec2.weak(547.5,157)   ,  Vec2.weak(554.5,170)   ],
							mat,
							filt
						);
						s.body = body;
						s.fluidEnabled = false;
						s.fluidProperties = prop;
						//s.cbTypes.add(cbType);
					
						s = new Polygon(
							[   Vec2.weak(381,-0.5)   ,  Vec2.weak(375,-0.5)   ,  Vec2.weak(442.5,65)   ,  Vec2.weak(420.5,31)   ,  Vec2.weak(385,1.5)   ],
							mat,
							filt
						);
						s.body = body;
						s.fluidEnabled = false;
						s.fluidProperties = prop;
						//s.cbTypes.add(cbType);
					
						s = new Polygon(
							[   Vec2.weak(552,292.5)   ,  Vec2.weak(594.5,235)   ,  Vec2.weak(567.5,198)   ,  Vec2.weak(337,23.5)   ,  Vec2.weak(112,101.5)   ,  Vec2.weak(464,328.5)   ,  Vec2.weak(478,326.5)   ,  Vec2.weak(503,318.5)   ],
							mat,
							filt
						);
						s.body = body;
						s.fluidEnabled = false;
						s.fluidProperties = prop;
						//s.cbTypes.add(cbType);
					
						s = new Polygon(
							[   Vec2.weak(560.5,180)   ,  Vec2.weak(554.5,170)   ,  Vec2.weak(562.5,191)   ],
							mat,
							filt
						);
						s.body = body;
						s.fluidEnabled = false;
						s.fluidProperties = prop;
						//s.cbTypes.add(cbType);
					
						s = new Polygon(
							[   Vec2.weak(194,10.5)   ,  Vec2.weak(184,15.5)   ,  Vec2.weak(161.5,38)   ,  Vec2.weak(145.5,59)   ,  Vec2.weak(135.5,76)   ,  Vec2.weak(244,25.5)   ,  Vec2.weak(204,9.5)   ],
							mat,
							filt
						);
						s.body = body;
						s.fluidEnabled = false;
						s.fluidProperties = prop;
						//s.cbTypes.add(cbType);
					
						s = new Polygon(
							[   Vec2.weak(10,274.5)   ,  Vec2.weak(28,281.5)   ,  Vec2.weak(53,286.5)   ,  Vec2.weak(24.5,197)   ,  Vec2.weak(15.5,225)   ,  Vec2.weak(4.5,268)   ],
							mat,
							filt
						);
						s.body = body;
						s.fluidEnabled = false;
						s.fluidProperties = prop;
						//s.cbTypes.add(cbType);
					
						s = new Polygon(
							[   Vec2.weak(53,286.5)   ,  Vec2.weak(71,293.5)   ,  Vec2.weak(96,296.5)   ,  Vec2.weak(24.5,197)   ],
							mat,
							filt
						);
						s.body = body;
						s.fluidEnabled = false;
						s.fluidProperties = prop;
						//s.cbTypes.add(cbType);
					
						s = new Polygon(
							[   Vec2.weak(98.5,112)   ,  Vec2.weak(90,123.5)   ,  Vec2.weak(117,299.5)   ,  Vec2.weak(141,304.5)   ,  Vec2.weak(112,101.5)   ],
							mat,
							filt
						);
						s.body = body;
						s.fluidEnabled = false;
						s.fluidProperties = prop;
						//s.cbTypes.add(cbType);
					
						s = new Polygon(
							[   Vec2.weak(592.5,227)   ,  Vec2.weak(584,213.5)   ,  Vec2.weak(567.5,198)   ,  Vec2.weak(594.5,235)   ],
							mat,
							filt
						);
						s.body = body;
						s.fluidEnabled = false;
						s.fluidProperties = prop;
						//s.cbTypes.add(cbType);
					
						s = new Polygon(
							[   Vec2.weak(406,15.5)   ,  Vec2.weak(385,1.5)   ,  Vec2.weak(420.5,31)   ],
							mat,
							filt
						);
						s.body = body;
						s.fluidEnabled = false;
						s.fluidProperties = prop;
						//s.cbTypes.add(cbType);
					
						s = new Polygon(
							[   Vec2.weak(108,299.5)   ,  Vec2.weak(117,299.5)   ,  Vec2.weak(90,123.5)   ,  Vec2.weak(46.5,167)   ,  Vec2.weak(31.5,185)   ,  Vec2.weak(24.5,197)   ,  Vec2.weak(96,296.5)   ],
							mat,
							filt
						);
						s.body = body;
						s.fluidEnabled = false;
						s.fluidProperties = prop;
						//s.cbTypes.add(cbType);
					
						s = new Polygon(
							[   Vec2.weak(524,123.5)   ,  Vec2.weak(500,101.5)   ,  Vec2.weak(453,74.5)   ,  Vec2.weak(562.5,191)   ,  Vec2.weak(554.5,170)   ,  Vec2.weak(547.5,157)   ],
							mat,
							filt
						);
						s.body = body;
						s.fluidEnabled = false;
						s.fluidProperties = prop;
						//s.cbTypes.add(cbType);
					
						s = new Polygon(
							[   Vec2.weak(141,304.5)   ,  Vec2.weak(192,319.5)   ,  Vec2.weak(112,101.5)   ],
							mat,
							filt
						);
						s.body = body;
						s.fluidEnabled = false;
						s.fluidProperties = prop;
						//s.cbTypes.add(cbType);
					
						s = new Polygon(
							[   Vec2.weak(218,330.5)   ,  Vec2.weak(235,333.5)   ,  Vec2.weak(377,332.5)   ,  Vec2.weak(420,329.5)   ,  Vec2.weak(112,101.5)   ,  Vec2.weak(192,319.5)   ],
							mat,
							filt
						);
						s.body = body;
						s.fluidEnabled = false;
						s.fluidProperties = prop;
						//s.cbTypes.add(cbType);
					
						s = new Polygon(
							[   Vec2.weak(244,25.5)   ,  Vec2.weak(135.5,76)   ,  Vec2.weak(260,28.5)   ],
							mat,
							filt
						);
						s.body = body;
						s.fluidEnabled = false;
						s.fluidProperties = prop;
						//s.cbTypes.add(cbType);
					
						s = new Polygon(
							[   Vec2.weak(420,329.5)   ,  Vec2.weak(464,328.5)   ,  Vec2.weak(112,101.5)   ],
							mat,
							filt
						);
						s.body = body;
						s.fluidEnabled = false;
						s.fluidProperties = prop;
						//s.cbTypes.add(cbType);
					
						s = new Polygon(
							[   Vec2.weak(316,23.5)   ,  Vec2.weak(285,28.5)   ,  Vec2.weak(135.5,76)   ,  Vec2.weak(125,88.5)   ,  Vec2.weak(337,23.5)   ],
							mat,
							filt
						);
						s.body = body;
						s.fluidEnabled = false;
						s.fluidProperties = prop;
						//s.cbTypes.add(cbType);
					
						s = new Polygon(
							[   Vec2.weak(260,28.5)   ,  Vec2.weak(135.5,76)   ,  Vec2.weak(285,28.5)   ],
							mat,
							filt
						);
						s.body = body;
						s.fluidEnabled = false;
						s.fluidProperties = prop;
						//s.cbTypes.add(cbType);
					
						s = new Polygon(
							[   Vec2.weak(125,88.5)   ,  Vec2.weak(112,101.5)   ,  Vec2.weak(337,23.5)   ],
							mat,
							filt
						);
						s.body = body;
						s.fluidEnabled = false;
						s.fluidProperties = prop;
						//s.cbTypes.add(cbType);
					
						s = new Polygon(
							[   Vec2.weak(337,23.5)   ,  Vec2.weak(567.5,198)   ,  Vec2.weak(352,15.5)   ],
							mat,
							filt
						);
						s.body = body;
						s.fluidEnabled = false;
						s.fluidProperties = prop;
						//s.cbTypes.add(cbType);
					
						s = new Polygon(
							[   Vec2.weak(352,15.5)   ,  Vec2.weak(567.5,198)   ,  Vec2.weak(442.5,65)   ,  Vec2.weak(375,-0.5)   ],
							mat,
							filt
						);
						s.body = body;
						s.fluidEnabled = false;
						s.fluidProperties = prop;
						//s.cbTypes.add(cbType);
					
						s = new Polygon(
							[   Vec2.weak(562.5,191)   ,  Vec2.weak(453,74.5)   ,  Vec2.weak(442.5,65)   ,  Vec2.weak(567.5,198)   ],
							mat,
							filt
						);
						s.body = body;
						s.fluidEnabled = false;
						s.fluidProperties = prop;
						//s.cbTypes.add(cbType);
					
				
			

			anchor = (true) ? body.localCOM.copy() : Vec2.get(0,334);
			body.translateShapes(Vec2.weak(-anchor.x,-anchor.y));
			body.position.setxy(510,700);


			bodies["mountain"] = new BodyPair(body,anchor);
		
	}
}
}

import nape.phys.Body;
import nape.geom.Vec2;

class BodyPair {
	public var body:Body;
	public var anchor:Vec2;
	public function BodyPair(body:Body,anchor:Vec2):void {
		this.body = body;
		this.anchor = anchor;
	}
}
