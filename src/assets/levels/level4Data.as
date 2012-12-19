package assets.levels{

import flash.display.DisplayObject;
import flash.geom.Rectangle;
import flash.utils.Dictionary;

import nape.callbacks.CbType;
import nape.callbacks.CbTypeList;
import nape.dynamics.InteractionFilter;
import nape.geom.AABB;
import nape.geom.Vec2;
import nape.geom.Vec3;
import nape.phys.Body;
import nape.phys.BodyType;
import nape.phys.FluidProperties;
import nape.phys.Material;
import nape.shape.Circle;
import nape.shape.Polygon;
import nape.shape.Shape;

public class level4Data {

    /**
     * Get position and rotation for graphics placement.
     *
     * Example usage:
     * <code>
     *    space.step(1/60);
     *    space.liveBodies.foreach(updateGraphics);
     *    ...
     *    function updateGraphics(body:Body):void {
     *       var position:Vec3 = PhysicsData.graphicsPosition(body);
     *       var graphic:DisplayObject = body.userData.graphic;
     *       graphic.x = position.x;
     *       graphic.y = position.y;
     *       graphic.rotation = position.z;
     *       position.dispose(); //release to object pool.
     *    }
     * </code>
     * In the case that you are using a flash DisplayObject you can simply
     * use <code>space.liveBodies.foreach(PhysicsData.flashGraphicsUpdate);</code>
     * but if using, let's say Starling you should write the equivalent version
     * of the example above.
     *
     * @param body The Body to get graphical position/rotation of.
     * @return A Vec3 allocated from object pool whose x/y are the position
     *         for graphic, and z the rotation in degrees.
     */
    public static function graphicsPosition(body:Body):Vec3 {
        var pos:Vec2 = body.localPointToWorld(body.userData.graphicOffset as Vec2);
        var ret:Vec3 = Vec3.get(pos.x, pos.y, (body.rotation * 180/Math.PI) % 360);
        pos.dispose();
        return ret;
    }

    /**
     * Method to update a flash DisplayObject assigned to a Body
     *
     * @param body The Body having a flash DisplayObject to update graphic of.
     */
    public static function flashGraphicsUpdate(body:Body):void {
        var position:Vec3 = level4Data.graphicsPosition(body);
        var graphic:DisplayObject = body.userData.graphic;
        graphic.x = position.x;
        graphic.y = position.y;
        graphic.rotation = position.z;
        position.dispose(); //release to object pool.
    }

    /**
     * Method to create a Body from the PhysicsEditor exported data.
     *
     * If supplying a graphic (of any type), then this will be stored
     * in body.userData.graphic and an associated body.userData.graphicOffset
     * Vec2 will be assigned that represents the local offset to apply to
     * the graphics position.
     *
     * @param name The name of the Body from the PhysicsEditor exported data.
     * @param graphic (optional) A graphic to assign and find a local offset for.
                      This can be of any type, but should have a getBounds function
                      that works like that of the flash DisplayObject to correctly
                      determine a graphicOffset.
     * @return The constructed Body.
     */
    public static function createBody(name:String,graphic:*=null):Body {
        var xret:BodyPair = lookup(name);
        if(graphic==null) return xret.body.copy();

        var ret:Body = xret.body.copy();
        graphic.x = graphic.y = 0;
        graphic.rotation = 0;
        var bounds:Rectangle = graphic.getBounds(graphic);
        var offset:Vec2 = Vec2.get(bounds.x-xret.anchor.x, bounds.y-xret.anchor.y);

        ret.userData.graphic = graphic;
        ret.userData.graphicOffset = offset;

        return ret;
    }

    /**
     * Register a Material object with the name used in the PhysicsEditor data.
     *
     * @param name The name of the Material in the PhysicsEditor data.
     * @param material The Material object to be assigned to this name.
     */
    public static function registerMaterial(name:String,material:Material):void {
        if(materials==null) materials = new Dictionary();
        materials[name] = material;
    }

    /**
     * Register a InteractionFilter object with the name used in the PhysicsEditor data.
     *
     * @param name The name of the InteractionFilter in the PhysicsEditor data.
     * @param filter The InteractionFilter object to be assigned to this name.
     */
    public static function registerFilter(name:String,filter:InteractionFilter):void {
        if(filters==null) filters = new Dictionary();
        filters[name] = filter;
    }

    /**
     * Register a FluidProperties object with the name used in the PhysicsEditor data.
     *
     * @param name The name of the FluidProperties in the PhysicsEditor data.
     * @param properties The FluidProperties object to be assigned to this name.
     */
    public static function registerFluidProperties(name:String,properties:FluidProperties):void {
        if(fprops==null) fprops = new Dictionary();
        fprops[name] = properties;
    }

    /**
     * Register a CbType object with the name used in the PhysicsEditor data.
     *
     * @param name The name of the CbType in the PhysicsEditor data.
     * @param cbType The CbType object to be assigned to this name.
     */
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
    private static function cbtype(outtypes:CbTypeList, name:String):void {
        var names:Array = name.split(",");
        for(var i:int = 0; i<names.length; i++) {
            var name:String = names[i].replace( /^([\s|\t|\n]+)?(.*)([\s|\t|\n]+)?$/gm, "$2" );
            if(name=="") continue;

            if(types[name] === undefined)
                throw "Error: CbType with name '"+name+"' has not been registered";

            outtypes.add(types[name] as CbType);
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
            cbtype(body.cbTypes,"");

            
                mat = material("default");
                filt = filter("default");
                prop = fprop("default");

                
                    
                        s = new Polygon(
                            [   Vec2.weak(510.5,70)   ,  Vec2.weak(588.5,160)   ,  Vec2.weak(610,7.5)   ],
                            mat,
                            filt
                        );
                        s.body = body;
                        s.sensorEnabled = false;
                        s.fluidEnabled = false;
                        s.fluidProperties = prop;
                        cbtype(s.cbTypes,"");
                    
                        s = new Polygon(
                            [   Vec2.weak(1068.5,511)   ,  Vec2.weak(1014.5,420)   ,  Vec2.weak(990,559.5)   ],
                            mat,
                            filt
                        );
                        s.body = body;
                        s.sensorEnabled = false;
                        s.fluidEnabled = false;
                        s.fluidProperties = prop;
                        cbtype(s.cbTypes,"");
                    
                        s = new Polygon(
                            [   Vec2.weak(1382,340.5)   ,  Vec2.weak(1386,336.5)   ,  Vec2.weak(1376,334.5)   ],
                            mat,
                            filt
                        );
                        s.body = body;
                        s.sensorEnabled = false;
                        s.fluidEnabled = false;
                        s.fluidProperties = prop;
                        cbtype(s.cbTypes,"");
                    
                        s = new Polygon(
                            [   Vec2.weak(202,1935.5)   ,  Vec2.weak(97,1930.5)   ,  Vec2.weak(249.5,2025)   ],
                            mat,
                            filt
                        );
                        s.body = body;
                        s.sensorEnabled = false;
                        s.fluidEnabled = false;
                        s.fluidProperties = prop;
                        cbtype(s.cbTypes,"");
                    
                        s = new Polygon(
                            [   Vec2.weak(315.5,499)   ,  Vec2.weak(257.5,440)   ,  Vec2.weak(283.5,534)   ],
                            mat,
                            filt
                        );
                        s.body = body;
                        s.sensorEnabled = false;
                        s.fluidEnabled = false;
                        s.fluidProperties = prop;
                        cbtype(s.cbTypes,"");
                    
                        s = new Polygon(
                            [   Vec2.weak(554.5,1547)   ,  Vec2.weak(613,1606.5)   ,  Vec2.weak(586.5,1512)   ],
                            mat,
                            filt
                        );
                        s.body = body;
                        s.sensorEnabled = false;
                        s.fluidEnabled = false;
                        s.fluidProperties = prop;
                        cbtype(s.cbTypes,"");
                    
                        s = new Polygon(
                            [   Vec2.weak(358.5,1177)   ,  Vec2.weak(281.5,1088)   ,  Vec2.weak(282.5,1334)   ,  Vec2.weak(316.5,1297)   ],
                            mat,
                            filt
                        );
                        s.body = body;
                        s.sensorEnabled = false;
                        s.fluidEnabled = false;
                        s.fluidProperties = prop;
                        cbtype(s.cbTypes,"");
                    
                        s = new Polygon(
                            [   Vec2.weak(511.5,869)   ,  Vec2.weak(588.5,958)   ,  Vec2.weak(587.5,712)   ,  Vec2.weak(553.5,749)   ],
                            mat,
                            filt
                        );
                        s.body = body;
                        s.sensorEnabled = false;
                        s.fluidEnabled = false;
                        s.fluidProperties = prop;
                        cbtype(s.cbTypes,"");
                    
                        s = new Polygon(
                            [   Vec2.weak(555.5,347)   ,  Vec2.weak(612.5,406)   ,  Vec2.weak(586.5,312)   ],
                            mat,
                            filt
                        );
                        s.body = body;
                        s.sensorEnabled = false;
                        s.fluidEnabled = false;
                        s.fluidProperties = prop;
                        cbtype(s.cbTypes,"");
                    
                        s = new Polygon(
                            [   Vec2.weak(669,1710.5)   ,  Vec2.weak(759,1715.5)   ,  Vec2.weak(797,1715.5)   ,  Vec2.weak(913,1667.5)   ,  Vec2.weak(1014,1608.5)   ,  Vec2.weak(619.5,1608)   ],
                            mat,
                            filt
                        );
                        s.body = body;
                        s.sensorEnabled = false;
                        s.fluidEnabled = false;
                        s.fluidProperties = prop;
                        cbtype(s.cbTypes,"");
                    
                        s = new Polygon(
                            [   Vec2.weak(1175.5,1871)   ,  Vec2.weak(1167,1935.5)   ,  Vec2.weak(1288.5,1927)   ,  Vec2.weak(1225,1846.5)   ,  Vec2.weak(1223,1846.5)   ],
                            mat,
                            filt
                        );
                        s.body = body;
                        s.sensorEnabled = false;
                        s.fluidEnabled = false;
                        s.fluidProperties = prop;
                        cbtype(s.cbTypes,"");
                    
                        s = new Polygon(
                            [   Vec2.weak(1640.5,125)   ,  Vec2.weak(1586,27.5)   ,  Vec2.weak(1515,206.5)   ,  Vec2.weak(1600,163.5)   ],
                            mat,
                            filt
                        );
                        s.body = body;
                        s.sensorEnabled = false;
                        s.fluidEnabled = false;
                        s.fluidProperties = prop;
                        cbtype(s.cbTypes,"");
                    
                        s = new Polygon(
                            [   Vec2.weak(1947.5,330)   ,  Vec2.weak(1978.5,408)   ,  Vec2.weak(2033.5,224)   ],
                            mat,
                            filt
                        );
                        s.body = body;
                        s.sensorEnabled = false;
                        s.fluidEnabled = false;
                        s.fluidProperties = prop;
                        cbtype(s.cbTypes,"");
                    
                        s = new Polygon(
                            [   Vec2.weak(1260,372.5)   ,  Vec2.weak(1296,329.5)   ,  Vec2.weak(1169,338.5)   ,  Vec2.weak(1216,371.5)   ],
                            mat,
                            filt
                        );
                        s.body = body;
                        s.sensorEnabled = false;
                        s.fluidEnabled = false;
                        s.fluidProperties = prop;
                        cbtype(s.cbTypes,"");
                    
                        s = new Polygon(
                            [   Vec2.weak(691,1935.5)   ,  Vec2.weak(639,1940.5)   ,  Vec2.weak(532,2005.5)   ,  Vec2.weak(736.5,2024)   ],
                            mat,
                            filt
                        );
                        s.body = body;
                        s.sensorEnabled = false;
                        s.fluidEnabled = false;
                        s.fluidProperties = prop;
                        cbtype(s.cbTypes,"");
                    
                        s = new Polygon(
                            [   Vec2.weak(910.5,1695)   ,  Vec2.weak(913,1667.5)   ,  Vec2.weak(797,1715.5)   ,  Vec2.weak(859,1712.5)   ],
                            mat,
                            filt
                        );
                        s.body = body;
                        s.sensorEnabled = false;
                        s.fluidEnabled = false;
                        s.fluidProperties = prop;
                        cbtype(s.cbTypes,"");
                    
                        s = new Polygon(
                            [   Vec2.weak(257.5,1640)   ,  Vec2.weak(279.5,1488)   ,  Vec2.weak(158,1705.5)   ],
                            mat,
                            filt
                        );
                        s.body = body;
                        s.sensorEnabled = false;
                        s.fluidEnabled = false;
                        s.fluidProperties = prop;
                        cbtype(s.cbTypes,"");
                    
                        s = new Polygon(
                            [   Vec2.weak(720,1138.5)   ,  Vec2.weak(775,1071.5)   ,  Vec2.weak(587,1113.5)   ],
                            mat,
                            filt
                        );
                        s.body = body;
                        s.sensorEnabled = false;
                        s.fluidEnabled = false;
                        s.fluidProperties = prop;
                        cbtype(s.cbTypes,"");
                    
                        s = new Polygon(
                            [   Vec2.weak(953,1944.5)   ,  Vec2.weak(950.5,1945)   ,  Vec2.weak(917,2041.5)   ,  Vec2.weak(1003.5,2001)   ,  Vec2.weak(956,1947.5)   ],
                            mat,
                            filt
                        );
                        s.body = body;
                        s.sensorEnabled = false;
                        s.fluidEnabled = false;
                        s.fluidProperties = prop;
                        cbtype(s.cbTypes,"");
                    
                        s = new Polygon(
                            [   Vec2.weak(610.5,1)   ,  Vec2.weak(611.5,5)   ,  Vec2.weak(1696,29.5)   ,  Vec2.weak(1887,17.5)   ,  Vec2.weak(2047,0.5)   ,  Vec2.weak(612,0.5)   ],
                            mat,
                            filt
                        );
                        s.body = body;
                        s.sensorEnabled = false;
                        s.fluidEnabled = false;
                        s.fluidProperties = prop;
                        cbtype(s.cbTypes,"");
                    
                        s = new Polygon(
                            [   Vec2.weak(1480.5,287)   ,  Vec2.weak(1586,27.5)   ,  Vec2.weak(1296,329.5)   ,  Vec2.weak(1376,334.5)   ,  Vec2.weak(1398,329.5)   ],
                            mat,
                            filt
                        );
                        s.body = body;
                        s.sensorEnabled = false;
                        s.fluidEnabled = false;
                        s.fluidProperties = prop;
                        cbtype(s.cbTypes,"");
                    
                        s = new Polygon(
                            [   Vec2.weak(855.5,1310)   ,  Vec2.weak(799,1271.5)   ,  Vec2.weak(790.5,1273)   ,  Vec2.weak(775,1317.5)   ,  Vec2.weak(855.5,1446)   ],
                            mat,
                            filt
                        );
                        s.body = body;
                        s.sensorEnabled = false;
                        s.fluidEnabled = false;
                        s.fluidProperties = prop;
                        cbtype(s.cbTypes,"");
                    
                        s = new Polygon(
                            [   Vec2.weak(1541.5,756)   ,  Vec2.weak(1545.5,774)   ,  Vec2.weak(1597,742.5)   ],
                            mat,
                            filt
                        );
                        s.body = body;
                        s.sensorEnabled = false;
                        s.fluidEnabled = false;
                        s.fluidProperties = prop;
                        cbtype(s.cbTypes,"");
                    
                        s = new Polygon(
                            [   Vec2.weak(1264.5,1569)   ,  Vec2.weak(1286.5,1535)   ,  Vec2.weak(1289.5,1528)   ,  Vec2.weak(1294.5,1453)   ,  Vec2.weak(1294.5,1414)   ,  Vec2.weak(1292.5,1381)   ,  Vec2.weak(1166,1538.5)   ,  Vec2.weak(1230,1581.5)   ],
                            mat,
                            filt
                        );
                        s.body = body;
                        s.sensorEnabled = false;
                        s.fluidEnabled = false;
                        s.fluidProperties = prop;
                        cbtype(s.cbTypes,"");
                    
                        s = new Polygon(
                            [   Vec2.weak(1386,336.5)   ,  Vec2.weak(1398,329.5)   ,  Vec2.weak(1376,334.5)   ],
                            mat,
                            filt
                        );
                        s.body = body;
                        s.sensorEnabled = false;
                        s.fluidEnabled = false;
                        s.fluidProperties = prop;
                        cbtype(s.cbTypes,"");
                    
                        s = new Polygon(
                            [   Vec2.weak(1179,914.5)   ,  Vec2.weak(1103,886.5)   ,  Vec2.weak(1230.5,1022)   ,  Vec2.weak(1230.5,988)   ],
                            mat,
                            filt
                        );
                        s.body = body;
                        s.sensorEnabled = false;
                        s.fluidEnabled = false;
                        s.fluidProperties = prop;
                        cbtype(s.cbTypes,"");
                    
                        s = new Polygon(
                            [   Vec2.weak(1950,105.5)   ,  Vec2.weak(2021.5,129)   ,  Vec2.weak(2047,0.5)   ,  Vec2.weak(1892.5,18)   ],
                            mat,
                            filt
                        );
                        s.body = body;
                        s.sensorEnabled = false;
                        s.fluidEnabled = false;
                        s.fluidProperties = prop;
                        cbtype(s.cbTypes,"");
                    
                        s = new Polygon(
                            [   Vec2.weak(558.5,1007)   ,  Vec2.weak(587.5,1111)   ,  Vec2.weak(1069.5,909)   ,  Vec2.weak(1011.5,804)   ,  Vec2.weak(588.5,961)   ],
                            mat,
                            filt
                        );
                        s.body = body;
                        s.sensorEnabled = false;
                        s.fluidEnabled = false;
                        s.fluidProperties = prop;
                        cbtype(s.cbTypes,"");
                    
                        s = new Polygon(
                            [   Vec2.weak(1099,886.5)   ,  Vec2.weak(1096,888.5)   ,  Vec2.weak(1072,908.5)   ,  Vec2.weak(1174.5,1074)   ,  Vec2.weak(1288.5,1132)   ,  Vec2.weak(1230.5,1022)   ,  Vec2.weak(1103,886.5)   ],
                            mat,
                            filt
                        );
                        s.body = body;
                        s.sensorEnabled = false;
                        s.fluidEnabled = false;
                        s.fluidProperties = prop;
                        cbtype(s.cbTypes,"");
                    
                        s = new Polygon(
                            [   Vec2.weak(311.5,1039)   ,  Vec2.weak(282.5,934)   ,  Vec2.weak(281.5,1085)   ],
                            mat,
                            filt
                        );
                        s.body = body;
                        s.sensorEnabled = false;
                        s.fluidEnabled = false;
                        s.fluidProperties = prop;
                        cbtype(s.cbTypes,"");
                    
                        s = new Polygon(
                            [   Vec2.weak(1292,1041.5)   ,  Vec2.weak(1230.5,1022)   ,  Vec2.weak(1288.5,1132)   ,  Vec2.weak(1292.5,1062)   ],
                            mat,
                            filt
                        );
                        s.body = body;
                        s.sensorEnabled = false;
                        s.fluidEnabled = false;
                        s.fluidProperties = prop;
                        cbtype(s.cbTypes,"");
                    
                        s = new Polygon(
                            [   Vec2.weak(1545.5,774)   ,  Vec2.weak(1507.5,886)   ,  Vec2.weak(1597,742.5)   ],
                            mat,
                            filt
                        );
                        s.body = body;
                        s.sensorEnabled = false;
                        s.fluidEnabled = false;
                        s.fluidProperties = prop;
                        cbtype(s.cbTypes,"");
                    
                        s = new Polygon(
                            [   Vec2.weak(1067.5,1317)   ,  Vec2.weak(1062.5,1376)   ,  Vec2.weak(1088,1297.5)   ],
                            mat,
                            filt
                        );
                        s.body = body;
                        s.sensorEnabled = false;
                        s.fluidEnabled = false;
                        s.fluidProperties = prop;
                        cbtype(s.cbTypes,"");
                    
                        s = new Polygon(
                            [   Vec2.weak(1765.5,532)   ,  Vec2.weak(1735,589.5)   ,  Vec2.weak(1947,500.5)   ],
                            mat,
                            filt
                        );
                        s.body = body;
                        s.sensorEnabled = false;
                        s.fluidEnabled = false;
                        s.fluidProperties = prop;
                        cbtype(s.cbTypes,"");
                    
                        s = new Polygon(
                            [   Vec2.weak(946,1029.5)   ,  Vec2.weak(961,1008.5)   ,  Vec2.weak(858,1022.5)   ],
                            mat,
                            filt
                        );
                        s.body = body;
                        s.sensorEnabled = false;
                        s.fluidEnabled = false;
                        s.fluidProperties = prop;
                        cbtype(s.cbTypes,"");
                    
                        s = new Polygon(
                            [   Vec2.weak(98.5,1778)   ,  Vec2.weak(158,1705.5)   ,  Vec2.weak(279.5,1488)   ,  Vec2.weak(281.5,1088)   ,  Vec2.weak(21,1819.5)   ],
                            mat,
                            filt
                        );
                        s.body = body;
                        s.sensorEnabled = false;
                        s.fluidEnabled = false;
                        s.fluidProperties = prop;
                        cbtype(s.cbTypes,"");
                    
                        s = new Polygon(
                            [   Vec2.weak(1554.5,1555)   ,  Vec2.weak(1505,1704.5)   ,  Vec2.weak(2047.5,2047)   ,  Vec2.weak(1597,1536.5)   ],
                            mat,
                            filt
                        );
                        s.body = body;
                        s.sensorEnabled = false;
                        s.fluidEnabled = false;
                        s.fluidProperties = prop;
                        cbtype(s.cbTypes,"");
                    
                        s = new Polygon(
                            [   Vec2.weak(320.5,615)   ,  Vec2.weak(283.5,534)   ,  Vec2.weak(281.5,688)   ,  Vec2.weak(311.5,642)   ],
                            mat,
                            filt
                        );
                        s.body = body;
                        s.sensorEnabled = false;
                        s.fluidEnabled = false;
                        s.fluidProperties = prop;
                        cbtype(s.cbTypes,"");
                    
                        s = new Polygon(
                            [   Vec2.weak(549.5,1431)   ,  Vec2.weak(586.5,1512)   ,  Vec2.weak(665,1312.5)   ,  Vec2.weak(585.5,1363)   ,  Vec2.weak(558.5,1404)   ],
                            mat,
                            filt
                        );
                        s.body = body;
                        s.sensorEnabled = false;
                        s.fluidEnabled = false;
                        s.fluidProperties = prop;
                        cbtype(s.cbTypes,"");
                    
                        s = new Polygon(
                            [   Vec2.weak(586.5,1512)   ,  Vec2.weak(613,1606.5)   ,  Vec2.weak(849.5,1488)   ,  Vec2.weak(855.5,1446)   ,  Vec2.weak(688,1312.5)   ,  Vec2.weak(665,1312.5)   ],
                            mat,
                            filt
                        );
                        s.body = body;
                        s.sensorEnabled = false;
                        s.fluidEnabled = false;
                        s.fluidProperties = prop;
                        cbtype(s.cbTypes,"");
                    
                        s = new Polygon(
                            [   Vec2.weak(793,1271.5)   ,  Vec2.weak(790.5,1273)   ,  Vec2.weak(799,1271.5)   ],
                            mat,
                            filt
                        );
                        s.body = body;
                        s.sensorEnabled = false;
                        s.fluidEnabled = false;
                        s.fluidProperties = prop;
                        cbtype(s.cbTypes,"");
                    
                        s = new Polygon(
                            [   Vec2.weak(1333.5,1311)   ,  Vec2.weak(1351.5,1217)   ,  Vec2.weak(1352.5,1167)   ,  Vec2.weak(1288.5,1132)   ,  Vec2.weak(1165.5,1136)   ,  Vec2.weak(1137.5,1216)   ,  Vec2.weak(1166,1538.5)   ,  Vec2.weak(1292.5,1381)   ],
                            mat,
                            filt
                        );
                        s.body = body;
                        s.sensorEnabled = false;
                        s.fluidEnabled = false;
                        s.fluidProperties = prop;
                        cbtype(s.cbTypes,"");
                    
                        s = new Polygon(
                            [   Vec2.weak(775,1317.5)   ,  Vec2.weak(688,1312.5)   ,  Vec2.weak(855.5,1446)   ],
                            mat,
                            filt
                        );
                        s.body = body;
                        s.sensorEnabled = false;
                        s.fluidEnabled = false;
                        s.fluidProperties = prop;
                        cbtype(s.cbTypes,"");
                    
                        s = new Polygon(
                            [   Vec2.weak(311.5,240)   ,  Vec2.weak(309.5,228)   ,  Vec2.weak(283.5,133)   ,  Vec2.weak(281.5,285)   ],
                            mat,
                            filt
                        );
                        s.body = body;
                        s.sensorEnabled = false;
                        s.fluidEnabled = false;
                        s.fluidProperties = prop;
                        cbtype(s.cbTypes,"");
                    
                        s = new Polygon(
                            [   Vec2.weak(1116,1940.5)   ,  Vec2.weak(1009,2005.5)   ,  Vec2.weak(1288.5,1927)   ],
                            mat,
                            filt
                        );
                        s.body = body;
                        s.sensorEnabled = false;
                        s.fluidEnabled = false;
                        s.fluidProperties = prop;
                        cbtype(s.cbTypes,"");
                    
                        s = new Polygon(
                            [   Vec2.weak(558.5,206)   ,  Vec2.weak(560.5,218)   ,  Vec2.weak(612.5,406)   ,  Vec2.weak(588.5,160)   ],
                            mat,
                            filt
                        );
                        s.body = body;
                        s.sensorEnabled = false;
                        s.fluidEnabled = false;
                        s.fluidProperties = prop;
                        cbtype(s.cbTypes,"");
                    
                        s = new Polygon(
                            [   Vec2.weak(2,0.5)   ,  Vec2.weak(0.5,1)   ,  Vec2.weak(18,1822.5)   ,  Vec2.weak(281.5,1088)   ,  Vec2.weak(281.5,1085)   ,  Vec2.weak(256.5,839)   ,  Vec2.weak(3,0.5)   ],
                            mat,
                            filt
                        );
                        s.body = body;
                        s.sensorEnabled = false;
                        s.fluidEnabled = false;
                        s.fluidProperties = prop;
                        cbtype(s.cbTypes,"");
                    
                        s = new Polygon(
                            [   Vec2.weak(990,559.5)   ,  Vec2.weak(1014.5,420)   ,  Vec2.weak(957.5,607)   ],
                            mat,
                            filt
                        );
                        s.body = body;
                        s.sensorEnabled = false;
                        s.fluidEnabled = false;
                        s.fluidProperties = prop;
                        cbtype(s.cbTypes,"");
                    
                        s = new Polygon(
                            [   Vec2.weak(314.5,101)   ,  Vec2.weak(351.5,2)   ,  Vec2.weak(351,0.5)   ,  Vec2.weak(3,0.5)   ,  Vec2.weak(283.5,133)   ],
                            mat,
                            filt
                        );
                        s.body = body;
                        s.sensorEnabled = false;
                        s.fluidEnabled = false;
                        s.fluidProperties = prop;
                        cbtype(s.cbTypes,"");
                    
                        s = new Polygon(
                            [   Vec2.weak(283.5,534)   ,  Vec2.weak(257.5,440)   ,  Vec2.weak(3,0.5)   ,  Vec2.weak(256.5,839)   ,  Vec2.weak(281.5,688)   ],
                            mat,
                            filt
                        );
                        s.body = body;
                        s.sensorEnabled = false;
                        s.fluidEnabled = false;
                        s.fluidProperties = prop;
                        cbtype(s.cbTypes,"");
                    
                        s = new Polygon(
                            [   Vec2.weak(1088,1297.5)   ,  Vec2.weak(1062.5,1376)   ,  Vec2.weak(1067.5,1390)   ,  Vec2.weak(1166,1538.5)   ,  Vec2.weak(1137.5,1216)   ],
                            mat,
                            filt
                        );
                        s.body = body;
                        s.sensorEnabled = false;
                        s.fluidEnabled = false;
                        s.fluidProperties = prop;
                        cbtype(s.cbTypes,"");
                    
                        s = new Polygon(
                            [   Vec2.weak(775,1071.5)   ,  Vec2.weak(858,1022.5)   ,  Vec2.weak(587,1113.5)   ],
                            mat,
                            filt
                        );
                        s.body = body;
                        s.sensorEnabled = false;
                        s.fluidEnabled = false;
                        s.fluidProperties = prop;
                        cbtype(s.cbTypes,"");
                    
                        s = new Polygon(
                            [   Vec2.weak(1689.5,583)   ,  Vec2.weak(1685,647.5)   ,  Vec2.weak(1735,589.5)   ,  Vec2.weak(1696,582.5)   ],
                            mat,
                            filt
                        );
                        s.body = body;
                        s.sensorEnabled = false;
                        s.fluidEnabled = false;
                        s.fluidProperties = prop;
                        cbtype(s.cbTypes,"");
                    
                        s = new Polygon(
                            [   Vec2.weak(1735,589.5)   ,  Vec2.weak(1685,647.5)   ,  Vec2.weak(1947,500.5)   ],
                            mat,
                            filt
                        );
                        s.body = body;
                        s.sensorEnabled = false;
                        s.fluidEnabled = false;
                        s.fluidProperties = prop;
                        cbtype(s.cbTypes,"");
                    
                        s = new Polygon(
                            [   Vec2.weak(1029,1043.5)   ,  Vec2.weak(1174.5,1074)   ,  Vec2.weak(1072,908.5)   ,  Vec2.weak(961,1008.5)   ],
                            mat,
                            filt
                        );
                        s.body = body;
                        s.sensorEnabled = false;
                        s.fluidEnabled = false;
                        s.fluidProperties = prop;
                        cbtype(s.cbTypes,"");
                    
                        s = new Polygon(
                            [   Vec2.weak(588.5,160)   ,  Vec2.weak(612.5,406)   ,  Vec2.weak(1014,415.5)   ,  Vec2.weak(1113,338.5)   ,  Vec2.weak(611.5,5)   ,  Vec2.weak(610,7.5)   ],
                            mat,
                            filt
                        );
                        s.body = body;
                        s.sensorEnabled = false;
                        s.fluidEnabled = false;
                        s.fluidProperties = prop;
                        cbtype(s.cbTypes,"");
                    
                        s = new Polygon(
                            [   Vec2.weak(314.5,901)   ,  Vec2.weak(314.5,899)   ,  Vec2.weak(256.5,839)   ,  Vec2.weak(282.5,934)   ,  Vec2.weak(304.5,912)   ],
                            mat,
                            filt
                        );
                        s.body = body;
                        s.sensorEnabled = false;
                        s.fluidEnabled = false;
                        s.fluidProperties = prop;
                        cbtype(s.cbTypes,"");
                    
                        s = new Polygon(
                            [   Vec2.weak(282.5,934)   ,  Vec2.weak(256.5,839)   ,  Vec2.weak(281.5,1085)   ],
                            mat,
                            filt
                        );
                        s.body = body;
                        s.sensorEnabled = false;
                        s.fluidEnabled = false;
                        s.fluidProperties = prop;
                        cbtype(s.cbTypes,"");
                    
                        s = new Polygon(
                            [   Vec2.weak(849.5,1488)   ,  Vec2.weak(613,1606.5)   ,  Vec2.weak(619.5,1608)   ,  Vec2.weak(984,1512.5)   ],
                            mat,
                            filt
                        );
                        s.body = body;
                        s.sensorEnabled = false;
                        s.fluidEnabled = false;
                        s.fluidProperties = prop;
                        cbtype(s.cbTypes,"");
                    
                        s = new Polygon(
                            [   Vec2.weak(1296,329.5)   ,  Vec2.weak(1586,27.5)   ,  Vec2.weak(611.5,5)   ,  Vec2.weak(1113,338.5)   ,  Vec2.weak(1169,338.5)   ],
                            mat,
                            filt
                        );
                        s.body = body;
                        s.sensorEnabled = false;
                        s.fluidEnabled = false;
                        s.fluidProperties = prop;
                        cbtype(s.cbTypes,"");
                    
                        s = new Polygon(
                            [   Vec2.weak(1003.5,2001)   ,  Vec2.weak(917,2041.5)   ,  Vec2.weak(1009,2005.5)   ],
                            mat,
                            filt
                        );
                        s.body = body;
                        s.sensorEnabled = false;
                        s.fluidEnabled = false;
                        s.fluidProperties = prop;
                        cbtype(s.cbTypes,"");
                    
                        s = new Polygon(
                            [   Vec2.weak(1642,40.5)   ,  Vec2.weak(1655,39.5)   ,  Vec2.weak(1696,29.5)   ,  Vec2.weak(1586,27.5)   ],
                            mat,
                            filt
                        );
                        s.body = body;
                        s.sensorEnabled = false;
                        s.fluidEnabled = false;
                        s.fluidProperties = prop;
                        cbtype(s.cbTypes,"");
                    
                        s = new Polygon(
                            [   Vec2.weak(1558.5,1161)   ,  Vec2.weak(1557.5,1165)   ,  Vec2.weak(1611.5,1354)   ,  Vec2.weak(1596,1134.5)   ],
                            mat,
                            filt
                        );
                        s.body = body;
                        s.sensorEnabled = false;
                        s.fluidEnabled = false;
                        s.fluidProperties = prop;
                        cbtype(s.cbTypes,"");
                    
                        s = new Polygon(
                            [   Vec2.weak(1791,36.5)   ,  Vec2.weak(1843,24.5)   ,  Vec2.weak(1710,29.5)   ,  Vec2.weak(1775,36.5)   ],
                            mat,
                            filt
                        );
                        s.body = body;
                        s.sensorEnabled = false;
                        s.fluidEnabled = false;
                        s.fluidProperties = prop;
                        cbtype(s.cbTypes,"");
                    
                        s = new Polygon(
                            [   Vec2.weak(1099.5,1627)   ,  Vec2.weak(1166,1538.5)   ,  Vec2.weak(1027,1610.5)   ,  Vec2.weak(1094,1627.5)   ],
                            mat,
                            filt
                        );
                        s.body = body;
                        s.sensorEnabled = false;
                        s.fluidEnabled = false;
                        s.fluidProperties = prop;
                        cbtype(s.cbTypes,"");
                    
                        s = new Polygon(
                            [   Vec2.weak(1027,1610.5)   ,  Vec2.weak(1166,1538.5)   ,  Vec2.weak(1014,1608.5)   ],
                            mat,
                            filt
                        );
                        s.body = body;
                        s.sensorEnabled = false;
                        s.fluidEnabled = false;
                        s.fluidProperties = prop;
                        cbtype(s.cbTypes,"");
                    
                        s = new Polygon(
                            [   Vec2.weak(1014,1608.5)   ,  Vec2.weak(1166,1538.5)   ,  Vec2.weak(984,1512.5)   ,  Vec2.weak(619.5,1608)   ],
                            mat,
                            filt
                        );
                        s.body = body;
                        s.sensorEnabled = false;
                        s.fluidEnabled = false;
                        s.fluidProperties = prop;
                        cbtype(s.cbTypes,"");
                    
                        s = new Polygon(
                            [   Vec2.weak(311.5,1439)   ,  Vec2.weak(311.5,1435)   ,  Vec2.weak(282.5,1334)   ,  Vec2.weak(279.5,1488)   ],
                            mat,
                            filt
                        );
                        s.body = body;
                        s.sensorEnabled = false;
                        s.fluidEnabled = false;
                        s.fluidProperties = prop;
                        cbtype(s.cbTypes,"");
                    
                        s = new Polygon(
                            [   Vec2.weak(558.5,607)   ,  Vec2.weak(558.5,611)   ,  Vec2.weak(587.5,712)   ,  Vec2.weak(590.5,558)   ],
                            mat,
                            filt
                        );
                        s.body = body;
                        s.sensorEnabled = false;
                        s.fluidEnabled = false;
                        s.fluidProperties = prop;
                        cbtype(s.cbTypes,"");
                    
                        s = new Polygon(
                            [   Vec2.weak(590.5,558)   ,  Vec2.weak(588.5,958)   ,  Vec2.weak(1014,415.5)   ,  Vec2.weak(612.5,406)   ],
                            mat,
                            filt
                        );
                        s.body = body;
                        s.sensorEnabled = false;
                        s.fluidEnabled = false;
                        s.fluidProperties = prop;
                        cbtype(s.cbTypes,"");
                    
                        s = new Polygon(
                            [   Vec2.weak(1843,24.5)   ,  Vec2.weak(1887,17.5)   ,  Vec2.weak(1696,29.5)   ,  Vec2.weak(1710,29.5)   ],
                            mat,
                            filt
                        );
                        s.body = body;
                        s.sensorEnabled = false;
                        s.fluidEnabled = false;
                        s.fluidProperties = prop;
                        cbtype(s.cbTypes,"");
                    
                        s = new Polygon(
                            [   Vec2.weak(1609.5,623)   ,  Vec2.weak(1597,742.5)   ,  Vec2.weak(1685,647.5)   ,  Vec2.weak(1613,622.5)   ],
                            mat,
                            filt
                        );
                        s.body = body;
                        s.sensorEnabled = false;
                        s.fluidEnabled = false;
                        s.fluidProperties = prop;
                        cbtype(s.cbTypes,"");
                    
                        s = new Polygon(
                            [   Vec2.weak(1685,647.5)   ,  Vec2.weak(1597,742.5)   ,  Vec2.weak(1507.5,886)   ,  Vec2.weak(1509,888.5)   ,  Vec2.weak(1603.5,957)   ,  Vec2.weak(1947,500.5)   ],
                            mat,
                            filt
                        );
                        s.body = body;
                        s.sensorEnabled = false;
                        s.fluidEnabled = false;
                        s.fluidProperties = prop;
                        cbtype(s.cbTypes,"");
                    
                        s = new Polygon(
                            [   Vec2.weak(1596,1134.5)   ,  Vec2.weak(1611.5,1354)   ,  Vec2.weak(1601.5,1129)   ],
                            mat,
                            filt
                        );
                        s.body = body;
                        s.sensorEnabled = false;
                        s.fluidEnabled = false;
                        s.fluidProperties = prop;
                        cbtype(s.cbTypes,"");
                    
                        s = new Polygon(
                            [   Vec2.weak(1601.5,1129)   ,  Vec2.weak(1611.5,1354)   ,  Vec2.weak(1947,500.5)   ,  Vec2.weak(1605.5,1038)   ],
                            mat,
                            filt
                        );
                        s.body = body;
                        s.sensorEnabled = false;
                        s.fluidEnabled = false;
                        s.fluidProperties = prop;
                        cbtype(s.cbTypes,"");
                    
                        s = new Polygon(
                            [   Vec2.weak(796,2014.5)   ,  Vec2.weak(736.5,2024)   ,  Vec2.weak(917,2041.5)   ,  Vec2.weak(806,2014.5)   ],
                            mat,
                            filt
                        );
                        s.body = body;
                        s.sensorEnabled = false;
                        s.fluidEnabled = false;
                        s.fluidProperties = prop;
                        cbtype(s.cbTypes,"");
                    
                        s = new Polygon(
                            [   Vec2.weak(1227,1581.5)   ,  Vec2.weak(1230,1581.5)   ,  Vec2.weak(1166,1538.5)   ],
                            mat,
                            filt
                        );
                        s.body = body;
                        s.sensorEnabled = false;
                        s.fluidEnabled = false;
                        s.fluidProperties = prop;
                        cbtype(s.cbTypes,"");
                    
                        s = new Polygon(
                            [   Vec2.weak(329,2014.5)   ,  Vec2.weak(319,2014.5)   ,  Vec2.weak(249.5,2025)   ,  Vec2.weak(438,2041.5)   ],
                            mat,
                            filt
                        );
                        s.body = body;
                        s.sensorEnabled = false;
                        s.fluidEnabled = false;
                        s.fluidProperties = prop;
                        cbtype(s.cbTypes,"");
                    
                        s = new Polygon(
                            [   Vec2.weak(475,1944.5)   ,  Vec2.weak(473.5,1945)   ,  Vec2.weak(442.5,2037)   ,  Vec2.weak(532,2005.5)   ],
                            mat,
                            filt
                        );
                        s.body = body;
                        s.sensorEnabled = false;
                        s.fluidEnabled = false;
                        s.fluidProperties = prop;
                        cbtype(s.cbTypes,"");
                    
                        s = new Polygon(
                            [   Vec2.weak(532,2005.5)   ,  Vec2.weak(442.5,2037)   ,  Vec2.weak(440,2041.5)   ,  Vec2.weak(917,2041.5)   ],
                            mat,
                            filt
                        );
                        s.body = body;
                        s.sensorEnabled = false;
                        s.fluidEnabled = false;
                        s.fluidProperties = prop;
                        cbtype(s.cbTypes,"");
                    
                        s = new Polygon(
                            [   Vec2.weak(1009,2005.5)   ,  Vec2.weak(917,2041.5)   ,  Vec2.weak(2047.5,2047)   ,  Vec2.weak(1288.5,1927)   ],
                            mat,
                            filt
                        );
                        s.body = body;
                        s.sensorEnabled = false;
                        s.fluidEnabled = false;
                        s.fluidProperties = prop;
                        cbtype(s.cbTypes,"");
                    
                        s = new Polygon(
                            [   Vec2.weak(957.5,607)   ,  Vec2.weak(1014.5,420)   ,  Vec2.weak(1014,415.5)   ,  Vec2.weak(588.5,958)   ,  Vec2.weak(588.5,961)   ,  Vec2.weak(947.5,628)   ],
                            mat,
                            filt
                        );
                        s.body = body;
                        s.sensorEnabled = false;
                        s.fluidEnabled = false;
                        s.fluidProperties = prop;
                        cbtype(s.cbTypes,"");
                    
                        s = new Polygon(
                            [   Vec2.weak(1352,1165.5)   ,  Vec2.weak(1288.5,1132)   ,  Vec2.weak(1352.5,1167)   ],
                            mat,
                            filt
                        );
                        s.body = body;
                        s.sensorEnabled = false;
                        s.fluidEnabled = false;
                        s.fluidProperties = prop;
                        cbtype(s.cbTypes,"");
                    
                        s = new Polygon(
                            [   Vec2.weak(1460.5,1745)   ,  Vec2.weak(1288.5,1927)   ,  Vec2.weak(2047.5,2047)   ,  Vec2.weak(1505,1704.5)   ],
                            mat,
                            filt
                        );
                        s.body = body;
                        s.sensorEnabled = false;
                        s.fluidEnabled = false;
                        s.fluidProperties = prop;
                        cbtype(s.cbTypes,"");
                    
                        s = new Polygon(
                            [   Vec2.weak(948.5,636)   ,  Vec2.weak(588.5,961)   ,  Vec2.weak(1011.5,804)   ],
                            mat,
                            filt
                        );
                        s.body = body;
                        s.sensorEnabled = false;
                        s.fluidEnabled = false;
                        s.fluidProperties = prop;
                        cbtype(s.cbTypes,"");
                    
                        s = new Polygon(
                            [   Vec2.weak(281.5,285)   ,  Vec2.weak(283.5,133)   ,  Vec2.weak(279.5,290)   ],
                            mat,
                            filt
                        );
                        s.body = body;
                        s.sensorEnabled = false;
                        s.fluidEnabled = false;
                        s.fluidProperties = prop;
                        cbtype(s.cbTypes,"");
                    
                        s = new Polygon(
                            [   Vec2.weak(279.5,290)   ,  Vec2.weak(283.5,133)   ,  Vec2.weak(3,0.5)   ,  Vec2.weak(257.5,434)   ],
                            mat,
                            filt
                        );
                        s.body = body;
                        s.sensorEnabled = false;
                        s.fluidEnabled = false;
                        s.fluidProperties = prop;
                        cbtype(s.cbTypes,"");
                    
                        s = new Polygon(
                            [   Vec2.weak(1603.5,957)   ,  Vec2.weak(1605.5,1038)   ,  Vec2.weak(1947,500.5)   ],
                            mat,
                            filt
                        );
                        s.body = body;
                        s.sensorEnabled = false;
                        s.fluidEnabled = false;
                        s.fluidProperties = prop;
                        cbtype(s.cbTypes,"");
                    
                        s = new Polygon(
                            [   Vec2.weak(1611.5,1354)   ,  Vec2.weak(1609.5,1431)   ,  Vec2.weak(1947,500.5)   ],
                            mat,
                            filt
                        );
                        s.body = body;
                        s.sensorEnabled = false;
                        s.fluidEnabled = false;
                        s.fluidProperties = prop;
                        cbtype(s.cbTypes,"");
                    
                        s = new Polygon(
                            [   Vec2.weak(1609.5,1431)   ,  Vec2.weak(1597,1536.5)   ,  Vec2.weak(1947,500.5)   ],
                            mat,
                            filt
                        );
                        s.body = body;
                        s.sensorEnabled = false;
                        s.fluidEnabled = false;
                        s.fluidProperties = prop;
                        cbtype(s.cbTypes,"");
                    
                        s = new Polygon(
                            [   Vec2.weak(984,1512.5)   ,  Vec2.weak(1166,1538.5)   ,  Vec2.weak(1067.5,1390)   ],
                            mat,
                            filt
                        );
                        s.body = body;
                        s.sensorEnabled = false;
                        s.fluidEnabled = false;
                        s.fluidProperties = prop;
                        cbtype(s.cbTypes,"");
                    
                        s = new Polygon(
                            [   Vec2.weak(1165.5,1136)   ,  Vec2.weak(1288.5,1132)   ,  Vec2.weak(1174.5,1074)   ],
                            mat,
                            filt
                        );
                        s.body = body;
                        s.sensorEnabled = false;
                        s.fluidEnabled = false;
                        s.fluidProperties = prop;
                        cbtype(s.cbTypes,"");
                    
                        s = new Polygon(
                            [   Vec2.weak(961,1008.5)   ,  Vec2.weak(1072,908.5)   ,  Vec2.weak(858,1022.5)   ],
                            mat,
                            filt
                        );
                        s.body = body;
                        s.sensorEnabled = false;
                        s.fluidEnabled = false;
                        s.fluidProperties = prop;
                        cbtype(s.cbTypes,"");
                    
                        s = new Polygon(
                            [   Vec2.weak(858,1022.5)   ,  Vec2.weak(1072,908.5)   ,  Vec2.weak(1069.5,909)   ,  Vec2.weak(587.5,1111)   ,  Vec2.weak(587,1113.5)   ],
                            mat,
                            filt
                        );
                        s.body = body;
                        s.sensorEnabled = false;
                        s.fluidEnabled = false;
                        s.fluidProperties = prop;
                        cbtype(s.cbTypes,"");
                    
                        s = new Polygon(
                            [   Vec2.weak(1978.5,408)   ,  Vec2.weak(1978.5,413)   ,  Vec2.weak(2047.5,2047)   ,  Vec2.weak(2033.5,224)   ],
                            mat,
                            filt
                        );
                        s.body = body;
                        s.sensorEnabled = false;
                        s.fluidEnabled = false;
                        s.fluidProperties = prop;
                        cbtype(s.cbTypes,"");
                    
                        s = new Polygon(
                            [   Vec2.weak(257.5,434)   ,  Vec2.weak(3,0.5)   ,  Vec2.weak(257.5,440)   ],
                            mat,
                            filt
                        );
                        s.body = body;
                        s.sensorEnabled = false;
                        s.fluidEnabled = false;
                        s.fluidProperties = prop;
                        cbtype(s.cbTypes,"");
                    
                        s = new Polygon(
                            [   Vec2.weak(97,1930.5)   ,  Vec2.weak(93.5,1929)   ,  Vec2.weak(1,2047.5)   ,  Vec2.weak(249.5,2025)   ],
                            mat,
                            filt
                        );
                        s.body = body;
                        s.sensorEnabled = false;
                        s.fluidEnabled = false;
                        s.fluidProperties = prop;
                        cbtype(s.cbTypes,"");
                    
                        s = new Polygon(
                            [   Vec2.weak(21,1819.5)   ,  Vec2.weak(281.5,1088)   ,  Vec2.weak(18,1822.5)   ],
                            mat,
                            filt
                        );
                        s.body = body;
                        s.sensorEnabled = false;
                        s.fluidEnabled = false;
                        s.fluidProperties = prop;
                        cbtype(s.cbTypes,"");
                    
                        s = new Polygon(
                            [   Vec2.weak(1597,1536.5)   ,  Vec2.weak(2047.5,2047)   ,  Vec2.weak(1978.5,413)   ],
                            mat,
                            filt
                        );
                        s.body = body;
                        s.sensorEnabled = false;
                        s.fluidEnabled = false;
                        s.fluidProperties = prop;
                        cbtype(s.cbTypes,"");
                    
                        s = new Polygon(
                            [   Vec2.weak(0.5,1)   ,  Vec2.weak(1,2047.5)   ,  Vec2.weak(18,1822.5)   ],
                            mat,
                            filt
                        );
                        s.body = body;
                        s.sensorEnabled = false;
                        s.fluidEnabled = false;
                        s.fluidProperties = prop;
                        cbtype(s.cbTypes,"");
                    
                        s = new Polygon(
                            [   Vec2.weak(18,1822.5)   ,  Vec2.weak(1,2047.5)   ,  Vec2.weak(93.5,1929)   ],
                            mat,
                            filt
                        );
                        s.body = body;
                        s.sensorEnabled = false;
                        s.fluidEnabled = false;
                        s.fluidProperties = prop;
                        cbtype(s.cbTypes,"");
                    
                        s = new Polygon(
                            [   Vec2.weak(249.5,2025)   ,  Vec2.weak(1,2047.5)   ,  Vec2.weak(438,2041.5)   ],
                            mat,
                            filt
                        );
                        s.body = body;
                        s.sensorEnabled = false;
                        s.fluidEnabled = false;
                        s.fluidProperties = prop;
                        cbtype(s.cbTypes,"");
                    
                        s = new Polygon(
                            [   Vec2.weak(1,2047.5)   ,  Vec2.weak(2047.5,2047)   ,  Vec2.weak(438,2041.5)   ],
                            mat,
                            filt
                        );
                        s.body = body;
                        s.sensorEnabled = false;
                        s.fluidEnabled = false;
                        s.fluidProperties = prop;
                        cbtype(s.cbTypes,"");
                    
                        s = new Polygon(
                            [   Vec2.weak(948.5,636)   ,  Vec2.weak(947.5,628)   ,  Vec2.weak(588.5,961)   ],
                            mat,
                            filt
                        );
                        s.body = body;
                        s.sensorEnabled = false;
                        s.fluidEnabled = false;
                        s.fluidProperties = prop;
                        cbtype(s.cbTypes,"");
                    
                        s = new Polygon(
                            [   Vec2.weak(1887,17.5)   ,  Vec2.weak(1892.5,18)   ,  Vec2.weak(2047,0.5)   ],
                            mat,
                            filt
                        );
                        s.body = body;
                        s.sensorEnabled = false;
                        s.fluidEnabled = false;
                        s.fluidProperties = prop;
                        cbtype(s.cbTypes,"");
                    
                        s = new Polygon(
                            [   Vec2.weak(2021.5,129)   ,  Vec2.weak(2033.5,224)   ,  Vec2.weak(2047,0.5)   ],
                            mat,
                            filt
                        );
                        s.body = body;
                        s.sensorEnabled = false;
                        s.fluidEnabled = false;
                        s.fluidProperties = prop;
                        cbtype(s.cbTypes,"");
                    
                        s = new Polygon(
                            [   Vec2.weak(2047,0.5)   ,  Vec2.weak(2033.5,224)   ,  Vec2.weak(2047.5,2047)   ],
                            mat,
                            filt
                        );
                        s.body = body;
                        s.sensorEnabled = false;
                        s.fluidEnabled = false;
                        s.fluidProperties = prop;
                        cbtype(s.cbTypes,"");
                    
                
            

            anchor = (false) ? body.localCOM.copy() : Vec2.get(0,0);
            body.translateShapes(Vec2.weak(-anchor.x,-anchor.y));
            body.position.setxy(0,0);

            bodies["level4Decor"] = new BodyPair(body,anchor);
        
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
