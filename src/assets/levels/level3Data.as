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

public class level3Data {

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
							[   Vec2.weak(341.5,666)   ,  Vec2.weak(335.5,659)   ,  Vec2.weak(335.5,671)   ],
							mat,
							filt
						);
						s.body = body;
						s.fluidEnabled = false;
						s.fluidProperties = prop;
						//s.cbType = cbType;
					
						s = new Polygon(
							[   Vec2.weak(901,1732.5)   ,  Vec2.weak(845,1787.5)   ,  Vec2.weak(935,1764.5)   ],
							mat,
							filt
						);
						s.body = body;
						s.fluidEnabled = false;
						s.fluidProperties = prop;
						//s.cbType = cbType;
					
						s = new Polygon(
							[   Vec2.weak(1548,1492.5)   ,  Vec2.weak(1606.5,1436)   ,  Vec2.weak(1609,1427.5)   ,  Vec2.weak(1489,1197.5)   ,  Vec2.weak(1311,1192.5)   ,  Vec2.weak(1308.5,1194)   ,  Vec2.weak(1317.5,1272)   ],
							mat,
							filt
						);
						s.body = body;
						s.fluidEnabled = false;
						s.fluidProperties = prop;
						//s.cbType = cbType;
					
						s = new Polygon(
							[   Vec2.weak(1936.5,1846)   ,  Vec2.weak(1931.5,1951)   ,  Vec2.weak(2047.5,2047)   ,  Vec2.weak(2026,1798.5)   ],
							mat,
							filt
						);
						s.body = body;
						s.fluidEnabled = false;
						s.fluidProperties = prop;
						//s.cbType = cbType;
					
						s = new Polygon(
							[   Vec2.weak(1178,1689.5)   ,  Vec2.weak(1088,1766.5)   ,  Vec2.weak(1335,1765.5)   ,  Vec2.weak(1298,1731.5)   ],
							mat,
							filt
						);
						s.body = body;
						s.fluidEnabled = false;
						s.fluidProperties = prop;
						//s.cbType = cbType;
					
						s = new Polygon(
							[   Vec2.weak(500,1732.5)   ,  Vec2.weak(440,1790.5)   ,  Vec2.weak(535,1764.5)   ],
							mat,
							filt
						);
						s.body = body;
						s.fluidEnabled = false;
						s.fluidProperties = prop;
						//s.cbType = cbType;
					
						s = new Polygon(
							[   Vec2.weak(1711.5,1378)   ,  Vec2.weak(1716.5,1288)   ,  Vec2.weak(1716.5,1251)   ,  Vec2.weak(1668.5,1135)   ,  Vec2.weak(1609.5,1033)   ,  Vec2.weak(1513.5,1064)   ,  Vec2.weak(1489,1197.5)   ,  Vec2.weak(1609,1427.5)   ],
							mat,
							filt
						);
						s.body = body;
						s.fluidEnabled = false;
						s.fluidProperties = prop;
						//s.cbType = cbType;
					
						s = new Polygon(
							[   Vec2.weak(1873,872.5)   ,  Vec2.weak(1936.5,880)   ,  Vec2.weak(1924,763.5)   ,  Vec2.weak(1859,813.5)   ,  Vec2.weak(1847.5,824)   ],
							mat,
							filt
						);
						s.body = body;
						s.fluidEnabled = false;
						s.fluidProperties = prop;
						//s.cbType = cbType;
					
						s = new Polygon(
							[   Vec2.weak(1936.5,1357)   ,  Vec2.weak(1941.5,1408)   ,  Vec2.weak(2006.5,1516)   ,  Vec2.weak(2024,1311.5)   ],
							mat,
							filt
						);
						s.body = body;
						s.fluidEnabled = false;
						s.fluidProperties = prop;
						//s.cbType = cbType;
					
						s = new Polygon(
							[   Vec2.weak(1642,1790.5)   ,  Vec2.weak(1489,1768.5)   ,  Vec2.weak(1335,1765.5)   ,  Vec2.weak(1707.5,1891)   ],
							mat,
							filt
						);
						s.body = body;
						s.fluidEnabled = false;
						s.fluidProperties = prop;
						//s.cbType = cbType;
					
						s = new Polygon(
							[   Vec2.weak(1696,1137.5)   ,  Vec2.weak(1668.5,1135)   ,  Vec2.weak(1716.5,1251)   ,  Vec2.weak(1713.5,1189)   ],
							mat,
							filt
						);
						s.body = body;
						s.fluidEnabled = false;
						s.fluidProperties = prop;
						//s.cbType = cbType;
					
						s = new Polygon(
							[   Vec2.weak(757,505.5)   ,  Vec2.weak(778,502.5)   ,  Vec2.weak(743.5,450)   ],
							mat,
							filt
						);
						s.body = body;
						s.fluidEnabled = false;
						s.fluidProperties = prop;
						//s.cbType = cbType;
					
						s = new Polygon(
							[   Vec2.weak(1163,489.5)   ,  Vec2.weak(1167,489.5)   ,  Vec2.weak(1356,435.5)   ,  Vec2.weak(1130,445.5)   ,  Vec2.weak(1161,487.5)   ],
							mat,
							filt
						);
						s.body = body;
						s.fluidEnabled = false;
						s.fluidProperties = prop;
						//s.cbType = cbType;
					
						s = new Polygon(
							[   Vec2.weak(1570,783.5)   ,  Vec2.weak(1530,758.5)   ,  Vec2.weak(1455,753.5)   ,  Vec2.weak(1415,753.5)   ,  Vec2.weak(1382,755.5)   ,  Vec2.weak(1539.5,881)   ,  Vec2.weak(1576.5,829)   ,  Vec2.weak(1582.5,818)   ],
							mat,
							filt
						);
						s.body = body;
						s.fluidEnabled = false;
						s.fluidProperties = prop;
						//s.cbType = cbType;
					
						s = new Polygon(
							[   Vec2.weak(1,1436.5)   ,  Vec2.weak(6,1435.5)   ,  Vec2.weak(28.5,461)   ,  Vec2.weak(18.5,161)   ,  Vec2.weak(3,-0.5)   ,  Vec2.weak(2,-0.5)   ,  Vec2.weak(0.5,0)   ,  Vec2.weak(0.5,1435)   ],
							mat,
							filt
						);
						s.body = body;
						s.fluidEnabled = false;
						s.fluidProperties = prop;
						//s.cbType = cbType;
					
						s = new Polygon(
							[   Vec2.weak(1042.5,756)   ,  Vec2.weak(1023,817.5)   ,  Vec2.weak(1133,759.5)   ,  Vec2.weak(1064,755.5)   ],
							mat,
							filt
						);
						s.body = body;
						s.fluidEnabled = false;
						s.fluidProperties = prop;
						//s.cbType = cbType;
					
						s = new Polygon(
							[   Vec2.weak(106.5,97)   ,  Vec2.weak(130,25.5)   ,  Vec2.weak(3,-0.5)   ,  Vec2.weak(19,155.5)   ],
							mat,
							filt
						);
						s.body = body;
						s.fluidEnabled = false;
						s.fluidProperties = prop;
						//s.cbType = cbType;
					
						s = new Polygon(
							[   Vec2.weak(1313.5,1383)   ,  Vec2.weak(1362,1460.5)   ,  Vec2.weak(1406,1489.5)   ,  Vec2.weak(1513,1460.5)   ,  Vec2.weak(1317.5,1272)   ],
							mat,
							filt
						);
						s.body = body;
						s.fluidEnabled = false;
						s.fluidProperties = prop;
						//s.cbType = cbType;
					
						s = new Polygon(
							[   Vec2.weak(372.5,831)   ,  Vec2.weak(373.5,788)   ,  Vec2.weak(370,783.5)   ,  Vec2.weak(330.5,751)   ,  Vec2.weak(339.5,878)   ],
							mat,
							filt
						);
						s.body = body;
						s.fluidEnabled = false;
						s.fluidProperties = prop;
						//s.cbType = cbType;
					
						s = new Polygon(
							[   Vec2.weak(1317,979.5)   ,  Vec2.weak(1369,984.5)   ,  Vec2.weak(1299.5,960)   ],
							mat,
							filt
						);
						s.body = body;
						s.fluidEnabled = false;
						s.fluidProperties = prop;
						//s.cbType = cbType;
					
						s = new Polygon(
							[   Vec2.weak(778,502.5)   ,  Vec2.weak(887,539.5)   ,  Vec2.weak(893.5,533)   ,  Vec2.weak(958,443.5)   ,  Vec2.weak(743.5,450)   ],
							mat,
							filt
						);
						s.body = body;
						s.fluidEnabled = false;
						s.fluidProperties = prop;
						//s.cbType = cbType;
					
						s = new Polygon(
							[   Vec2.weak(533,281.5)   ,  Vec2.weak(590.5,312)   ,  Vec2.weak(501.5,100)   ],
							mat,
							filt
						);
						s.body = body;
						s.fluidEnabled = false;
						s.fluidProperties = prop;
						//s.cbType = cbType;
					
						s = new Polygon(
							[   Vec2.weak(1041,1736.5)   ,  Vec2.weak(1019,1741.5)   ,  Vec2.weak(939,1764.5)   ,  Vec2.weak(1088,1766.5)   ],
							mat,
							filt
						);
						s.body = body;
						s.fluidEnabled = false;
						s.fluidProperties = prop;
						//s.cbType = cbType;
					
						s = new Polygon(
							[   Vec2.weak(1007,1488.5)   ,  Vec2.weak(1029,1483.5)   ,  Vec2.weak(1109,1460.5)   ,  Vec2.weak(1139.5,1328)   ,  Vec2.weak(1136,1323.5)   ,  Vec2.weak(1072.5,1273)   ,  Vec2.weak(960,1458.5)   ],
							mat,
							filt
						);
						s.body = body;
						s.fluidEnabled = false;
						s.fluidProperties = prop;
						//s.cbType = cbType;
					
						s = new Polygon(
							[   Vec2.weak(1441,1736.5)   ,  Vec2.weak(1421,1740.5)   ,  Vec2.weak(1335,1765.5)   ,  Vec2.weak(1489,1768.5)   ],
							mat,
							filt
						);
						s.body = body;
						s.fluidEnabled = false;
						s.fluidProperties = prop;
						//s.cbType = cbType;
					
						s = new Polygon(
							[   Vec2.weak(607,1488.5)   ,  Vec2.weak(627,1484.5)   ,  Vec2.weak(713,1459.5)   ,  Vec2.weak(559,1456.5)   ],
							mat,
							filt
						);
						s.body = body;
						s.fluidEnabled = false;
						s.fluidProperties = prop;
						//s.cbType = cbType;
					
						s = new Polygon(
							[   Vec2.weak(287,566.5)   ,  Vec2.weak(283,564.5)   ,  Vec2.weak(207.5,533)   ,  Vec2.weak(339.5,878)   ,  Vec2.weak(330.5,751)   ,  Vec2.weak(290.5,571)   ],
							mat,
							filt
						);
						s.body = body;
						s.fluidEnabled = false;
						s.fluidProperties = prop;
						//s.cbType = cbType;
					
						s = new Polygon(
							[   Vec2.weak(1778,1947.5)   ,  Vec2.weak(1707.5,1891)   ,  Vec2.weak(1335,1765.5)   ,  Vec2.weak(1088,1766.5)   ,  Vec2.weak(1823.5,2030)   ],
							mat,
							filt
						);
						s.body = body;
						s.fluidEnabled = false;
						s.fluidProperties = prop;
						//s.cbType = cbType;
					
						s = new Polygon(
							[   Vec2.weak(988,817.5)   ,  Vec2.weak(916.5,868)   ,  Vec2.weak(913.5,872)   ,  Vec2.weak(910,977.5)   ,  Vec2.weak(1023,817.5)   ],
							mat,
							filt
						);
						s.body = body;
						s.fluidEnabled = false;
						s.fluidProperties = prop;
						//s.cbType = cbType;
					
						s = new Polygon(
							[   Vec2.weak(615,1727.5)   ,  Vec2.weak(535,1764.5)   ,  Vec2.weak(685,1764.5)   ,  Vec2.weak(642,1735.5)   ],
							mat,
							filt
						);
						s.body = body;
						s.fluidEnabled = false;
						s.fluidProperties = prop;
						//s.cbType = cbType;
					
						s = new Polygon(
							[   Vec2.weak(1433,1497.5)   ,  Vec2.weak(1513,1460.5)   ,  Vec2.weak(1406,1489.5)   ],
							mat,
							filt
						);
						s.body = body;
						s.fluidEnabled = false;
						s.fluidProperties = prop;
						//s.cbType = cbType;
					
						s = new Polygon(
							[   Vec2.weak(1313,714.5)   ,  Vec2.weak(1219,696.5)   ,  Vec2.weak(1168,695.5)   ,  Vec2.weak(1133,759.5)   ,  Vec2.weak(1392,980.5)   ,  Vec2.weak(1609.5,1033)   ,  Vec2.weak(1539.5,881)   ,  Vec2.weak(1382,755.5)   ],
							mat,
							filt
						);
						s.body = body;
						s.fluidEnabled = false;
						s.fluidProperties = prop;
						//s.cbType = cbType;
					
						s = new Polygon(
							[   Vec2.weak(1945.5,1095)   ,  Vec2.weak(1946,1096.5)   ,  Vec2.weak(2042.5,1130)   ,  Vec2.weak(2006.5,1039)   ,  Vec2.weak(1952.5,1088)   ],
							mat,
							filt
						);
						s.body = body;
						s.fluidEnabled = false;
						s.fluidProperties = prop;
						//s.cbType = cbType;
					
						s = new Polygon(
							[   Vec2.weak(1274,1256.5)   ,  Vec2.weak(1317.5,1272)   ,  Vec2.weak(1308.5,1194)   ,  Vec2.weak(1272.5,1249)   ],
							mat,
							filt
						);
						s.body = body;
						s.fluidEnabled = false;
						s.fluidProperties = prop;
						//s.cbType = cbType;
					
						s = new Polygon(
							[   Vec2.weak(1946,1573.5)   ,  Vec2.weak(2040,1605.5)   ,  Vec2.weak(2006.5,1516)   ,  Vec2.weak(1945.5,1572)   ],
							mat,
							filt
						);
						s.body = body;
						s.fluidEnabled = false;
						s.fluidProperties = prop;
						//s.cbType = cbType;
					
						s = new Polygon(
							[   Vec2.weak(1941.5,931)   ,  Vec2.weak(2006.5,1039)   ,  Vec2.weak(1936.5,880)   ],
							mat,
							filt
						);
						s.body = body;
						s.fluidEnabled = false;
						s.fluidProperties = prop;
						//s.cbType = cbType;
					
						s = new Polygon(
							[   Vec2.weak(101,1732.5)   ,  Vec2.weak(2,1695.5)   ,  Vec2.weak(0.5,1696)   ,  Vec2.weak(1,2047.5)   ,  Vec2.weak(134,1764.5)   ],
							mat,
							filt
						);
						s.body = body;
						s.fluidEnabled = false;
						s.fluidProperties = prop;
						//s.cbType = cbType;
					
						s = new Polygon(
							[   Vec2.weak(1936.5,880)   ,  Vec2.weak(2006.5,1039)   ,  Vec2.weak(1924,763.5)   ],
							mat,
							filt
						);
						s.body = body;
						s.fluidEnabled = false;
						s.fluidProperties = prop;
						//s.cbType = cbType;
					
						s = new Polygon(
							[   Vec2.weak(750,1493.5)   ,  Vec2.weak(869,1535.5)   ,  Vec2.weak(872,1534.5)   ,  Vec2.weak(960,1458.5)   ,  Vec2.weak(1025.5,1193)   ,  Vec2.weak(713,1459.5)   ],
							mat,
							filt
						);
						s.body = body;
						s.fluidEnabled = false;
						s.fluidProperties = prop;
						//s.cbType = cbType;
					
						s = new Polygon(
							[   Vec2.weak(2006.5,1516)   ,  Vec2.weak(2040,1605.5)   ,  Vec2.weak(2042.5,1607)   ,  Vec2.weak(2024,1311.5)   ],
							mat,
							filt
						);
						s.body = body;
						s.fluidEnabled = false;
						s.fluidProperties = prop;
						//s.cbType = cbType;
					
						s = new Polygon(
							[   Vec2.weak(164.5,448)   ,  Vec2.weak(126,407.5)   ,  Vec2.weak(120,409.5)   ,  Vec2.weak(34,459.5)   ,  Vec2.weak(339.5,935)   ,  Vec2.weak(339.5,878)   ,  Vec2.weak(207.5,533)   ],
							mat,
							filt
						);
						s.body = body;
						s.fluidEnabled = false;
						s.fluidProperties = prop;
						//s.cbType = cbType;
					
						s = new Polygon(
							[   Vec2.weak(535,1764.5)   ,  Vec2.weak(440,1790.5)   ,  Vec2.weak(690,1766.5)   ,  Vec2.weak(685,1764.5)   ],
							mat,
							filt
						);
						s.body = body;
						s.fluidEnabled = false;
						s.fluidProperties = prop;
						//s.cbType = cbType;
					
						s = new Polygon(
							[   Vec2.weak(207,1488.5)   ,  Vec2.weak(216,1487.5)   ,  Vec2.weak(313,1460.5)   ,  Vec2.weak(164,1460.5)   ],
							mat,
							filt
						);
						s.body = body;
						s.fluidEnabled = false;
						s.fluidProperties = prop;
						//s.cbType = cbType;
					
						s = new Polygon(
							[   Vec2.weak(585,358.5)   ,  Vec2.weak(648.5,362)   ,  Vec2.weak(590.5,312)   ,  Vec2.weak(583.5,352)   ],
							mat,
							filt
						);
						s.body = body;
						s.fluidEnabled = false;
						s.fluidProperties = prop;
						//s.cbType = cbType;
					
						s = new Polygon(
							[   Vec2.weak(590.5,312)   ,  Vec2.weak(648.5,362)   ,  Vec2.weak(958,443.5)   ,  Vec2.weak(1039,441.5)   ,  Vec2.weak(501.5,100)   ],
							mat,
							filt
						);
						s.body = body;
						s.fluidEnabled = false;
						s.fluidProperties = prop;
						//s.cbType = cbType;
					
						s = new Polygon(
							[   Vec2.weak(1299.5,960)   ,  Vec2.weak(1369,984.5)   ,  Vec2.weak(1377,984.5)   ,  Vec2.weak(1392,980.5)   ,  Vec2.weak(1133,759.5)   ,  Vec2.weak(1219,910.5)   ],
							mat,
							filt
						);
						s.body = body;
						s.fluidEnabled = false;
						s.fluidProperties = prop;
						//s.cbType = cbType;
					
						s = new Polygon(
							[   Vec2.weak(1044.5,1018)   ,  Vec2.weak(1075,873.5)   ,  Vec2.weak(910,977.5)   ,  Vec2.weak(1009.5,1086)   ],
							mat,
							filt
						);
						s.body = body;
						s.fluidEnabled = false;
						s.fluidProperties = prop;
						//s.cbType = cbType;
					
						s = new Polygon(
							[   Vec2.weak(241,1736.5)   ,  Vec2.weak(232,1737.5)   ,  Vec2.weak(134,1764.5)   ,  Vec2.weak(291,1768.5)   ],
							mat,
							filt
						);
						s.body = body;
						s.fluidEnabled = false;
						s.fluidProperties = prop;
						//s.cbType = cbType;
					
						s = new Polygon(
							[   Vec2.weak(70,1536.5)   ,  Vec2.weak(77,1532.5)   ,  Vec2.weak(160,1459.5)   ,  Vec2.weak(8.5,1437)   ],
							mat,
							filt
						);
						s.body = body;
						s.fluidEnabled = false;
						s.fluidProperties = prop;
						//s.cbType = cbType;
					
						s = new Polygon(
							[   Vec2.weak(1628,948.5)   ,  Vec2.weak(1539.5,881)   ,  Vec2.weak(1609.5,1033)   ,  Vec2.weak(1627.5,958)   ],
							mat,
							filt
						);
						s.body = body;
						s.fluidEnabled = false;
						s.fluidProperties = prop;
						//s.cbType = cbType;
					
						s = new Polygon(
							[   Vec2.weak(887.5,949)   ,  Vec2.weak(910,977.5)   ,  Vec2.weak(913.5,872)   ,  Vec2.weak(887.5,945)   ],
							mat,
							filt
						);
						s.body = body;
						s.fluidEnabled = false;
						s.fluidProperties = prop;
						//s.cbType = cbType;
					
						s = new Polygon(
							[   Vec2.weak(559,1456.5)   ,  Vec2.weak(713,1459.5)   ,  Vec2.weak(1025.5,1193)   ,  Vec2.weak(407,1434.5)   ],
							mat,
							filt
						);
						s.body = body;
						s.fluidEnabled = false;
						s.fluidProperties = prop;
						//s.cbType = cbType;
					
						s = new Polygon(
							[   Vec2.weak(291,1768.5)   ,  Vec2.weak(134,1764.5)   ,  Vec2.weak(1,2047.5)   ,  Vec2.weak(436,1790.5)   ],
							mat,
							filt
						);
						s.body = body;
						s.fluidEnabled = false;
						s.fluidProperties = prop;
						//s.cbType = cbType;
					
						s = new Polygon(
							[   Vec2.weak(1088,1766.5)   ,  Vec2.weak(935,1764.5)   ,  Vec2.weak(1,2047.5)   ,  Vec2.weak(1823.5,2030)   ],
							mat,
							filt
						);
						s.body = body;
						s.fluidEnabled = false;
						s.fluidProperties = prop;
						//s.cbType = cbType;
					
						s = new Polygon(
							[   Vec2.weak(348,1491.5)   ,  Vec2.weak(407,1434.5)   ,  Vec2.weak(313,1460.5)   ,  Vec2.weak(344,1489.5)   ],
							mat,
							filt
						);
						s.body = body;
						s.fluidEnabled = false;
						s.fluidProperties = prop;
						//s.cbType = cbType;
					
						s = new Polygon(
							[   Vec2.weak(313,1460.5)   ,  Vec2.weak(407,1434.5)   ,  Vec2.weak(1025.5,1193)   ,  Vec2.weak(1023.5,1189)   ,  Vec2.weak(630,1100.5)   ,  Vec2.weak(164,1460.5)   ],
							mat,
							filt
						);
						s.body = body;
						s.fluidEnabled = false;
						s.fluidProperties = prop;
						//s.cbType = cbType;
					
						s = new Polygon(
							[   Vec2.weak(335.5,659)   ,  Vec2.weak(290.5,571)   ,  Vec2.weak(330.5,751)   ,  Vec2.weak(335.5,671)   ],
							mat,
							filt
						);
						s.body = body;
						s.fluidEnabled = false;
						s.fluidProperties = prop;
						//s.cbType = cbType;
					
						s = new Polygon(
							[   Vec2.weak(37.5,257)   ,  Vec2.weak(25.5,205)   ,  Vec2.weak(30.5,337)   ,  Vec2.weak(37.5,272)   ],
							mat,
							filt
						);
						s.body = body;
						s.fluidEnabled = false;
						s.fluidProperties = prop;
						//s.cbType = cbType;
					
						s = new Polygon(
							[   Vec2.weak(1029,1099.5)   ,  Vec2.weak(1009.5,1086)   ,  Vec2.weak(1023.5,1178)   ,  Vec2.weak(1030.5,1102)   ],
							mat,
							filt
						);
						s.body = body;
						s.fluidEnabled = false;
						s.fluidProperties = prop;
						//s.cbType = cbType;
					
						s = new Polygon(
							[   Vec2.weak(743.5,450)   ,  Vec2.weak(958,443.5)   ,  Vec2.weak(648.5,362)   ,  Vec2.weak(623.5,435)   ,  Vec2.weak(624,438.5)   ],
							mat,
							filt
						);
						s.body = body;
						s.fluidEnabled = false;
						s.fluidProperties = prop;
						//s.cbType = cbType;
					
						s = new Polygon(
							[   Vec2.weak(512,979.5)   ,  Vec2.weak(508,980.5)   ,  Vec2.weak(439,1022.5)   ,  Vec2.weak(561.5,1059)   ],
							mat,
							filt
						);
						s.body = body;
						s.fluidEnabled = false;
						s.fluidProperties = prop;
						//s.cbType = cbType;
					
						s = new Polygon(
							[   Vec2.weak(439,1022.5)   ,  Vec2.weak(417.5,1034)   ,  Vec2.weak(610,1091.5)   ,  Vec2.weak(561.5,1059)   ],
							mat,
							filt
						);
						s.body = body;
						s.fluidEnabled = false;
						s.fluidProperties = prop;
						//s.cbType = cbType;
					
						s = new Polygon(
							[   Vec2.weak(1114.5,1461)   ,  Vec2.weak(1139.5,1328)   ,  Vec2.weak(1109,1460.5)   ],
							mat,
							filt
						);
						s.body = body;
						s.fluidEnabled = false;
						s.fluidProperties = prop;
						//s.cbType = cbType;
					
						s = new Polygon(
							[   Vec2.weak(41.5,397)   ,  Vec2.weak(30.5,351)   ,  Vec2.weak(28.5,461)   ,  Vec2.weak(41.5,406)   ],
							mat,
							filt
						);
						s.body = body;
						s.fluidEnabled = false;
						s.fluidProperties = prop;
						//s.cbType = cbType;
					
						s = new Polygon(
							[   Vec2.weak(1731,571.5)   ,  Vec2.weak(1928,758.5)   ,  Vec2.weak(2047,-0.5)   ,  Vec2.weak(1705.5,542)   ],
							mat,
							filt
						);
						s.body = body;
						s.fluidEnabled = false;
						s.fluidProperties = prop;
						//s.cbType = cbType;
					
						s = new Polygon(
							[   Vec2.weak(2015.5,1729)   ,  Vec2.weak(2023.5,1775)   ,  Vec2.weak(2042.5,1610)   ,  Vec2.weak(2015.5,1719)   ],
							mat,
							filt
						);
						s.body = body;
						s.fluidEnabled = false;
						s.fluidProperties = prop;
						//s.cbType = cbType;
					
						s = new Polygon(
							[   Vec2.weak(25.5,205)   ,  Vec2.weak(18.5,161)   ,  Vec2.weak(28.5,461)   ,  Vec2.weak(30.5,337)   ],
							mat,
							filt
						);
						s.body = body;
						s.fluidEnabled = false;
						s.fluidProperties = prop;
						//s.cbType = cbType;
					
						s = new Polygon(
							[   Vec2.weak(1447,1192.5)   ,  Vec2.weak(1311,1192.5)   ,  Vec2.weak(1489,1197.5)   ],
							mat,
							filt
						);
						s.body = body;
						s.fluidEnabled = false;
						s.fluidProperties = prop;
						//s.cbType = cbType;
					
						s = new Polygon(
							[   Vec2.weak(2023.5,1775)   ,  Vec2.weak(2026,1798.5)   ,  Vec2.weak(2042.5,1610)   ],
							mat,
							filt
						);
						s.body = body;
						s.fluidEnabled = false;
						s.fluidProperties = prop;
						//s.cbType = cbType;
					
						s = new Polygon(
							[   Vec2.weak(2015.5,1252)   ,  Vec2.weak(2024.5,1305)   ,  Vec2.weak(2042.5,1130)   ,  Vec2.weak(2015.5,1242)   ],
							mat,
							filt
						);
						s.body = body;
						s.fluidEnabled = false;
						s.fluidProperties = prop;
						//s.cbType = cbType;
					
						s = new Polygon(
							[   Vec2.weak(1023,817.5)   ,  Vec2.weak(910,977.5)   ,  Vec2.weak(1075,873.5)   ,  Vec2.weak(1133,759.5)   ],
							mat,
							filt
						);
						s.body = body;
						s.fluidEnabled = false;
						s.fluidProperties = prop;
						//s.cbType = cbType;
					
						s = new Polygon(
							[   Vec2.weak(1072.5,1273)   ,  Vec2.weak(1025.5,1193)   ,  Vec2.weak(960,1458.5)   ],
							mat,
							filt
						);
						s.body = body;
						s.fluidEnabled = false;
						s.fluidProperties = prop;
						//s.cbType = cbType;
					
						s = new Polygon(
							[   Vec2.weak(1552.5,487)   ,  Vec2.weak(1556,492.5)   ,  Vec2.weak(1705.5,542)   ,  Vec2.weak(2047,-0.5)   ,  Vec2.weak(1537.5,450)   ],
							mat,
							filt
						);
						s.body = body;
						s.fluidEnabled = false;
						s.fluidProperties = prop;
						//s.cbType = cbType;
					
						s = new Polygon(
							[   Vec2.weak(1130,445.5)   ,  Vec2.weak(1356,435.5)   ,  Vec2.weak(501.5,100)   ,  Vec2.weak(1039,441.5)   ],
							mat,
							filt
						);
						s.body = body;
						s.fluidEnabled = false;
						s.fluidProperties = prop;
						//s.cbType = cbType;
					
						s = new Polygon(
							[   Vec2.weak(2006.5,1039)   ,  Vec2.weak(2042.5,1130)   ,  Vec2.weak(1928,758.5)   ,  Vec2.weak(1924,763.5)   ],
							mat,
							filt
						);
						s.body = body;
						s.fluidEnabled = false;
						s.fluidProperties = prop;
						//s.cbType = cbType;
					
						s = new Polygon(
							[   Vec2.weak(1164.5,699)   ,  Vec2.weak(1133,759.5)   ,  Vec2.weak(1168,695.5)   ],
							mat,
							filt
						);
						s.body = body;
						s.fluidEnabled = false;
						s.fluidProperties = prop;
						//s.cbType = cbType;
					
						s = new Polygon(
							[   Vec2.weak(1356,435.5)   ,  Vec2.weak(1431,437.5)   ,  Vec2.weak(501.5,100)   ],
							mat,
							filt
						);
						s.body = body;
						s.fluidEnabled = false;
						s.fluidProperties = prop;
						//s.cbType = cbType;
					
						s = new Polygon(
							[   Vec2.weak(1431,437.5)   ,  Vec2.weak(1537.5,450)   ,  Vec2.weak(2047,-0.5)   ,  Vec2.weak(501.5,100)   ],
							mat,
							filt
						);
						s.body = body;
						s.fluidEnabled = false;
						s.fluidProperties = prop;
						//s.cbType = cbType;
					
						s = new Polygon(
							[   Vec2.weak(845,1787.5)   ,  Vec2.weak(841,1790.5)   ,  Vec2.weak(935,1764.5)   ],
							mat,
							filt
						);
						s.body = body;
						s.fluidEnabled = false;
						s.fluidProperties = prop;
						//s.cbType = cbType;
					
						s = new Polygon(
							[   Vec2.weak(330,99.5)   ,  Vec2.weak(334,99.5)   ,  Vec2.weak(407,69.5)   ,  Vec2.weak(226,14.5)   ],
							mat,
							filt
						);
						s.body = body;
						s.fluidEnabled = false;
						s.fluidProperties = prop;
						//s.cbType = cbType;
					
						s = new Polygon(
							[   Vec2.weak(1023.5,1178)   ,  Vec2.weak(1009.5,1086)   ,  Vec2.weak(807,1035.5)   ,  Vec2.weak(639,1098.5)   ,  Vec2.weak(1023.5,1189)   ],
							mat,
							filt
						);
						s.body = body;
						s.fluidEnabled = false;
						s.fluidProperties = prop;
						//s.cbType = cbType;
					
						s = new Polygon(
							[   Vec2.weak(407,69.5)   ,  Vec2.weak(414,68.5)   ,  Vec2.weak(226,14.5)   ],
							mat,
							filt
						);
						s.body = body;
						s.fluidEnabled = false;
						s.fluidProperties = prop;
						//s.cbType = cbType;
					
						s = new Polygon(
							[   Vec2.weak(610,1091.5)   ,  Vec2.weak(417.5,1034)   ,  Vec2.weak(164,1460.5)   ,  Vec2.weak(630,1100.5)   ],
							mat,
							filt
						);
						s.body = body;
						s.fluidEnabled = false;
						s.fluidProperties = prop;
						//s.cbType = cbType;
					
						s = new Polygon(
							[   Vec2.weak(690,1766.5)   ,  Vec2.weak(440,1790.5)   ,  Vec2.weak(1,2047.5)   ,  Vec2.weak(835,1790.5)   ],
							mat,
							filt
						);
						s.body = body;
						s.fluidEnabled = false;
						s.fluidProperties = prop;
						//s.cbType = cbType;
					
						s = new Polygon(
							[   Vec2.weak(34,459.5)   ,  Vec2.weak(28.5,461)   ,  Vec2.weak(160,1459.5)   ,  Vec2.weak(164,1460.5)   ,  Vec2.weak(339.5,935)   ],
							mat,
							filt
						);
						s.body = body;
						s.fluidEnabled = false;
						s.fluidProperties = prop;
						//s.cbType = cbType;
					
						s = new Polygon(
							[   Vec2.weak(1513.5,1064)   ,  Vec2.weak(1609.5,1033)   ,  Vec2.weak(1392,980.5)   ],
							mat,
							filt
						);
						s.body = body;
						s.fluidEnabled = false;
						s.fluidProperties = prop;
						//s.cbType = cbType;
					
						s = new Polygon(
							[   Vec2.weak(1219,910.5)   ,  Vec2.weak(1133,759.5)   ,  Vec2.weak(1137,881.5)   ],
							mat,
							filt
						);
						s.body = body;
						s.fluidEnabled = false;
						s.fluidProperties = prop;
						//s.cbType = cbType;
					
						s = new Polygon(
							[   Vec2.weak(1137,881.5)   ,  Vec2.weak(1133,759.5)   ,  Vec2.weak(1075,873.5)   ],
							mat,
							filt
						);
						s.body = body;
						s.fluidEnabled = false;
						s.fluidProperties = prop;
						//s.cbType = cbType;
					
						s = new Polygon(
							[   Vec2.weak(910,977.5)   ,  Vec2.weak(807,1035.5)   ,  Vec2.weak(1009.5,1086)   ],
							mat,
							filt
						);
						s.body = body;
						s.fluidEnabled = false;
						s.fluidProperties = prop;
						//s.cbType = cbType;
					
						s = new Polygon(
							[   Vec2.weak(639,1098.5)   ,  Vec2.weak(630,1100.5)   ,  Vec2.weak(1023.5,1189)   ],
							mat,
							filt
						);
						s.body = body;
						s.fluidEnabled = false;
						s.fluidProperties = prop;
						//s.cbType = cbType;
					
						s = new Polygon(
							[   Vec2.weak(417.5,1034)   ,  Vec2.weak(339.5,935)   ,  Vec2.weak(164,1460.5)   ],
							mat,
							filt
						);
						s.body = body;
						s.fluidEnabled = false;
						s.fluidProperties = prop;
						//s.cbType = cbType;
					
						s = new Polygon(
							[   Vec2.weak(8.5,1437)   ,  Vec2.weak(160,1459.5)   ,  Vec2.weak(28.5,461)   ,  Vec2.weak(6,1435.5)   ],
							mat,
							filt
						);
						s.body = body;
						s.fluidEnabled = false;
						s.fluidProperties = prop;
						//s.cbType = cbType;
					
						s = new Polygon(
							[   Vec2.weak(436,1790.5)   ,  Vec2.weak(1,2047.5)   ,  Vec2.weak(440,1790.5)   ],
							mat,
							filt
						);
						s.body = body;
						s.fluidEnabled = false;
						s.fluidProperties = prop;
						//s.cbType = cbType;
					
						s = new Polygon(
							[   Vec2.weak(18.5,161)   ,  Vec2.weak(19,155.5)   ,  Vec2.weak(3,-0.5)   ],
							mat,
							filt
						);
						s.body = body;
						s.fluidEnabled = false;
						s.fluidProperties = prop;
						//s.cbType = cbType;
					
						s = new Polygon(
							[   Vec2.weak(130,25.5)   ,  Vec2.weak(226,14.5)   ,  Vec2.weak(3,-0.5)   ],
							mat,
							filt
						);
						s.body = body;
						s.fluidEnabled = false;
						s.fluidProperties = prop;
						//s.cbType = cbType;
					
						s = new Polygon(
							[   Vec2.weak(3,-0.5)   ,  Vec2.weak(226,14.5)   ,  Vec2.weak(2047,-0.5)   ],
							mat,
							filt
						);
						s.body = body;
						s.fluidEnabled = false;
						s.fluidProperties = prop;
						//s.cbType = cbType;
					
						s = new Polygon(
							[   Vec2.weak(226,14.5)   ,  Vec2.weak(414,68.5)   ,  Vec2.weak(2047,-0.5)   ],
							mat,
							filt
						);
						s.body = body;
						s.fluidEnabled = false;
						s.fluidProperties = prop;
						//s.cbType = cbType;
					
						s = new Polygon(
							[   Vec2.weak(414,68.5)   ,  Vec2.weak(501.5,100)   ,  Vec2.weak(2047,-0.5)   ],
							mat,
							filt
						);
						s.body = body;
						s.fluidEnabled = false;
						s.fluidProperties = prop;
						//s.cbType = cbType;
					
						s = new Polygon(
							[   Vec2.weak(1928,758.5)   ,  Vec2.weak(2042.5,1130)   ,  Vec2.weak(2047,-0.5)   ],
							mat,
							filt
						);
						s.body = body;
						s.fluidEnabled = false;
						s.fluidProperties = prop;
						//s.cbType = cbType;
					
						s = new Polygon(
							[   Vec2.weak(2047,-0.5)   ,  Vec2.weak(2042.5,1610)   ,  Vec2.weak(2047.5,2047)   ],
							mat,
							filt
						);
						s.body = body;
						s.fluidEnabled = false;
						s.fluidProperties = prop;
						//s.cbType = cbType;
					
						s = new Polygon(
							[   Vec2.weak(2024,1311.5)   ,  Vec2.weak(2042.5,1607)   ,  Vec2.weak(2042.5,1130)   ],
							mat,
							filt
						);
						s.body = body;
						s.fluidEnabled = false;
						s.fluidProperties = prop;
						//s.cbType = cbType;
					
						s = new Polygon(
							[   Vec2.weak(835,1790.5)   ,  Vec2.weak(1,2047.5)   ,  Vec2.weak(841,1790.5)   ],
							mat,
							filt
						);
						s.body = body;
						s.fluidEnabled = false;
						s.fluidProperties = prop;
						//s.cbType = cbType;
					
						s = new Polygon(
							[   Vec2.weak(1,2047.5)   ,  Vec2.weak(2047.5,2047)   ,  Vec2.weak(1823.5,2030)   ],
							mat,
							filt
						);
						s.body = body;
						s.fluidEnabled = false;
						s.fluidProperties = prop;
						//s.cbType = cbType;
					
						s = new Polygon(
							[   Vec2.weak(1823.5,2030)   ,  Vec2.weak(2047.5,2047)   ,  Vec2.weak(1930,1953.5)   ],
							mat,
							filt
						);
						s.body = body;
						s.fluidEnabled = false;
						s.fluidProperties = prop;
						//s.cbType = cbType;
					
						s = new Polygon(
							[   Vec2.weak(1930,1953.5)   ,  Vec2.weak(2047.5,2047)   ,  Vec2.weak(1931.5,1951)   ],
							mat,
							filt
						);
						s.body = body;
						s.fluidEnabled = false;
						s.fluidProperties = prop;
						//s.cbType = cbType;
					
						s = new Polygon(
							[   Vec2.weak(2026,1798.5)   ,  Vec2.weak(2047.5,2047)   ,  Vec2.weak(2042.5,1610)   ],
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

			bodies["level3Decor"] = new BodyPair(body,anchor);
		
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
