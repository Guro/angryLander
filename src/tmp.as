package {

import nape.phys.Body;
import nape.phys.BodyType;
import nape.shape.Shape;
import nape.shape.Polygon;
import nape.shape.Circle;
import nape.geom.Vec2;
import nape.dynamics.InteractionFilter;
import nape.phys.Material;
import nape.phys.FluidProperties;
import nape.callbacks.CbType;
import nape.geom.AABB;

import flash.display.DisplayObject;
import flash.geom.Rectangle;
import flash.utils.Dictionary;

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

		
			body = new Body();
			body.cbType = cbtype("null");

			
				mat = material("default");
				filt = filter("default");
				prop = fprop("default");
				cbType = cbtype("null");

				
					
						s = new Polygon(
							[   Vec2.weak(818.5,881)   ,  Vec2.weak(810.5,716)   ,  Vec2.weak(641,881.5)   ],
							mat,
							filt
						);
						s.body = body;
						s.fluidEnabled = false;
						s.fluidProperties = prop;
						s.cbType = cbType;
					
						s = new Polygon(
							[   Vec2.weak(1307,995.5)   ,  Vec2.weak(1408,953.5)   ,  Vec2.weak(1404,901.5)   ,  Vec2.weak(1306.5,926)   ],
							mat,
							filt
						);
						s.body = body;
						s.fluidEnabled = false;
						s.fluidProperties = prop;
						s.cbType = cbType;
					
						s = new Polygon(
							[   Vec2.weak(1478.5,1304)   ,  Vec2.weak(1434.5,1106)   ,  Vec2.weak(1432.5,1103)   ,  Vec2.weak(1309,1312.5)   ,  Vec2.weak(1251,1423.5)   ],
							mat,
							filt
						);
						s.body = body;
						s.fluidEnabled = false;
						s.fluidProperties = prop;
						s.cbType = cbType;
					
						s = new Polygon(
							[   Vec2.weak(395,266.5)   ,  Vec2.weak(553,284.5)   ,  Vec2.weak(804,288.5)   ,  Vec2.weak(2047,-0.5)   ,  Vec2.weak(352.5,0)   ],
							mat,
							filt
						);
						s.body = body;
						s.fluidEnabled = false;
						s.fluidProperties = prop;
						s.cbType = cbType;
					
						s = new Polygon(
							[   Vec2.weak(1193.5,1628)   ,  Vec2.weak(1251,1423.5)   ,  Vec2.weak(954,1714.5)   ],
							mat,
							filt
						);
						s.body = body;
						s.fluidEnabled = false;
						s.fluidProperties = prop;
						s.cbType = cbType;
					
						s = new Polygon(
							[   Vec2.weak(532.5,1169)   ,  Vec2.weak(441,1314.5)   ,  Vec2.weak(449,1315.5)   ,  Vec2.weak(815,1174.5)   ],
							mat,
							filt
						);
						s.body = body;
						s.fluidEnabled = false;
						s.fluidProperties = prop;
						s.cbType = cbType;
					
						s = new Polygon(
							[   Vec2.weak(956,608.5)   ,  Vec2.weak(1075.5,693)   ,  Vec2.weak(1211,344.5)   ,  Vec2.weak(943.5,402)   ],
							mat,
							filt
						);
						s.body = body;
						s.fluidEnabled = false;
						s.fluidProperties = prop;
						s.cbType = cbType;
					
						s = new Polygon(
							[   Vec2.weak(497,604.5)   ,  Vec2.weak(339,604.5)   ,  Vec2.weak(337.5,605)   ,  Vec2.weak(340.5,771)   ,  Vec2.weak(528.5,673)   ],
							mat,
							filt
						);
						s.body = body;
						s.fluidEnabled = false;
						s.fluidProperties = prop;
						s.cbType = cbType;
					
						s = new Polygon(
							[   Vec2.weak(294,1349.5)   ,  Vec2.weak(290,1348.5)   ,  Vec2.weak(161.5,1333)   ,  Vec2.weak(0,2047.5)   ,  Vec2.weak(320.5,1603)   ,  Vec2.weak(312.5,1425)   ,  Vec2.weak(295.5,1352)   ],
							mat,
							filt
						);
						s.body = body;
						s.fluidEnabled = false;
						s.fluidProperties = prop;
						s.cbType = cbType;
					
						s = new Polygon(
							[   Vec2.weak(1408,953.5)   ,  Vec2.weak(1627.5,939)   ,  Vec2.weak(1712,881.5)   ,  Vec2.weak(1404,901.5)   ],
							mat,
							filt
						);
						s.body = body;
						s.fluidEnabled = false;
						s.fluidProperties = prop;
						s.cbType = cbType;
					
						s = new Polygon(
							[   Vec2.weak(1627.5,939)   ,  Vec2.weak(1633.5,1197)   ,  Vec2.weak(1667.5,1357)   ,  Vec2.weak(1712,881.5)   ],
							mat,
							filt
						);
						s.body = body;
						s.fluidEnabled = false;
						s.fluidProperties = prop;
						s.cbType = cbType;
					
						s = new Polygon(
							[   Vec2.weak(641,881.5)   ,  Vec2.weak(810.5,716)   ,  Vec2.weak(809,706.5)   ,  Vec2.weak(674,772.5)   ,  Vec2.weak(497,938.5)   ],
							mat,
							filt
						);
						s.body = body;
						s.fluidEnabled = false;
						s.fluidProperties = prop;
						s.cbType = cbType;
					
						s = new Polygon(
							[   Vec2.weak(1,-0.5)   ,  Vec2.weak(-0.5,0)   ,  Vec2.weak(0,2047.5)   ,  Vec2.weak(42.5,258)   ,  Vec2.weak(2,-0.5)   ],
							mat,
							filt
						);
						s.body = body;
						s.fluidEnabled = false;
						s.fluidProperties = prop;
						s.cbType = cbType;
					
						s = new Polygon(
							[   Vec2.weak(804,288.5)   ,  Vec2.weak(943.5,402)   ,  Vec2.weak(1211,344.5)   ,  Vec2.weak(2047,-0.5)   ],
							mat,
							filt
						);
						s.body = body;
						s.fluidEnabled = false;
						s.fluidProperties = prop;
						s.cbType = cbType;
					
						s = new Polygon(
							[   Vec2.weak(1707.5,854)   ,  Vec2.weak(1716.5,878)   ,  Vec2.weak(1981,862.5)   ,  Vec2.weak(1709,852.5)   ],
							mat,
							filt
						);
						s.body = body;
						s.fluidEnabled = false;
						s.fluidProperties = prop;
						s.cbType = cbType;
					
						s = new Polygon(
							[   Vec2.weak(674,772.5)   ,  Vec2.weak(532.5,678)   ,  Vec2.weak(255,1122.5)   ,  Vec2.weak(497,938.5)   ],
							mat,
							filt
						);
						s.body = body;
						s.fluidEnabled = false;
						s.fluidProperties = prop;
						s.cbType = cbType;
					
						s = new Polygon(
							[   Vec2.weak(255,1122.5)   ,  Vec2.weak(532.5,678)   ,  Vec2.weak(528.5,673)   ,  Vec2.weak(269,898.5)   ,  Vec2.weak(133,1219.5)   ],
							mat,
							filt
						);
						s.body = body;
						s.fluidEnabled = false;
						s.fluidProperties = prop;
						s.cbType = cbType;
					
						s = new Polygon(
							[   Vec2.weak(1633.5,725)   ,  Vec2.weak(1610.5,552)   ,  Vec2.weak(1414,749.5)   ,  Vec2.weak(1623,727.5)   ],
							mat,
							filt
						);
						s.body = body;
						s.fluidEnabled = false;
						s.fluidProperties = prop;
						s.cbType = cbType;
					
						s = new Polygon(
							[   Vec2.weak(1414,749.5)   ,  Vec2.weak(1610.5,552)   ,  Vec2.weak(1610,550.5)   ,  Vec2.weak(1226,353.5)   ,  Vec2.weak(1174,835.5)   ],
							mat,
							filt
						);
						s.body = body;
						s.fluidEnabled = false;
						s.fluidProperties = prop;
						s.cbType = cbType;
					
						s = new Polygon(
							[   Vec2.weak(42,-0.5)   ,  Vec2.weak(2,-0.5)   ,  Vec2.weak(42.5,258)   ,  Vec2.weak(62.5,200)   ,  Vec2.weak(62.5,188)   ,  Vec2.weak(43.5,2)   ],
							mat,
							filt
						);
						s.body = body;
						s.fluidEnabled = false;
						s.fluidProperties = prop;
						s.cbType = cbType;
					
						s = new Polygon(
							[   Vec2.weak(776.5,1819)   ,  Vec2.weak(784.5,1811)   ,  Vec2.weak(829,1755.5)   ,  Vec2.weak(721.5,1640)   ],
							mat,
							filt
						);
						s.body = body;
						s.fluidEnabled = false;
						s.fluidProperties = prop;
						s.cbType = cbType;
					
						s = new Polygon(
							[   Vec2.weak(543.5,1447)   ,  Vec2.weak(829,1755.5)   ,  Vec2.weak(815,1174.5)   ,  Vec2.weak(453.5,1318)   ],
							mat,
							filt
						);
						s.body = body;
						s.fluidEnabled = false;
						s.fluidProperties = prop;
						s.cbType = cbType;
					
						s = new Polygon(
							[   Vec2.weak(340.5,771)   ,  Vec2.weak(269,898.5)   ,  Vec2.weak(528.5,673)   ],
							mat,
							filt
						);
						s.body = body;
						s.fluidEnabled = false;
						s.fluidProperties = prop;
						s.cbType = cbType;
					
						s = new Polygon(
							[   Vec2.weak(1226,353.5)   ,  Vec2.weak(1211,344.5)   ,  Vec2.weak(1171.5,839)   ,  Vec2.weak(1174,835.5)   ],
							mat,
							filt
						);
						s.body = body;
						s.fluidEnabled = false;
						s.fluidProperties = prop;
						s.cbType = cbType;
					
						s = new Polygon(
							[   Vec2.weak(83.5,407)   ,  Vec2.weak(83.5,401)   ,  Vec2.weak(42.5,263)   ,  Vec2.weak(51.5,486)   ],
							mat,
							filt
						);
						s.body = body;
						s.fluidEnabled = false;
						s.fluidProperties = prop;
						s.cbType = cbType;
					
						s = new Polygon(
							[   Vec2.weak(856.5,1844)   ,  Vec2.weak(858.5,1845)   ,  Vec2.weak(954,1714.5)   ,  Vec2.weak(832.5,1762)   ],
							mat,
							filt
						);
						s.body = body;
						s.fluidEnabled = false;
						s.fluidProperties = prop;
						s.cbType = cbType;
					
						s = new Polygon(
							[   Vec2.weak(954,1714.5)   ,  Vec2.weak(1251,1423.5)   ,  Vec2.weak(1309,1312.5)   ,  Vec2.weak(1175.5,1315)   ,  Vec2.weak(832.5,1762)   ],
							mat,
							filt
						);
						s.body = body;
						s.fluidEnabled = false;
						s.fluidProperties = prop;
						s.cbType = cbType;
					
						s = new Polygon(
							[   Vec2.weak(269,898.5)   ,  Vec2.weak(131.5,922)   ,  Vec2.weak(133,1219.5)   ],
							mat,
							filt
						);
						s.body = body;
						s.fluidEnabled = false;
						s.fluidProperties = prop;
						s.cbType = cbType;
					
						s = new Polygon(
							[   Vec2.weak(131.5,922)   ,  Vec2.weak(84.5,869)   ,  Vec2.weak(0,2047.5)   ,  Vec2.weak(133,1219.5)   ],
							mat,
							filt
						);
						s.body = body;
						s.fluidEnabled = false;
						s.fluidProperties = prop;
						s.cbType = cbType;
					
						s = new Polygon(
							[   Vec2.weak(107.5,768)   ,  Vec2.weak(107.5,760)   ,  Vec2.weak(51.5,493)   ,  Vec2.weak(84.5,869)   ],
							mat,
							filt
						);
						s.body = body;
						s.fluidEnabled = false;
						s.fluidProperties = prop;
						s.cbType = cbType;
					
						s = new Polygon(
							[   Vec2.weak(1175.5,1315)   ,  Vec2.weak(1130.5,1072)   ,  Vec2.weak(832.5,1762)   ],
							mat,
							filt
						);
						s.body = body;
						s.fluidEnabled = false;
						s.fluidProperties = prop;
						s.cbType = cbType;
					
						s = new Polygon(
							[   Vec2.weak(1667.5,1357)   ,  Vec2.weak(1671.5,1383)   ,  Vec2.weak(1981,862.5)   ,  Vec2.weak(1716,880.5)   ,  Vec2.weak(1712,881.5)   ],
							mat,
							filt
						);
						s.body = body;
						s.fluidEnabled = false;
						s.fluidProperties = prop;
						s.cbType = cbType;
					
						s = new Polygon(
							[   Vec2.weak(449,1315.5)   ,  Vec2.weak(453.5,1318)   ,  Vec2.weak(815,1174.5)   ],
							mat,
							filt
						);
						s.body = body;
						s.fluidEnabled = false;
						s.fluidProperties = prop;
						s.cbType = cbType;
					
						s = new Polygon(
							[   Vec2.weak(815,1174.5)   ,  Vec2.weak(829,1755.5)   ,  Vec2.weak(830.5,1756)   ,  Vec2.weak(1027,986.5)   ],
							mat,
							filt
						);
						s.body = body;
						s.fluidEnabled = false;
						s.fluidProperties = prop;
						s.cbType = cbType;
					
						s = new Polygon(
							[   Vec2.weak(1716.5,878)   ,  Vec2.weak(1716,880.5)   ,  Vec2.weak(1981,862.5)   ],
							mat,
							filt
						);
						s.body = body;
						s.fluidEnabled = false;
						s.fluidProperties = prop;
						s.cbType = cbType;
					
						s = new Polygon(
							[   Vec2.weak(320.5,1603)   ,  Vec2.weak(0,2047.5)   ,  Vec2.weak(557.5,2002)   ],
							mat,
							filt
						);
						s.body = body;
						s.fluidEnabled = false;
						s.fluidProperties = prop;
						s.cbType = cbType;
					
						s = new Polygon(
							[   Vec2.weak(1130.5,1072)   ,  Vec2.weak(1132.5,1056)   ,  Vec2.weak(832.5,1762)   ],
							mat,
							filt
						);
						s.body = body;
						s.fluidEnabled = false;
						s.fluidProperties = prop;
						s.cbType = cbType;
					
						s = new Polygon(
							[   Vec2.weak(1132.5,1056)   ,  Vec2.weak(1171.5,839)   ,  Vec2.weak(1211,344.5)   ,  Vec2.weak(830.5,1756)   ,  Vec2.weak(832.5,1762)   ],
							mat,
							filt
						);
						s.body = body;
						s.fluidEnabled = false;
						s.fluidProperties = prop;
						s.cbType = cbType;
					
						s = new Polygon(
							[   Vec2.weak(1547.5,1596)   ,  Vec2.weak(2047.5,2047)   ,  Vec2.weak(1981,862.5)   ],
							mat,
							filt
						);
						s.body = body;
						s.fluidEnabled = false;
						s.fluidProperties = prop;
						s.cbType = cbType;
					
						s = new Polygon(
							[   Vec2.weak(1027,986.5)   ,  Vec2.weak(1211,344.5)   ,  Vec2.weak(1075.5,693)   ],
							mat,
							filt
						);
						s.body = body;
						s.fluidEnabled = false;
						s.fluidProperties = prop;
						s.cbType = cbType;
					
						s = new Polygon(
							[   Vec2.weak(1211,344.5)   ,  Vec2.weak(1774,362.5)   ,  Vec2.weak(2047,-0.5)   ],
							mat,
							filt
						);
						s.body = body;
						s.fluidEnabled = false;
						s.fluidProperties = prop;
						s.cbType = cbType;
					
						s = new Polygon(
							[   Vec2.weak(1774,362.5)   ,  Vec2.weak(1891.5,423)   ,  Vec2.weak(2047,-0.5)   ],
							mat,
							filt
						);
						s.body = body;
						s.fluidEnabled = false;
						s.fluidProperties = prop;
						s.cbType = cbType;
					
						s = new Polygon(
							[   Vec2.weak(1891.5,423)   ,  Vec2.weak(1995.5,640)   ,  Vec2.weak(2047,-0.5)   ],
							mat,
							filt
						);
						s.body = body;
						s.fluidEnabled = false;
						s.fluidProperties = prop;
						s.cbType = cbType;
					
						s = new Polygon(
							[   Vec2.weak(2047,-0.5)   ,  Vec2.weak(1995.5,640)   ,  Vec2.weak(1995.5,656)   ,  Vec2.weak(2047.5,2047)   ],
							mat,
							filt
						);
						s.body = body;
						s.fluidEnabled = false;
						s.fluidProperties = prop;
						s.cbType = cbType;
					
						s = new Polygon(
							[   Vec2.weak(51.5,486)   ,  Vec2.weak(42.5,263)   ,  Vec2.weak(0,2047.5)   ],
							mat,
							filt
						);
						s.body = body;
						s.fluidEnabled = false;
						s.fluidProperties = prop;
						s.cbType = cbType;
					
						s = new Polygon(
							[   Vec2.weak(1995.5,656)   ,  Vec2.weak(1981,862.5)   ,  Vec2.weak(2047.5,2047)   ],
							mat,
							filt
						);
						s.body = body;
						s.fluidEnabled = false;
						s.fluidProperties = prop;
						s.cbType = cbType;
					
						s = new Polygon(
							[   Vec2.weak(1547.5,1596)   ,  Vec2.weak(1456.5,1734)   ,  Vec2.weak(2047.5,2047)   ],
							mat,
							filt
						);
						s.body = body;
						s.fluidEnabled = false;
						s.fluidProperties = prop;
						s.cbType = cbType;
					
						s = new Polygon(
							[   Vec2.weak(1456.5,1734)   ,  Vec2.weak(1436.5,1763)   ,  Vec2.weak(2047.5,2047)   ],
							mat,
							filt
						);
						s.body = body;
						s.fluidEnabled = false;
						s.fluidProperties = prop;
						s.cbType = cbType;
					
						s = new Polygon(
							[   Vec2.weak(1436.5,1763)   ,  Vec2.weak(1329,1901.5)   ,  Vec2.weak(2047.5,2047)   ],
							mat,
							filt
						);
						s.body = body;
						s.fluidEnabled = false;
						s.fluidProperties = prop;
						s.cbType = cbType;
					
						s = new Polygon(
							[   Vec2.weak(1329,1901.5)   ,  Vec2.weak(1301,1916.5)   ,  Vec2.weak(2047.5,2047)   ],
							mat,
							filt
						);
						s.body = body;
						s.fluidEnabled = false;
						s.fluidProperties = prop;
						s.cbType = cbType;
					
						s = new Polygon(
							[   Vec2.weak(1301,1916.5)   ,  Vec2.weak(1116,2006.5)   ,  Vec2.weak(2047.5,2047)   ],
							mat,
							filt
						);
						s.body = body;
						s.fluidEnabled = false;
						s.fluidProperties = prop;
						s.cbType = cbType;
					
						s = new Polygon(
							[   Vec2.weak(1116,2006.5)   ,  Vec2.weak(1105,2011.5)   ,  Vec2.weak(2047.5,2047)   ],
							mat,
							filt
						);
						s.body = body;
						s.fluidEnabled = false;
						s.fluidProperties = prop;
						s.cbType = cbType;
					
						s = new Polygon(
							[   Vec2.weak(2047.5,2047)   ,  Vec2.weak(1105,2011.5)   ,  Vec2.weak(0,2047.5)   ],
							mat,
							filt
						);
						s.body = body;
						s.fluidEnabled = false;
						s.fluidProperties = prop;
						s.cbType = cbType;
					
						s = new Polygon(
							[   Vec2.weak(1099,2011.5)   ,  Vec2.weak(557.5,2002)   ,  Vec2.weak(0,2047.5)   ],
							mat,
							filt
						);
						s.body = body;
						s.fluidEnabled = false;
						s.fluidProperties = prop;
						s.cbType = cbType;
					
						s = new Polygon(
							[   Vec2.weak(161.5,1333)   ,  Vec2.weak(135.5,1235)   ,  Vec2.weak(0,2047.5)   ],
							mat,
							filt
						);
						s.body = body;
						s.fluidEnabled = false;
						s.fluidProperties = prop;
						s.cbType = cbType;
					
						s = new Polygon(
							[   Vec2.weak(135.5,1235)   ,  Vec2.weak(132.5,1223)   ,  Vec2.weak(0,2047.5)   ],
							mat,
							filt
						);
						s.body = body;
						s.fluidEnabled = false;
						s.fluidProperties = prop;
						s.cbType = cbType;
					
						s = new Polygon(
							[   Vec2.weak(84.5,869)   ,  Vec2.weak(51.5,493)   ,  Vec2.weak(0,2047.5)   ],
							mat,
							filt
						);
						s.body = body;
						s.fluidEnabled = false;
						s.fluidProperties = prop;
						s.cbType = cbType;
					
				
			

			anchor = (true) ? body.localCOM.copy() : Vec2.get(0,0);
			body.translateShapes(Vec2.weak(-anchor.x,-anchor.y));
			body.position.setxy(0,0);

			bodies["tmp"] = new BodyPair(body,anchor);
		
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
