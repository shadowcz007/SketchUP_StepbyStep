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

def createHeights(_n)
  
  _res=[]
   
  _np=2*Math::PI/_n
  
  for x in 1.._n
    y=Math.sin(x*_np)
    _res.push(y)
  end 
  
  #p _res
  return _res
  
end


def createBoxs(entities,_originPoint,_ps,_zs,_zMax)
    # Add a group to the model.
    
    # 2
    exchange=0
    
    
    
    for i in 0..(_ps.length-1)
      #entities.add_cpoint p
       ps=_ps[i]
       
       #exchange2=Math.sin(i*rand)
       
       ps.each do |p|
          group = entities.add_group
          face=group.entities.add_face(p)
       
          # 1
          # point2 = Geom::Point3d.new(0, 0, _zs[i])
          
          
          # 2
          #point2 = Geom::Point3d.new(0, 0, _zs[i+exchange])
          
          
          # 3
          #h= _zs[exchange]
          
          # 4
          h= (_zs[exchange])*_zMax+rand(100) 
        
          if h== nil
            h=0
            exchange=0
          end
          
          point2 = Geom::Point3d.new(0, 0, h)
          exchange=exchange+1
          
          
          
          edge=group.entities.add_line(_originPoint, point2)
          face.followme(edge)
          
          
       end
        
       # 2  
       #exchange=exchange+1
       
       exchange=exchange-1
       
    end
    
end


_originPoint=[0,0,0]
_size={
  "width"=>36000,
  "height"=>36000
  }
_grid={
  "width"=>300,
  "height"=>800
  }
_zMax=800


pointsResult=createGrid(_originPoint,_size,_grid)
#p pointsResult
 
_zs=createHeights(2000)

createBoxs(entities,_originPoint,pointsResult,_zs,_zMax)
