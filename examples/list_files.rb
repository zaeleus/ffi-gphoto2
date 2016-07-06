require 'gphoto2'

# List all files

def visit(folder)
  files = folder.files
  puts "#{folder.root? ? "/ (root)" : folder.path} (#{files.size} files)"

  folder.folders.each { |child| visit(child) }
  files.each { |file| puts file.name }

  puts
end

GPhoto2::Camera.first do |camera|
  visit(camera.filesystem)
end
