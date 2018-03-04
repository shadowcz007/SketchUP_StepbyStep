model = Sketchup.active_model
entities = model.active_entities

sel = model.selection

sel.each do |s|
 name=s.typename
  if name=='Face'
     puts 'Face'
     puts s.vertices
  else
     puts 'Verticrs'
  end
end





#

x=1
unless x>2
   puts "x 小于 2"
 else
  puts "x 大于 2"
end


x=1
if x<2
   puts "x 小于 2"
 else
  puts "x 大于 2"
end
