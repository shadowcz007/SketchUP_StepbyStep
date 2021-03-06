model = Sketchup.active_model
entities = model.active_entities

def createGrid(_originPoint,_size,_grid)
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

def createHeights(_zMax,_xNum,_yNum)
  
  _res=[];
  _in=_xNum-2;
  _jn=_yNum-2;
  
  for i in 0.._in
     #p i
     zi=_zMax
      for j in 0.._jn
        
        zi=zi-5
        
        #把zi保存到zi_res里，然后根据区域坐标，操作zi_res的值，最后保存zi_res的值，这样zi的值不受影响。
        zi_res=zi
        
        if i>_in*0.1 && i<_in*0.3 && j>_jn*0.5 && j<_jn*0.6
         # p [i,j,zi_res]
          zi_res=Math.sin(rand(0..3))
          p [i,j,zi_res]
          
        end
        
        if zi_res<=0
          zi_res=0
        end
        _res.push(zi_res)
       # p [i,j,zi,_xNum,_yNum]
      end
  
      _zMax=_zMax-10
  
    if _zMax<=0
      _zMax=0
    end
  
  end
  return _res
  
end

def createBoxs(entities,_originPoint,_ps,_zs)
    # Add a group to the model.
   
  
    for i in 0..(_ps.length-1)
      #entities.add_cpoint p
       ps=_ps[i]
       
       group = entities.add_group
       face=group.entities.add_face(ps)
       #face=entities.add_face(ps)
  
      # row=i/pointsResult["xNum"].floor+1

       point2 = Geom::Point3d.new(0, 0, _zs[i])
       edge=group.entities.add_line(_originPoint, point2)
       #edge = entities.add_line(_originPoint, point2)
       face.followme(edge)
    end
    
end

_originPoint=[0,0,0]
_size={
  "width"=>6000,
  "height"=>6000
  }
_grid={
  "width"=>100,
  "height"=>100
  }
_zMax=1200

#ruby里，哈希（Hash）是类似 "key" => "value" 这样的键值对集合。JS是Object对象，Python是字典，Objective-C也是叫字典。

pointsResult=createGrid(_originPoint,_size,_grid)
#p points

_ps=pointsResult["points"]
_zs=createHeights(_zMax,pointsResult["xNum"],pointsResult["yNum"])
#p _zs
#p _ps.length
#p _zs.length

createBoxs(entities,_originPoint,_ps,_zs)
