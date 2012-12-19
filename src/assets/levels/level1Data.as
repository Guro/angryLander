package assets.levels {

import flash.display.DisplayObject;
import flash.geom.Rectangle;
import flash.utils.Dictionary;

import nape.callbacks.CbType;
import nape.dynamics.InteractionFilter;
import nape.geom.Vec2;
import nape.phys.Body;
import nape.phys.BodyType;
import nape.phys.FluidProperties;
import nape.phys.Material;
import nape.shape.Polygon;
import nape.shape.Shape;

public class level1Data {

	public static function createBody(name:String,graphic:DisplayObject=null):Body {
		var xret:BodyPair = lookup(name);
		if(graphic==null) return xret.body.copy();

		var ret:Body = xret.body.copy();
		graphic.x = graphic.y = 0;
		graphic.rotation = 0;
		var bounds:Rectangle = graphic.getBounds(graphic);
		var offset:Vec2 = Vec2.get(bounds.x-xret.anchor.x, bounds.y-xret.anchor.y);

		ret.userData.graphic = graphic;
		ret.userData.graphicUpdate = function(b:Body):void {
			var gp:Vec2 = b.localPointToWorld(offset);
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

	public static var bodies   :Dictionary;
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
	
	public static function getbodies():Dictionary {
		if(bodies==null) init();
		return bodies;
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
			//body.cbType = cbtype("null");

			
				mat = material("default");
				filt = filter("default");
				prop = fprop("default");
				//cbType = cbtype("null");

				
					
						s = new Polygon(
							[   Vec2.weak(1177,439.5)   ,  Vec2.weak(1299,396.5)   ,  Vec2.weak(1334,362.5)   ,  Vec2.weak(1090,365.5)   ],
							mat,
							filt
						);
						s.body = body;
						s.fluidEnabled = false;
						s.fluidProperties = prop;
						//s.cbType = cbType;
					
						s = new Polygon(
							[   Vec2.weak(112,184.5)   ,  Vec2.weak(183,180.5)   ,  Vec2.weak(-0.5,0)   ,  Vec2.weak(63.5,120)   ],
							mat,
							filt
						);
						s.body = body;
						s.fluidEnabled = false;
						s.fluidProperties = prop;
						//s.cbType = cbType;
					
						s = new Polygon(
							[   Vec2.weak(1631,216.5)   ,  Vec2.weak(1710,185.5)   ,  Vec2.weak(1534,175.5)   ],
							mat,
							filt
						);
						s.body = body;
						s.fluidEnabled = false;
						s.fluidProperties = prop;
						//s.cbType = cbType;
					
						s = new Polygon(
							[   Vec2.weak(-0.5,59)   ,  Vec2.weak(63.5,120)   ,  Vec2.weak(-0.5,0)   ],
							mat,
							filt
						);
						s.body = body;
						s.fluidEnabled = false;
						s.fluidProperties = prop;
						//s.cbType = cbType;
					
						s = new Polygon(
							[   Vec2.weak(183,180.5)   ,  Vec2.weak(251,184.5)   ,  Vec2.weak(331,174.5)   ,  Vec2.weak(-0.5,0)   ],
							mat,
							filt
						);
						s.body = body;
						s.fluidEnabled = false;
						s.fluidProperties = prop;
						//s.cbType = cbType;
					
						s = new Polygon(
							[   Vec2.weak(647,186.5)   ,  Vec2.weak(729,172.5)   ,  Vec2.weak(-0.5,0)   ,  Vec2.weak(573,178.5)   ],
							mat,
							filt
						);
						s.body = body;
						s.fluidEnabled = false;
						s.fluidProperties = prop;
						//s.cbType = cbType;
					
						s = new Polygon(
							[   Vec2.weak(1334,362.5)   ,  Vec2.weak(1400,324.5)   ,  Vec2.weak(1452.5,287)   ,  Vec2.weak(1531,175.5)   ,  Vec2.weak(1087.5,361)   ,  Vec2.weak(1090,365.5)   ],
							mat,
							filt
						);
						s.body = body;
						s.fluidEnabled = false;
						s.fluidProperties = prop;
						//s.cbType = cbType;
					
						s = new Polygon(
							[   Vec2.weak(826,213.5)   ,  Vec2.weak(848,207.5)   ,  Vec2.weak(910,186.5)   ,  Vec2.weak(729,172.5)   ],
							mat,
							filt
						);
						s.body = body;
						s.fluidEnabled = false;
						s.fluidProperties = prop;
						//s.cbType = cbType;
					
						s = new Polygon(
							[   Vec2.weak(1846,185.5)   ,  Vec2.weak(1928,173.5)   ,  Vec2.weak(2047,-0.5)   ,  Vec2.weak(820,-0.5)   ,  Vec2.weak(1780,179.5)   ],
							mat,
							filt
						);
						s.body = body;
						s.fluidEnabled = false;
						s.fluidProperties = prop;
						//s.cbType = cbType;
					
						s = new Polygon(
							[   Vec2.weak(2047.5,227)   ,  Vec2.weak(2047,-0.5)   ,  Vec2.weak(2030,215.5)   ],
							mat,
							filt
						);
						s.body = body;
						s.fluidEnabled = false;
						s.fluidProperties = prop;
						//s.cbType = cbType;
					
						s = new Polygon(
							[   Vec2.weak(2030,215.5)   ,  Vec2.weak(2047,-0.5)   ,  Vec2.weak(1928,173.5)   ],
							mat,
							filt
						);
						s.body = body;
						s.fluidEnabled = false;
						s.fluidProperties = prop;
						//s.cbType = cbType;
					
						s = new Polygon(
							[   Vec2.weak(910,186.5)   ,  Vec2.weak(973,179.5)   ,  Vec2.weak(820,-0.5)   ,  Vec2.weak(1,-0.5)   ,  Vec2.weak(-0.5,0)   ,  Vec2.weak(729,172.5)   ],
							mat,
							filt
						);
						s.body = body;
						s.fluidEnabled = false;
						s.fluidProperties = prop;
						//s.cbType = cbType;
					
						s = new Polygon(
							[   Vec2.weak(1710,185.5)   ,  Vec2.weak(1780,179.5)   ,  Vec2.weak(820,-0.5)   ,  Vec2.weak(1534,175.5)   ],
							mat,
							filt
						);
						s.body = body;
						s.fluidEnabled = false;
						s.fluidProperties = prop;
						//s.cbType = cbType;
					
						s = new Polygon(
							[   Vec2.weak(433,217.5)   ,  Vec2.weak(507,186.5)   ,  Vec2.weak(-0.5,0)   ,  Vec2.weak(331,174.5)   ,  Vec2.weak(427,216.5)   ],
							mat,
							filt
						);
						s.body = body;
						s.fluidEnabled = false;
						s.fluidProperties = prop;
						//s.cbType = cbType;
					
						s = new Polygon(
							[   Vec2.weak(507,186.5)   ,  Vec2.weak(573,178.5)   ,  Vec2.weak(-0.5,0)   ],
							mat,
							filt
						);
						s.body = body;
						s.fluidEnabled = false;
						s.fluidProperties = prop;
						//s.cbType = cbType;
					
						s = new Polygon(
							[   Vec2.weak(1002,324.5)   ,  Vec2.weak(1087.5,361)   ,  Vec2.weak(977.5,194)   ,  Vec2.weak(1000.5,322)   ],
							mat,
							filt
						);
						s.body = body;
						s.fluidEnabled = false;
						s.fluidProperties = prop;
						//s.cbType = cbType;
					
						s = new Polygon(
							[   Vec2.weak(977.5,194)   ,  Vec2.weak(1087.5,361)   ,  Vec2.weak(1531,175.5)   ,  Vec2.weak(974.5,180)   ],
							mat,
							filt
						);
						s.body = body;
						s.fluidEnabled = false;
						s.fluidProperties = prop;
						//s.cbType = cbType;
					
						s = new Polygon(
							[   Vec2.weak(1534,175.5)   ,  Vec2.weak(820,-0.5)   ,  Vec2.weak(1531,175.5)   ],
							mat,
							filt
						);
						s.body = body;
						s.fluidEnabled = false;
						s.fluidProperties = prop;
						//s.cbType = cbType;
					
						s = new Polygon(
							[   Vec2.weak(1531,175.5)   ,  Vec2.weak(820,-0.5)   ,  Vec2.weak(973,179.5)   ,  Vec2.weak(974.5,180)   ],
							mat,
							filt
						);
						s.body = body;
						s.fluidEnabled = false;
						s.fluidProperties = prop;
						//s.cbType = cbType;
					
				
			

			anchor = (true) ? body.localCOM.copy() : Vec2.get(0,0);
			body.translateShapes(Vec2.weak(-anchor.x,-anchor.y));
			body.position.setxy(0,0);

			bodies["tmp"] = new BodyPair(body,anchor);
		
			
			body = new Body(BodyType.STATIC);
			//body.cbType = cbtype("null");

			
				mat = material("default");
				filt = filter("default");
				prop = fprop("default");
				//cbType = cbtype("null");

				
					
						s = new Polygon(
							[   Vec2.weak(1207,670.5)   ,  Vec2.weak(1113,643.5)   ,  Vec2.weak(1230.5,757)   ],
							mat,
							filt
						);
						s.body = body;
						s.fluidEnabled = false;
						s.fluidProperties = prop;
						//s.cbType = cbType;
					
						s = new Polygon(
							[   Vec2.weak(1935,423.5)   ,  Vec2.weak(1864,427.5)   ,  Vec2.weak(1713.5,513)   ,  Vec2.weak(1697,559.5)   ,  Vec2.weak(2047.5,769)   ,  Vec2.weak(1983.5,488)   ],
							mat,
							filt
						);
						s.body = body;
						s.fluidEnabled = false;
						s.fluidProperties = prop;
						//s.cbType = cbType;
					
						s = new Polygon(
							[   Vec2.weak(416,391.5)   ,  Vec2.weak(337,422.5)   ,  Vec2.weak(513,432.5)   ],
							mat,
							filt
						);
						s.body = body;
						s.fluidEnabled = false;
						s.fluidProperties = prop;
						//s.cbType = cbType;
					
						s = new Polygon(
							[   Vec2.weak(1024,512.5)   ,  Vec2.weak(920,432.5)   ,  Vec2.weak(912,434.5)   ,  Vec2.weak(869,455.5)   ,  Vec2.weak(841,472.5)   ,  Vec2.weak(1033.5,603)   ],
							mat,
							filt
						);
						s.body = body;
						s.fluidEnabled = false;
						s.fluidProperties = prop;
						//s.cbType = cbType;
					
						s = new Polygon(
							[   Vec2.weak(2047.5,549)   ,  Vec2.weak(1983.5,488)   ,  Vec2.weak(2047.5,769)   ],
							mat,
							filt
						);
						s.body = body;
						s.fluidEnabled = false;
						s.fluidProperties = prop;
						//s.cbType = cbType;
					
						s = new Polygon(
							[   Vec2.weak(738,423.5)   ,  Vec2.weak(671,428.5)   ,  Vec2.weak(833,475.5)   ],
							mat,
							filt
						);
						s.body = body;
						s.fluidEnabled = false;
						s.fluidProperties = prop;
						//s.cbType = cbType;
					
						s = new Polygon(
							[   Vec2.weak(1719.5,433)   ,  Vec2.weak(1717.5,445)   ,  Vec2.weak(1713.5,513)   ,  Vec2.weak(1864,427.5)   ,  Vec2.weak(1796,423.5)   ],
							mat,
							filt
						);
						s.body = body;
						s.fluidEnabled = false;
						s.fluidProperties = prop;
						//s.cbType = cbType;
					
						s = new Polygon(
							[   Vec2.weak(1314,725.5)   ,  Vec2.weak(1300.5,738)   ,  Vec2.weak(1285,755.5)   ,  Vec2.weak(2047.5,769)   ,  Vec2.weak(1394,721.5)   ],
							mat,
							filt
						);
						s.body = body;
						s.fluidEnabled = false;
						s.fluidProperties = prop;
						//s.cbType = cbType;
					
						s = new Polygon(
							[   Vec2.weak(1548,611.5)   ,  Vec2.weak(1512,645.5)   ,  Vec2.weak(2047.5,769)   ,  Vec2.weak(1697,559.5)   ,  Vec2.weak(1662,570.5)   ],
							mat,
							filt
						);
						s.body = body;
						s.fluidEnabled = false;
						s.fluidProperties = prop;
						//s.cbType = cbType;
					
						s = new Polygon(
							[   Vec2.weak(201,422.5)   ,  Vec2.weak(119,434.5)   ,  Vec2.weak(0,769.5)   ,  Vec2.weak(267,428.5)   ],
							mat,
							filt
						);
						s.body = body;
						s.fluidEnabled = false;
						s.fluidProperties = prop;
						//s.cbType = cbType;
					
						s = new Polygon(
							[   Vec2.weak(1113,643.5)   ,  Vec2.weak(1033.5,603)   ,  Vec2.weak(1230.5,757)   ],
							mat,
							filt
						);
						s.body = body;
						s.fluidEnabled = false;
						s.fluidProperties = prop;
						//s.cbType = cbType;
					
						s = new Polygon(
							[   Vec2.weak(1512,645.5)   ,  Vec2.weak(1447,683.5)   ,  Vec2.weak(1394,721.5)   ,  Vec2.weak(2047.5,769)   ],
							mat,
							filt
						);
						s.body = body;
						s.fluidEnabled = false;
						s.fluidProperties = prop;
						//s.cbType = cbType;
					
						s = new Polygon(
							[   Vec2.weak(-0.5,381)   ,  Vec2.weak(0,769.5)   ,  Vec2.weak(17,392.5)   ],
							mat,
							filt
						);
						s.body = body;
						s.fluidEnabled = false;
						s.fluidProperties = prop;
						//s.cbType = cbType;
					
						s = new Polygon(
							[   Vec2.weak(17,392.5)   ,  Vec2.weak(0,769.5)   ,  Vec2.weak(119,434.5)   ],
							mat,
							filt
						);
						s.body = body;
						s.fluidEnabled = false;
						s.fluidProperties = prop;
						//s.cbType = cbType;
					
						s = new Polygon(
							[   Vec2.weak(267,428.5)   ,  Vec2.weak(0,769.5)   ,  Vec2.weak(1233,760.5)   ,  Vec2.weak(1230.5,757)   ,  Vec2.weak(323,423.5)   ,  Vec2.weak(322,423.5)   ],
							mat,
							filt
						);
						s.body = body;
						s.fluidEnabled = false;
						s.fluidProperties = prop;
						//s.cbType = cbType;
					
						s = new Polygon(
							[   Vec2.weak(671,428.5)   ,  Vec2.weak(614,422.5)   ,  Vec2.weak(597,422.5)   ,  Vec2.weak(526,432.5)   ,  Vec2.weak(1230.5,757)   ,  Vec2.weak(833,475.5)   ],
							mat,
							filt
						);
						s.body = body;
						s.fluidEnabled = false;
						s.fluidProperties = prop;
						//s.cbType = cbType;
					
						s = new Polygon(
							[   Vec2.weak(1033.5,603)   ,  Vec2.weak(841,472.5)   ,  Vec2.weak(833,475.5)   ,  Vec2.weak(1230.5,757)   ],
							mat,
							filt
						);
						s.body = body;
						s.fluidEnabled = false;
						s.fluidProperties = prop;
						//s.cbType = cbType;
					
						s = new Polygon(
							[   Vec2.weak(337,422.5)   ,  Vec2.weak(323,423.5)   ,  Vec2.weak(1230.5,757)   ,  Vec2.weak(513,432.5)   ],
							mat,
							filt
						);
						s.body = body;
						s.fluidEnabled = false;
						s.fluidProperties = prop;
						//s.cbType = cbType;
					
						s = new Polygon(
							[   Vec2.weak(1285,755.5)   ,  Vec2.weak(1233,760.5)   ,  Vec2.weak(2047.5,769)   ],
							mat,
							filt
						);
						s.body = body;
						s.fluidEnabled = false;
						s.fluidProperties = prop;
						//s.cbType = cbType;
					
						s = new Polygon(
							[   Vec2.weak(2047.5,769)   ,  Vec2.weak(1233,760.5)   ,  Vec2.weak(0,769.5)   ],
							mat,
							filt
						);
						s.body = body;
						s.fluidEnabled = false;
						s.fluidProperties = prop;
						//s.cbType = cbType;
					
						s = new Polygon(
							[   Vec2.weak(526,432.5)   ,  Vec2.weak(513,432.5)   ,  Vec2.weak(1230.5,757)   ],
							mat,
							filt
						);
						s.body = body;
						s.fluidEnabled = false;
						s.fluidProperties = prop;
						//s.cbType = cbType;
					
				
			

			anchor = (true) ? body.localCOM.copy() : Vec2.get(0,385);
			body.translateShapes(Vec2.weak(-anchor.x,-anchor.y));
			body.position.setxy(0,0);

			bodies["tmp2"] = new BodyPair(body,anchor);
		
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
