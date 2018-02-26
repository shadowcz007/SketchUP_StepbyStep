model = Sketchup.active_model
entities = model.active_entities

#Adding Geometry
point1 = [0,0,0]
point2 = [100,100,100]

entities.add_edges(point1, point2)

#Adding a Face
point1 = [0,0,0]
point2 = [100,100,100]
point3 = [0,100,100]

entities.add_face(point1, point2, point3, point1)


#Adding a Construction Point
point1 = [0,0,0]
point2 = [100,100,100]
point3 = [0,100,100]

entities.add_cpoint(point1)
entities.add_cpoint(point2)
entities.add_cpoint(point3)


#Add a Circle
centerpoint = Geom::Point3d.new(0,0,0)
vector = Geom::Vector3d.new 0,0,1
edges = entities.add_circle( centerpoint, vector, 10 )



#Add Construction Points to a Circle
centerpoint = Geom::Point3d.new(0,0,0)
vector = Geom::Vector3d.new 0,0,1
model = Sketchup.active_model
entities = model.active_entities
edges = entities.add_circle( centerpoint, vector, 10 )
# This is an empty aray where the vertices will be stored.
vertices = []

edges.each do |edge|
  # Add the start and end vertices for every edge. Think about this, 
  # each vertex will be added twice because it is used by 2 edges.
  vertices << edge.start
  vertices << edge.end
end

# This is where we remove duplicate vertices.
vertices.uniq!
vertices.each do |vert|
  # Here we add the construction point to the model, using the 
  # position of the vertex.
  entities.add_cpoint(vert.position)
end

#ruby的循环语句
is=[1,2,1,2,3]

for i in is
   puts "局部变量的值为 #{i}"
end


is.each do |i|
   puts "局部变量的值为 #{i}"
end




#Add 3D Text
# Look at the add_3d_text method in the Entities class
# in the Ruby API docs for information about all the 
# available parameters to create 3D Text.
entities = Sketchup.active_model.entities
string = "Hello World in 3D!"
align = TextAlignLeft
font = "Arial"
is_bold = true
is_italic = false
height = 12.0
tolerance = 0.0
z_position = 1.0
is_filled = true
depth = 5.0
success = entities.add_3d_text(string, align, font, is_bold, is_italic, height, tolerance, z_position, is_filled, depth)

