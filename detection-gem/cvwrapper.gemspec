Gem::Specification.new do |spec|
   spec.name = 'cvwrapper'
   spec.version ='0.0.1'

   # this is important - it specifies which files to include in the gem.
   spec.files = [
      "lib/cvwrapper.rb",
      "lib/data.rb",
      "data/haarcascade_frontalface_alt_tree.xml",
      "data/haarcascade_frontalface_alt.xml",
      "data/haarcascade_frontalface_default.xml",
      "README"
   ]

   # optional, but useful to your users
   spec.summary = 'Wrapping the OpenCV gem to suit my needs. Creating a simple API for it'
   spec.author = 'Cristian Mircea Messel'
   spec.email = 'mess110@gmail.com'
   spec.homepage = 'http://blog.welcome-to-the-world.com'

   # you did document with RDoc, right?
   spec.has_rdoc = false
 end
