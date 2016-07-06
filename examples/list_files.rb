require 'gphoto2'

# List all files in tree form.

def visit(folder, level = 0)
  indent = '  ' * level

  files = folder.files
  puts "#{indent}#{folder.root? ? "/ (root)" : folder.path} (#{files.size} files)"

  folder.folders.each { |child| visit(child, level + 1) }
  indent << '  '

  puts "#{indent}#{files.map(&:name).join(' , ')}"
end

GPhoto2::Camera.first do |camera|
  visit(camera.filesystem)
end
