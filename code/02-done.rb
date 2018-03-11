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
    
    _points={
        "row"=> 0
     }
    
    for i in 1..(_xNum-1)
     
      _pointX1=_x+(_gw+_px)*(i-1)
      _pointX2=_x+(_gw+_px)*i-_px
      
       #p [_pointX1,_pointX2]
       _gpoints=[]
       
       for j in 1..(_yNum-1)
         _pointY1=_y+(_gh+_py)*(j-1)
         _pointY2=_y+(_gh+_py)*j-_py
         
         _point1=[_pointX1,_pointY1,_z]
         _point2=[_pointX1,_pointY2,_z]
         _point3=[_pointX2,_pointY2,_z]
         _point4=[_pointX2,_pointY1,_z]
         
          _gpoints.push([_point1,_point2,_point3,_point4])
          if j==1 && i==1
           #调试用的
           # p [_point1,_point2,_point3,_point4]
          end
       end
        if i==1
           #调试用的
           # p _gpoints
        end
       _points[_points["row"]]=_gpoints
       _points["row"]=_points["row"]+1
       
       
    end
    
    return _points
        
end

def createHeights(_peakValue,_parts)
  
  _res=[]
   
  _np=(_peakValue+2)*Math::PI/_parts
  
  for x in 1.._parts
    y=Math.sin(x*_np)
    _res.push(y)
  end 
  
  #p _res
  return _res
  
end


def createBoxs(entities,_originPoint,_pointsResult,_zsOfRow,_zsOfColumn,_zMax)
    _n=_pointsResult["row"]
    exchange=0
    
    for i in 0..(_n-1)
      #entities.add_cpoint p
       ps=_pointsResult[i]
      
       _base=200
       
       ps.each do |p|
          group = entities.add_group
          face=group.entities.add_face(p)
          
          _r=_zsOfRow[i] ||0
          _c=_zsOfColumn[exchange] || 0
         
          h= ((_r+_c)*(_zMax-_base)).abs+_base 
        
          point2 = Geom::Point3d.new(0, 0, h)
          exchange=exchange+1
          
          edge=group.entities.add_line(_originPoint, point2)
          face.followme(edge)
          
       end
        
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
_zMax=1000

_pointsResult=createGrid(_originPoint,_size,_grid)

_peakValueOfRow=3
_partsOfRow=_pointsResult["row"]

_zsOfRow=createHeights(_peakValueOfRow,_partsOfRow)

_peakValueOfColumn=0
_partsOfColumn=_pointsResult[0].length
_zsOfColumn=createHeights(_peakValueOfColumn,_partsOfColumn)
  
createBoxs(entities,_originPoint,_pointsResult,_zsOfRow,_zsOfColumn,_zMax)
=begin
  for x in 0..(_zs.length-1)
     entities.add_cpoint [x,_zs[x],0]
  end
  
  for x in 0..(_zsOfColumn.length-1)
     entities.add_cpoint [_zsOfColumn[x],x,0]
  end
=end
