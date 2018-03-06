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
    
    for i in 0..(_xNum-1)
       # p i  
       _pointX= _paddingX+_originPoint[0]+_gw*i
      
       for j in 0..(_yNum-1)
         _pointY=_paddingY+_originPoint[0]+_gh*j
         _point=[_pointX,_pointY,_z]
         _points.push(_point)
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

points.each do |p|
  entities.add_cpoint p
end

