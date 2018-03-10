model = Sketchup.active_model
entities = model.active_entities

def createGrid(_originPoint,_size,_grid)
    _px=600
    _py=500
    
    _w=_size["width"]
    _h=_size["height"]
    _z=_originPoint[2]
    
    _x=_originPoint[0]
    _y=_originPoint[1]
    
    _gw=_grid["width"]
    _gh=_grid["height"]
    
    _xNum=(_w/(_gw+_px)).floor.to_f
    _yNum=(_h/(_gh+_py)).floor.to_f
    
    _points=[]
    
    for i in 1..(_xNum-1)
     
      _pointX1=_x+(_gw+_px)*(i-1)
      _pointX2=_x+(_gw+_px)*i-_px
      
       #p [_pointX1,_pointX2]
       _pointsByRow=[]
       
       for j in 1..(_yNum-1)
         _pointY1=_y+(_gh+_py)*(j-1)
         _pointY2=_y+(_gh+_py)*j-_py
         
         _point1=[_pointX1,_pointY1,_z]
         _point2=[_pointX1,_pointY2,_z]
         _point3=[_pointX2,_pointY2,_z]
         _point4=[_pointX2,_pointY1,_z]
         
          _pointsByRow.push([_point1,_point2,_point3,_point4])
          if j==1 && i==1
           #调试用的
           # p [_point1,_point2,_point3,_point4]
          end
       end
       
       _points.push(_pointsByRow)
       
    end
    
    return _points
        
end

def createHeights(_zMax,_xNum,_yNum)
  
  _res=[];
  _in=_xNum-2;
  _jn=_yNum-2;
   
  
end


def createBoxs(entities,_originPoint,_ps,_zs)
    # Add a group to the model.
   
    for i in 0..(_ps.length-1)
      #entities.add_cpoint p
       ps=_ps[i]
       ps.each do |p|
        group = entities.add_group
        face=group.entities.add_face(p)
       
        point2 = Geom::Point3d.new(0, 0, _zs[i])
        edge=group.entities.add_line(_originPoint, point2)
        
        face.followme(edge)
       
       end
       
    end
    
end


_originPoint=[0,0,0]
_size={
  "width"=>6000,
  "height"=>6000
  }
_grid={
  "width"=>300,
  "height"=>800
  }
_zMax=1200


pointsResult=createGrid(_originPoint,_size,_grid)
p pointsResult
 
#_zs=createHeights(_zMax,pointsResult["xNum"],pointsResult["yNum"])

createBoxs(entities,_originPoint,pointsResult,_zMax)
