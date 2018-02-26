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
