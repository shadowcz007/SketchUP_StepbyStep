model = Sketchup.active_model
entities = model.active_entities


def createGridByHeight(_originPoint,_size,_grid)
    _w=_size["width"]
    _h=_size["height"]
    _z=_originPoint[2]
    
    _gw=_grid["width"]
    _gh=_grid["height"]
    
    _xNum=(_w/_gw).floor.to_f
    _yNum=(_h/_gh).floor.to_f
    
    _paddingX=(_w-_xNum*_gw)/2
    _paddingY=(_h-_yNum*_gh)/2
    
     _points=[]
    
    for i in 1..(_xNum-1)
       # p i  
       _pointX1= _paddingX+_originPoint[0]+_gw*(i-1)
       _pointX2= _paddingX+_originPoint[0]+_gw*i
       
       for j in 1..(_yNum-1)
         _pointY1=_paddingY+_originPoint[0]+_gh*(j-1)
         _pointY2=_paddingY+_originPoint[0]+_gh*j
         
         _point1=[_pointX1,_pointY1,_z]
         _point2=[_pointX1,_pointY2,_z]
         _point3=[_pointX2,_pointY2,_z]
         _point4=[_pointX2,_pointY1,_z]
         
          _points.push([_point1,_point2,_point3,_point4])
          if j==1 && i==1
           #调试用的
           # p [_point1,_point2,_point3,_point4]
          end
       end
       
    end
   # p _points
    return {
            "points"=>_points,
            "xNum"=>_xNum,
            "yNum"=>_yNum
          }
end


_originPoint=[0,0,0]

_size={
  "width"=>6000,
  "height"=>3000
  }
_grid={
  "width"=>100,
  "height"=>100
  }
_seed=12
_height={
  "x"=>1200,
  "y"=>600
  }

#ruby里，哈希（Hash）是类似 "key" => "value" 这样的键值对集合。JS是Object对象，Python是字典，Objective-C也是叫字典。


pointsResult=createGridByHeight(_originPoint,_size,_grid)
#p points

currentRow=0


for i in 0..(pointsResult["points"].length-1)
  #entities.add_cpoint p
  ps=pointsResult["points"][i]
  face=entities.add_face(ps)
  
  row=i/pointsResult["yNum"].floor+1
  _z0="x"
  if row!=currentRow
    _z0="y"
    currentRow=row
  end
  
  _height[_z0]=_height[_z0]-_seed
  
   point2 = Geom::Point3d.new(0, 0, _height[_z0])
   edge = entities.add_line(_originPoint, point2)
   face.followme(edge)
end
