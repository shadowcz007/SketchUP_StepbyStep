model = Sketchup.active_model
entities = model.active_entities
points=[[0,0,0]]
for i in 0..500
  p=points[points.length-1]
  r1=rand(0)>0.5?1:(-1)
  r2=rand(0)>0.5?1:(-1)

  x=p[0]+i*rand(1000)*r1*r2
  y=p[1]+i*rand(1000)*r1*r2
  z=p[2]+i*rand(1000)

  #puts "x:#{x},y:#{y},z:#{z}"
  point = [x,y,z]
  entities.add_edges(p, point)
  points.push(point)
  #constpoint = entities.add_cpoint point
  if points.length>3
      p1 = points[points.length-3]
      p2 = points[points.length-2]
      p3 = points[points.length-1]
      
      entities.add_face(p1, p2, p3, p1)
  end


end
