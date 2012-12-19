package assets.levels{

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

public class level2Data {

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
			//body.cbType = cbtype("null");

			
				mat = material("default");
				filt = filter("default");
				prop = fprop("default");
				//cbType = cbtype("null");

				
					
						s = new Polygon(
							[   Vec2.weak(98.5,1207)   ,  Vec2.weak(125.5,1113)   ,  Vec2.weak(9,1231.5)   ],
							mat,
							filt
						);
						s.body = body;
						s.fluidEnabled = false;
						s.fluidProperties = prop;
						//s.cbType = cbType;
					
						s = new Polygon(
							[   Vec2.weak(441,1888.5)   ,  Vec2.weak(362,1919.5)   ,  Vec2.weak(557.5,1957)   ,  Vec2.weak(535,1927.5)   ],
							mat,
							filt
						);
						s.body = body;
						s.fluidEnabled = false;
						s.fluidProperties = prop;
						//s.cbType = cbType;
					
						s = new Polygon(
							[   Vec2.weak(1098,1888.5)   ,  Vec2.weak(1019,1919.5)   ,  Vec2.weak(936,1970.5)   ,  Vec2.weak(1193,1928.5)   ],
							mat,
							filt
						);
						s.body = body;
						s.fluidEnabled = false;
						s.fluidProperties = prop;
						//s.cbType = cbType;
					
						s = new Polygon(
							[   Vec2.weak(377.5,416)   ,  Vec2.weak(346.5,337)   ,  Vec2.weak(336.5,513)   ],
							mat,
							filt
						);
						s.body = body;
						s.fluidEnabled = false;
						s.fluidProperties = prop;
						//s.cbType = cbType;
					
						s = new Polygon(
							[   Vec2.weak(256.5,1024)   ,  Vec2.weak(336.5,920)   ,  Vec2.weak(334.5,912)   ,  Vec2.weak(313.5,869)   ,  Vec2.weak(296.5,841)   ,  Vec2.weak(166,1033.5)   ],
							mat,
							filt
						);
						s.body = body;
						s.fluidEnabled = false;
						s.fluidProperties = prop;
						//s.cbType = cbType;
					
						s = new Polygon(
							[   Vec2.weak(1283,1024.5)   ,  Vec2.weak(1373.5,1034)   ,  Vec2.weak(1242.5,841)   ,  Vec2.weak(1225.5,869)   ,  Vec2.weak(1204.5,912)   ,  Vec2.weak(1202.5,920)   ],
							mat,
							filt
						);
						s.body = body;
						s.fluidEnabled = false;
						s.fluidProperties = prop;
						//s.cbType = cbType;
					
						s = new Polygon(
							[   Vec2.weak(358.5,82)   ,  Vec2.weak(358,79.5)   ,  Vec2.weak(353.5,76)   ,  Vec2.weak(352,77.5)   ],
							mat,
							filt
						);
						s.body = body;
						s.fluidEnabled = false;
						s.fluidProperties = prop;
						//s.cbType = cbType;
					
						s = new Polygon(
							[   Vec2.weak(353.5,76)   ,  Vec2.weak(354,72.5)   ,  Vec2.weak(358,-0.5)   ,  Vec2.weak(2,-0.5)   ,  Vec2.weak(352,77.5)   ],
							mat,
							filt
						);
						s.body = body;
						s.fluidEnabled = false;
						s.fluidProperties = prop;
						//s.cbType = cbType;
					
						s = new Polygon(
							[   Vec2.weak(1221.5,491)   ,  Vec2.weak(1199.5,543)   ,  Vec2.weak(1192.5,597)   ,  Vec2.weak(1192.5,614)   ,  Vec2.weak(1198.5,671)   ,  Vec2.weak(1245.5,833)   ,  Vec2.weak(1321,495.5)   ,  Vec2.weak(1237,490.5)   ],
							mat,
							filt
						);
						s.body = body;
						s.fluidEnabled = false;
						s.fluidProperties = prop;
						//s.cbType = cbType;
					
						s = new Polygon(
							[   Vec2.weak(345.5,738)   ,  Vec2.weak(340.5,671)   ,  Vec2.weak(293.5,833)   ],
							mat,
							filt
						);
						s.body = body;
						s.fluidEnabled = false;
						s.fluidProperties = prop;
						//s.cbType = cbType;
					
						s = new Polygon(
							[   Vec2.weak(1193.5,738)   ,  Vec2.weak(1245.5,833)   ,  Vec2.weak(1198.5,671)   ],
							mat,
							filt
						);
						s.body = body;
						s.fluidEnabled = false;
						s.fluidProperties = prop;
						//s.cbType = cbType;
					
						s = new Polygon(
							[   Vec2.weak(1204,118.5)   ,  Vec2.weak(1205.5,118)   ,  Vec2.weak(1219,94.5)   ,  Vec2.weak(1200.5,0)   ,  Vec2.weak(1200.5,111)   ],
							mat,
							filt
						);
						s.body = body;
						s.fluidEnabled = false;
						s.fluidProperties = prop;
						//s.cbType = cbType;
					
						s = new Polygon(
							[   Vec2.weak(1219,94.5)   ,  Vec2.weak(1253,66.5)   ,  Vec2.weak(1200.5,0)   ],
							mat,
							filt
						);
						s.body = body;
						s.fluidEnabled = false;
						s.fluidProperties = prop;
						//s.cbType = cbType;
					
						s = new Polygon(
							[   Vec2.weak(1253,66.5)   ,  Vec2.weak(1395,66.5)   ,  Vec2.weak(1539,-0.5)   ,  Vec2.weak(1200.5,0)   ],
							mat,
							filt
						);
						s.body = body;
						s.fluidEnabled = false;
						s.fluidProperties = prop;
						//s.cbType = cbType;
					
						s = new Polygon(
							[   Vec2.weak(1395,66.5)   ,  Vec2.weak(1444,69.5)   ,  Vec2.weak(1539,-0.5)   ],
							mat,
							filt
						);
						s.body = body;
						s.fluidEnabled = false;
						s.fluidProperties = prop;
						//s.cbType = cbType;
					
						s = new Polygon(
							[   Vec2.weak(1444,69.5)   ,  Vec2.weak(1507,98.5)   ,  Vec2.weak(1539,-0.5)   ],
							mat,
							filt
						);
						s.body = body;
						s.fluidEnabled = false;
						s.fluidProperties = prop;
						//s.cbType = cbType;
					
						s = new Polygon(
							[   Vec2.weak(1202.5,1720)   ,  Vec2.weak(1193.5,1796)   ,  Vec2.weak(1197.5,1878)   ,  Vec2.weak(1283,1713.5)   ,  Vec2.weak(1215,1717.5)   ],
							mat,
							filt
						);
						s.body = body;
						s.fluidEnabled = false;
						s.fluidProperties = prop;
						//s.cbType = cbType;
					
						s = new Polygon(
							[   Vec2.weak(1283,1713.5)   ,  Vec2.weak(1197.5,1878)   ,  Vec2.weak(1194.5,1923)   ,  Vec2.weak(1329,1697.5)   ],
							mat,
							filt
						);
						s.body = body;
						s.fluidEnabled = false;
						s.fluidProperties = prop;
						//s.cbType = cbType;
					
						s = new Polygon(
							[   Vec2.weak(1003.5,1921)   ,  Vec2.weak(1003,1923.5)   ,  Vec2.weak(1019,1919.5)   ],
							mat,
							filt
						);
						s.body = body;
						s.fluidEnabled = false;
						s.fluidProperties = prop;
						//s.cbType = cbType;
					
						s = new Polygon(
							[   Vec2.weak(336,1719.5)   ,  Vec2.weak(324,1717.5)   ,  Vec2.weak(256,1713.5)   ,  Vec2.weak(341.5,1864)   ,  Vec2.weak(345.5,1796)   ],
							mat,
							filt
						);
						s.body = body;
						s.fluidEnabled = false;
						s.fluidProperties = prop;
						//s.cbType = cbType;
					
						s = new Polygon(
							[   Vec2.weak(256,1713.5)   ,  Vec2.weak(209.5,1697)   ,  Vec2.weak(0,2047.5)   ,  Vec2.weak(344.5,1920)   ,  Vec2.weak(341.5,1864)   ],
							mat,
							filt
						);
						s.body = body;
						s.fluidEnabled = false;
						s.fluidProperties = prop;
						//s.cbType = cbType;
					
						s = new Polygon(
							[   Vec2.weak(1419,477.5)   ,  Vec2.weak(1409,483.5)   ,  Vec2.weak(1386,506.5)   ,  Vec2.weak(1455,474.5)   ,  Vec2.weak(1431,474.5)   ],
							mat,
							filt
						);
						s.body = body;
						s.fluidEnabled = false;
						s.fluidProperties = prop;
						//s.cbType = cbType;
					
						s = new Polygon(
							[   Vec2.weak(43.5,1314)   ,  Vec2.weak(31,1300.5)   ,  Vec2.weak(13.5,1285)   ,  Vec2.weak(0,2047.5)   ,  Vec2.weak(47.5,1394)   ],
							mat,
							filt
						);
						s.body = body;
						s.fluidEnabled = false;
						s.fluidProperties = prop;
						//s.cbType = cbType;
					
						s = new Polygon(
							[   Vec2.weak(1,-0.5)   ,  Vec2.weak(-0.5,0)   ,  Vec2.weak(8.5,1240)   ,  Vec2.weak(9,1231.5)   ,  Vec2.weak(2,-0.5)   ],
							mat,
							filt
						);
						s.body = body;
						s.fluidEnabled = false;
						s.fluidProperties = prop;
						//s.cbType = cbType;
					
						s = new Polygon(
							[   Vec2.weak(1495.5,1314)   ,  Vec2.weak(1491.5,1394)   ,  Vec2.weak(1539.5,2047)   ,  Vec2.weak(1525,1285.5)   ,  Vec2.weak(1507.5,1301)   ],
							mat,
							filt
						);
						s.body = body;
						s.fluidEnabled = false;
						s.fluidProperties = prop;
						//s.cbType = cbType;
					
						s = new Polygon(
							[   Vec2.weak(157.5,1548)   ,  Vec2.weak(123.5,1512)   ,  Vec2.weak(198.5,1662)   ],
							mat,
							filt
						);
						s.body = body;
						s.fluidEnabled = false;
						s.fluidProperties = prop;
						//s.cbType = cbType;
					
						s = new Polygon(
							[   Vec2.weak(346.5,201)   ,  Vec2.weak(334.5,119)   ,  Vec2.weak(340.5,274)   ],
							mat,
							filt
						);
						s.body = body;
						s.fluidEnabled = false;
						s.fluidProperties = prop;
						//s.cbType = cbType;
					
						s = new Polygon(
							[   Vec2.weak(125.5,1113)   ,  Vec2.weak(166,1033.5)   ,  Vec2.weak(9,1231.5)   ],
							mat,
							filt
						);
						s.body = body;
						s.fluidEnabled = false;
						s.fluidProperties = prop;
						//s.cbType = cbType;
					
						s = new Polygon(
							[   Vec2.weak(1455,474.5)   ,  Vec2.weak(1341,527.5)   ,  Vec2.weak(1530.5,1232)   ,  Vec2.weak(1508,464.5)   ],
							mat,
							filt
						);
						s.body = body;
						s.fluidEnabled = false;
						s.fluidProperties = prop;
						//s.cbType = cbType;
					
						s = new Polygon(
							[   Vec2.weak(1381.5,1548)   ,  Vec2.weak(1329,1697.5)   ,  Vec2.weak(1415.5,1512)   ],
							mat,
							filt
						);
						s.body = body;
						s.fluidEnabled = false;
						s.fluidProperties = prop;
						//s.cbType = cbType;
					
						s = new Polygon(
							[   Vec2.weak(358.5,75)   ,  Vec2.weak(358,-0.5)   ,  Vec2.weak(354,72.5)   ],
							mat,
							filt
						);
						s.body = body;
						s.fluidEnabled = false;
						s.fluidProperties = prop;
						//s.cbType = cbType;
					
						s = new Polygon(
							[   Vec2.weak(1003,1923.5)   ,  Vec2.weak(936,1970.5)   ,  Vec2.weak(1019,1919.5)   ],
							mat,
							filt
						);
						s.body = body;
						s.fluidEnabled = false;
						s.fluidProperties = prop;
						//s.cbType = cbType;
					
						s = new Polygon(
							[   Vec2.weak(1325.5,500)   ,  Vec2.weak(1321,495.5)   ,  Vec2.weak(1245.5,833)   ,  Vec2.weak(1530.5,1232)   ,  Vec2.weak(1338.5,526)   ],
							mat,
							filt
						);
						s.body = body;
						s.fluidEnabled = false;
						s.fluidProperties = prop;
						//s.cbType = cbType;
					
						s = new Polygon(
							[   Vec2.weak(340.5,671)   ,  Vec2.weak(346.5,614)   ,  Vec2.weak(346.5,597)   ,  Vec2.weak(336.5,526)   ,  Vec2.weak(2,-0.5)   ,  Vec2.weak(9,1231.5)   ,  Vec2.weak(293.5,833)   ],
							mat,
							filt
						);
						s.body = body;
						s.fluidEnabled = false;
						s.fluidProperties = prop;
						//s.cbType = cbType;
					
						s = new Polygon(
							[   Vec2.weak(85.5,1447)   ,  Vec2.weak(47.5,1394)   ,  Vec2.weak(0,2047.5)   ,  Vec2.weak(209.5,1697)   ,  Vec2.weak(198.5,1662)   ,  Vec2.weak(123.5,1512)   ],
							mat,
							filt
						);
						s.body = body;
						s.fluidEnabled = false;
						s.fluidProperties = prop;
						//s.cbType = cbType;
					
						s = new Polygon(
							[   Vec2.weak(1453.5,1447)   ,  Vec2.weak(1415.5,1512)   ,  Vec2.weak(1329,1697.5)   ,  Vec2.weak(1539.5,2047)   ,  Vec2.weak(1491.5,1394)   ],
							mat,
							filt
						);
						s.body = body;
						s.fluidEnabled = false;
						s.fluidProperties = prop;
						//s.cbType = cbType;
					
						s = new Polygon(
							[   Vec2.weak(346.5,337)   ,  Vec2.weak(340.5,274)   ,  Vec2.weak(336.5,513)   ],
							mat,
							filt
						);
						s.body = body;
						s.fluidEnabled = false;
						s.fluidProperties = prop;
						//s.cbType = cbType;
					
						s = new Polygon(
							[   Vec2.weak(1441,1207.5)   ,  Vec2.weak(1530.5,1232)   ,  Vec2.weak(1413.5,1113)   ,  Vec2.weak(1438.5,1203)   ],
							mat,
							filt
						);
						s.body = body;
						s.fluidEnabled = false;
						s.fluidProperties = prop;
						//s.cbType = cbType;
					
						s = new Polygon(
							[   Vec2.weak(1413.5,1113)   ,  Vec2.weak(1530.5,1232)   ,  Vec2.weak(1373.5,1034)   ],
							mat,
							filt
						);
						s.body = body;
						s.fluidEnabled = false;
						s.fluidProperties = prop;
						//s.cbType = cbType;
					
						s = new Polygon(
							[   Vec2.weak(557.5,1957)   ,  Vec2.weak(362,1919.5)   ,  Vec2.weak(344.5,1920)   ,  Vec2.weak(0,2047.5)   ,  Vec2.weak(605,1975.5)   ],
							mat,
							filt
						);
						s.body = body;
						s.fluidEnabled = false;
						s.fluidProperties = prop;
						//s.cbType = cbType;
					
						s = new Polygon(
							[   Vec2.weak(166,1033.5)   ,  Vec2.weak(296.5,841)   ,  Vec2.weak(293.5,833)   ,  Vec2.weak(9,1231.5)   ],
							mat,
							filt
						);
						s.body = body;
						s.fluidEnabled = false;
						s.fluidProperties = prop;
						//s.cbType = cbType;
					
						s = new Polygon(
							[   Vec2.weak(1373.5,1034)   ,  Vec2.weak(1530.5,1232)   ,  Vec2.weak(1245.5,833)   ,  Vec2.weak(1242.5,841)   ],
							mat,
							filt
						);
						s.body = body;
						s.fluidEnabled = false;
						s.fluidProperties = prop;
						//s.cbType = cbType;
					
						s = new Polygon(
							[   Vec2.weak(1507,98.5)   ,  Vec2.weak(1509.5,100)   ,  Vec2.weak(1539,-0.5)   ],
							mat,
							filt
						);
						s.body = body;
						s.fluidEnabled = false;
						s.fluidProperties = prop;
						//s.cbType = cbType;
					
						s = new Polygon(
							[   Vec2.weak(1509.5,100)   ,  Vec2.weak(1521.5,126)   ,  Vec2.weak(1539,-0.5)   ],
							mat,
							filt
						);
						s.body = body;
						s.fluidEnabled = false;
						s.fluidProperties = prop;
						//s.cbType = cbType;
					
						s = new Polygon(
							[   Vec2.weak(1521.5,126)   ,  Vec2.weak(1528.5,195)   ,  Vec2.weak(1539,-0.5)   ],
							mat,
							filt
						);
						s.body = body;
						s.fluidEnabled = false;
						s.fluidProperties = prop;
						//s.cbType = cbType;
					
						s = new Polygon(
							[   Vec2.weak(1505.5,387)   ,  Vec2.weak(1510.5,438)   ,  Vec2.weak(1528.5,211)   ,  Vec2.weak(1505.5,369)   ],
							mat,
							filt
						);
						s.body = body;
						s.fluidEnabled = false;
						s.fluidProperties = prop;
						//s.cbType = cbType;
					
						s = new Polygon(
							[   Vec2.weak(340.5,274)   ,  Vec2.weak(334.5,119)   ,  Vec2.weak(2,-0.5)   ,  Vec2.weak(336.5,513)   ],
							mat,
							filt
						);
						s.body = body;
						s.fluidEnabled = false;
						s.fluidProperties = prop;
						//s.cbType = cbType;
					
						s = new Polygon(
							[   Vec2.weak(352,77.5)   ,  Vec2.weak(2,-0.5)   ,  Vec2.weak(334.5,119)   ],
							mat,
							filt
						);
						s.body = body;
						s.fluidEnabled = false;
						s.fluidProperties = prop;
						//s.cbType = cbType;
					
						s = new Polygon(
							[   Vec2.weak(336.5,513)   ,  Vec2.weak(2,-0.5)   ,  Vec2.weak(336.5,526)   ],
							mat,
							filt
						);
						s.body = body;
						s.fluidEnabled = false;
						s.fluidProperties = prop;
						//s.cbType = cbType;
					
						s = new Polygon(
							[   Vec2.weak(1194.5,1923)   ,  Vec2.weak(1193,1928.5)   ,  Vec2.weak(1539.5,2047)   ,  Vec2.weak(1329,1697.5)   ],
							mat,
							filt
						);
						s.body = body;
						s.fluidEnabled = false;
						s.fluidProperties = prop;
						//s.cbType = cbType;
					
						s = new Polygon(
							[   Vec2.weak(1539,-0.5)   ,  Vec2.weak(1528.5,195)   ,  Vec2.weak(1539.5,2047)   ],
							mat,
							filt
						);
						s.body = body;
						s.fluidEnabled = false;
						s.fluidProperties = prop;
						//s.cbType = cbType;
					
						s = new Polygon(
							[   Vec2.weak(1510.5,438)   ,  Vec2.weak(1530.5,1232)   ,  Vec2.weak(1528.5,211)   ],
							mat,
							filt
						);
						s.body = body;
						s.fluidEnabled = false;
						s.fluidProperties = prop;
						//s.cbType = cbType;
					
						s = new Polygon(
							[   Vec2.weak(1338.5,526)   ,  Vec2.weak(1530.5,1232)   ,  Vec2.weak(1341,527.5)   ],
							mat,
							filt
						);
						s.body = body;
						s.fluidEnabled = false;
						s.fluidProperties = prop;
						//s.cbType = cbType;
					
						s = new Polygon(
							[   Vec2.weak(1508,464.5)   ,  Vec2.weak(1530.5,1232)   ,  Vec2.weak(1510.5,454)   ],
							mat,
							filt
						);
						s.body = body;
						s.fluidEnabled = false;
						s.fluidProperties = prop;
						//s.cbType = cbType;
					
						s = new Polygon(
							[   Vec2.weak(-0.5,0)   ,  Vec2.weak(0,2047.5)   ,  Vec2.weak(8.5,1240)   ],
							mat,
							filt
						);
						s.body = body;
						s.fluidEnabled = false;
						s.fluidProperties = prop;
						//s.cbType = cbType;
					
						s = new Polygon(
							[   Vec2.weak(8.5,1240)   ,  Vec2.weak(0,2047.5)   ,  Vec2.weak(13.5,1285)   ],
							mat,
							filt
						);
						s.body = body;
						s.fluidEnabled = false;
						s.fluidProperties = prop;
						//s.cbType = cbType;
					
						s = new Polygon(
							[   Vec2.weak(0,2047.5)   ,  Vec2.weak(1539.5,2047)   ,  Vec2.weak(759,1977.5)   ,  Vec2.weak(605,1975.5)   ],
							mat,
							filt
						);
						s.body = body;
						s.fluidEnabled = false;
						s.fluidProperties = prop;
						//s.cbType = cbType;
					
						s = new Polygon(
							[   Vec2.weak(759,1977.5)   ,  Vec2.weak(1539.5,2047)   ,  Vec2.weak(936,1970.5)   ],
							mat,
							filt
						);
						s.body = body;
						s.fluidEnabled = false;
						s.fluidProperties = prop;
						//s.cbType = cbType;
					
						s = new Polygon(
							[   Vec2.weak(936,1970.5)   ,  Vec2.weak(1539.5,2047)   ,  Vec2.weak(1193,1928.5)   ],
							mat,
							filt
						);
						s.body = body;
						s.fluidEnabled = false;
						s.fluidProperties = prop;
						//s.cbType = cbType;
					
						s = new Polygon(
							[   Vec2.weak(1525,1285.5)   ,  Vec2.weak(1539.5,2047)   ,  Vec2.weak(1530.5,1232)   ],
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

			bodies["level2Decor"] = new BodyPair(body,anchor);
		
			body = new Body(BodyType.STATIC);
			//body.cbType = cbtype("null");

			
				mat = material("default");
				filt = filter("default");
				prop = fprop("default");
				//cbType = cbtype("null");

				
					
						s = new Polygon(
							[   Vec2.weak(1209.5,1177)   ,  Vec2.weak(1135,1089.5)   ,  Vec2.weak(1133,1333.5)   ,  Vec2.weak(1166.5,1299)   ],
							mat,
							filt
						);
						s.body = body;
						s.fluidEnabled = false;
						s.fluidProperties = prop;
						//s.cbType = cbType;
					
						s = new Polygon(
							[   Vec2.weak(580.5,0)   ,  Vec2.weak(580.5,120)   ,  Vec2.weak(585.5,124)   ,  Vec2.weak(875,-0.5)   ],
							mat,
							filt
						);
						s.body = body;
						s.fluidEnabled = false;
						s.fluidProperties = prop;
						//s.cbType = cbType;
					
						s = new Polygon(
							[   Vec2.weak(1094,1001.5)   ,  Vec2.weak(949.5,974)   ,  Vec2.weak(946,1530.5)   ,  Vec2.weak(1130.5,1087)   ],
							mat,
							filt
						);
						s.body = body;
						s.fluidEnabled = false;
						s.fluidProperties = prop;
						//s.cbType = cbType;
					
						s = new Polygon(
							[   Vec2.weak(986.5,1631)   ,  Vec2.weak(945.5,1534)   ,  Vec2.weak(593.5,1534)   ,  Vec2.weak(563.5,1660)   ,  Vec2.weak(567,1664.5)   ,  Vec2.weak(955.5,1710)   ],
							mat,
							filt
						);
						s.body = body;
						s.fluidEnabled = false;
						s.fluidProperties = prop;
						//s.cbType = cbType;
					
						s = new Polygon(
							[   Vec2.weak(552.5,1631)   ,  Vec2.weak(563.5,1660)   ,  Vec2.weak(593.5,1534)   ],
							mat,
							filt
						);
						s.body = body;
						s.fluidEnabled = false;
						s.fluidProperties = prop;
						//s.cbType = cbType;
					
						s = new Polygon(
							[   Vec2.weak(582.5,647)   ,  Vec2.weak(596.5,729)   ,  Vec2.weak(590.5,573)   ],
							mat,
							filt
						);
						s.body = body;
						s.fluidEnabled = false;
						s.fluidProperties = prop;
						//s.cbType = cbType;
					
						s = new Polygon(
							[   Vec2.weak(956.5,647)   ,  Vec2.weak(948.5,575)   ,  Vec2.weak(942.5,729)   ],
							mat,
							filt
						);
						s.body = body;
						s.fluidEnabled = false;
						s.fluidProperties = prop;
						//s.cbType = cbType;
					
						s = new Polygon(
							[   Vec2.weak(1133,1333.5)   ,  Vec2.weak(1135,1089.5)   ,  Vec2.weak(1130.5,1087)   ,  Vec2.weak(946,1530.5)   ,  Vec2.weak(1057.5,1452)   ,  Vec2.weak(1094.5,1400)   ],
							mat,
							filt
						);
						s.body = body;
						s.fluidEnabled = false;
						s.fluidProperties = prop;
						//s.cbType = cbType;
					
						s = new Polygon(
							[   Vec2.weak(372.5,1299)   ,  Vec2.weak(406.5,1334)   ,  Vec2.weak(329.5,1178)   ],
							mat,
							filt
						);
						s.body = body;
						s.fluidEnabled = false;
						s.fluidProperties = prop;
						//s.cbType = cbType;
					
						s = new Polygon(
							[   Vec2.weak(555.5,826)   ,  Vec2.weak(561.5,848)   ,  Vec2.weak(582.5,910)   ,  Vec2.weak(596.5,729)   ],
							mat,
							filt
						);
						s.body = body;
						s.fluidEnabled = false;
						s.fluidProperties = prop;
						//s.cbType = cbType;
					
						s = new Polygon(
							[   Vec2.weak(482,1452.5)   ,  Vec2.weak(593.5,1531)   ,  Vec2.weak(589,974.5)   ,  Vec2.weak(408,1087.5)   ,  Vec2.weak(330.5,1175)   ,  Vec2.weak(329.5,1178)   ,  Vec2.weak(406.5,1334)   ,  Vec2.weak(444.5,1400)   ],
							mat,
							filt
						);
						s.body = body;
						s.fluidEnabled = false;
						s.fluidProperties = prop;
						//s.cbType = cbType;
					
						s = new Polygon(
							[   Vec2.weak(954.5,251)   ,  Vec2.weak(950.5,169)   ,  Vec2.weak(876,-0.5)   ,  Vec2.weak(593.5,1531)   ,  Vec2.weak(593.5,1534)   ,  Vec2.weak(944.5,331)   ],
							mat,
							filt
						);
						s.body = body;
						s.fluidEnabled = false;
						s.fluidProperties = prop;
						//s.cbType = cbType;
					
						s = new Polygon(
							[   Vec2.weak(584.5,251)   ,  Vec2.weak(594.5,331)   ,  Vec2.weak(875,-0.5)   ,  Vec2.weak(588.5,169)   ],
							mat,
							filt
						);
						s.body = body;
						s.fluidEnabled = false;
						s.fluidProperties = prop;
						//s.cbType = cbType;
					
						s = new Polygon(
							[   Vec2.weak(952.5,1750)   ,  Vec2.weak(955.5,1710)   ,  Vec2.weak(567,1664.5)   ,  Vec2.weak(950,1751.5)   ],
							mat,
							filt
						);
						s.body = body;
						s.fluidEnabled = false;
						s.fluidProperties = prop;
						//s.cbType = cbType;
					
						s = new Polygon(
							[   Vec2.weak(582.5,910)   ,  Vec2.weak(589.5,973)   ,  Vec2.weak(876,-0.5)   ,  Vec2.weak(875,-0.5)   ,  Vec2.weak(596.5,729)   ],
							mat,
							filt
						);
						s.body = body;
						s.fluidEnabled = false;
						s.fluidProperties = prop;
						//s.cbType = cbType;
					
						s = new Polygon(
							[   Vec2.weak(987.5,433)   ,  Vec2.weak(986.5,427)   ,  Vec2.weak(944.5,331)   ,  Vec2.weak(962.5,492)   ],
							mat,
							filt
						);
						s.body = body;
						s.fluidEnabled = false;
						s.fluidProperties = prop;
						//s.cbType = cbType;
					
						s = new Polygon(
							[   Vec2.weak(962.5,492)   ,  Vec2.weak(944.5,331)   ,  Vec2.weak(955.5,512)   ],
							mat,
							filt
						);
						s.body = body;
						s.fluidEnabled = false;
						s.fluidProperties = prop;
						//s.cbType = cbType;
					
						s = new Polygon(
							[   Vec2.weak(955.5,512)   ,  Vec2.weak(944.5,331)   ,  Vec2.weak(948.5,575)   ],
							mat,
							filt
						);
						s.body = body;
						s.fluidEnabled = false;
						s.fluidProperties = prop;
						//s.cbType = cbType;
					
						s = new Polygon(
							[   Vec2.weak(959.5,111)   ,  Vec2.weak(959.5,1)   ,  Vec2.weak(959,-0.5)   ,  Vec2.weak(876,-0.5)   ,  Vec2.weak(955,112.5)   ],
							mat,
							filt
						);
						s.body = body;
						s.fluidEnabled = false;
						s.fluidProperties = prop;
						//s.cbType = cbType;
					
						s = new Polygon(
							[   Vec2.weak(551.5,433)   ,  Vec2.weak(582.5,507)   ,  Vec2.weak(594.5,331)   ,  Vec2.weak(552.5,427)   ],
							mat,
							filt
						);
						s.body = body;
						s.fluidEnabled = false;
						s.fluidProperties = prop;
						//s.cbType = cbType;
					
						s = new Polygon(
							[   Vec2.weak(582.5,507)   ,  Vec2.weak(590.5,573)   ,  Vec2.weak(594.5,331)   ],
							mat,
							filt
						);
						s.body = body;
						s.fluidEnabled = false;
						s.fluidProperties = prop;
						//s.cbType = cbType;
					
						s = new Polygon(
							[   Vec2.weak(590.5,573)   ,  Vec2.weak(596.5,729)   ,  Vec2.weak(875,-0.5)   ,  Vec2.weak(594.5,331)   ],
							mat,
							filt
						);
						s.body = body;
						s.fluidEnabled = false;
						s.fluidProperties = prop;
						//s.cbType = cbType;
					
						s = new Polygon(
							[   Vec2.weak(948.5,575)   ,  Vec2.weak(944.5,331)   ,  Vec2.weak(593.5,1534)   ,  Vec2.weak(942.5,729)   ],
							mat,
							filt
						);
						s.body = body;
						s.fluidEnabled = false;
						s.fluidProperties = prop;
						//s.cbType = cbType;
					
						s = new Polygon(
							[   Vec2.weak(444.5,1002)   ,  Vec2.weak(408,1087.5)   ,  Vec2.weak(575,977.5)   ,  Vec2.weak(447,1000.5)   ],
							mat,
							filt
						);
						s.body = body;
						s.fluidEnabled = false;
						s.fluidProperties = prop;
						//s.cbType = cbType;
					
						s = new Polygon(
							[   Vec2.weak(575,977.5)   ,  Vec2.weak(408,1087.5)   ,  Vec2.weak(589,974.5)   ],
							mat,
							filt
						);
						s.body = body;
						s.fluidEnabled = false;
						s.fluidProperties = prop;
						//s.cbType = cbType;
					
						s = new Polygon(
							[   Vec2.weak(585.5,124)   ,  Vec2.weak(588.5,169)   ,  Vec2.weak(875,-0.5)   ],
							mat,
							filt
						);
						s.body = body;
						s.fluidEnabled = false;
						s.fluidProperties = prop;
						//s.cbType = cbType;
					
						s = new Polygon(
							[   Vec2.weak(403.5,1090)   ,  Vec2.weak(330.5,1175)   ,  Vec2.weak(408,1087.5)   ],
							mat,
							filt
						);
						s.body = body;
						s.fluidEnabled = false;
						s.fluidProperties = prop;
						//s.cbType = cbType;
					
						s = new Polygon(
							[   Vec2.weak(983.5,826)   ,  Vec2.weak(942.5,729)   ,  Vec2.weak(956.5,910)   ,  Vec2.weak(983.5,829)   ],
							mat,
							filt
						);
						s.body = body;
						s.fluidEnabled = false;
						s.fluidProperties = prop;
						//s.cbType = cbType;
					
						s = new Polygon(
							[   Vec2.weak(956.5,910)   ,  Vec2.weak(942.5,729)   ,  Vec2.weak(949.5,974)   ],
							mat,
							filt
						);
						s.body = body;
						s.fluidEnabled = false;
						s.fluidProperties = prop;
						//s.cbType = cbType;
					
						s = new Polygon(
							[   Vec2.weak(942.5,729)   ,  Vec2.weak(593.5,1534)   ,  Vec2.weak(945.5,1534)   ,  Vec2.weak(946,1530.5)   ],
							mat,
							filt
						);
						s.body = body;
						s.fluidEnabled = false;
						s.fluidProperties = prop;
						//s.cbType = cbType;
					
						s = new Polygon(
							[   Vec2.weak(955,112.5)   ,  Vec2.weak(876,-0.5)   ,  Vec2.weak(954.5,114)   ],
							mat,
							filt
						);
						s.body = body;
						s.fluidEnabled = false;
						s.fluidProperties = prop;
						//s.cbType = cbType;
					
						s = new Polygon(
							[   Vec2.weak(954.5,114)   ,  Vec2.weak(876,-0.5)   ,  Vec2.weak(950.5,169)   ],
							mat,
							filt
						);
						s.body = body;
						s.fluidEnabled = false;
						s.fluidProperties = prop;
						//s.cbType = cbType;
					
						s = new Polygon(
							[   Vec2.weak(589,974.5)   ,  Vec2.weak(593.5,1531)   ,  Vec2.weak(589.5,973)   ],
							mat,
							filt
						);
						s.body = body;
						s.fluidEnabled = false;
						s.fluidProperties = prop;
						//s.cbType = cbType;
					
						s = new Polygon(
							[   Vec2.weak(589.5,973)   ,  Vec2.weak(593.5,1531)   ,  Vec2.weak(876,-0.5)   ],
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

			bodies["level2Decor (2)"] = new BodyPair(body,anchor);
		
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
