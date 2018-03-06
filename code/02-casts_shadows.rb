model = Sketchup.active_model

def createGridByHeight(_size,_grid,_height)
    _w=_size["width"]
    _h=_size["height"]
    _z=_height
    
    _gw=_gird["width"]
    _gh=_grid["height"]
    
    _xNum=floor(_w/_gw)
    _yNum=floor(_h/_gh)
    
    p _xNum
    
end

_size={
  "width"=>100,
  "height"=>100
  }
_grid={
  "width"=>10,
  "height"=>10
  }
_height=10
createGridByHeight(_size,_grid,_height)
