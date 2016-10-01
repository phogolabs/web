Dir.glob('./app/{helpers,controllers}/*.rb').each do |filename|
  require filename
end
