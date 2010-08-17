Gem::Specification.new do |spec|
   spec.name = 'detection'
   spec.version ='0.1.0'

   # this is important - it specifies which files to include in the gem.
   spec.files = [
      "lib/detection.rb",
   ]

   # optional, but useful to your users
   spec.summary = "FaceDetection API consumer"
   spec.author = 'Cristian Mircea Messel'
   spec.email = 'mess110@gmail.com'
   spec.homepage = 'http://detection.myvhost.de/'

   # you did document with RDoc, right?
   spec.has_rdoc = false

   # if you have any dependencies on other gems, list them thusly
   # spec.add_dependency('lalala')
   spec.add_dependency('httparty', '>= 0.6.1')
 end
