model = Sketchup.active_model
entities = model.active_entities


def createGridByHeight(_originPoint,_size,_grid,_height)
    _w=_size["width"]
    _h=_size["height"]
    _z=_height
    
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
    return _points
end


_originPoint=[0,0,0]

_size={
  "width"=>2000,
  "height"=>2000
  }
_grid={
  "width"=>110,
  "height"=>110
  }
_height=3000

#ruby里，哈希（Hash）是类似 "key" => "value" 这样的键值对集合。JS是Object对象，Python是字典，Objective-C也是叫字典。


points=createGridByHeight(_originPoint,_size,_grid,_height)
#p points

points.each do |ps|
  #entities.add_cpoint p
  entities.add_face(ps)
end
