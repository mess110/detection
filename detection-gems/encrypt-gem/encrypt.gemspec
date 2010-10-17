Gem::Specification.new do |spec|
   spec.name = 'encrypt'
   spec.version ='0.0.1'

   # this is important - it specifies which files to include in the gem.
   spec.files = [
      "lib/encrypt.rb",
      "app.rb",
      "README"
   ]

   # optional, but useful to your users
   spec.summary = 'Encryption of strings for passwords.'
   spec.author = 'Cristian Mircea Messel'
   spec.email = 'mess110@gmail.com'
   spec.homepage = 'http://blog.welcome-to-the-world.com'

   # you did document with RDoc, right?
   spec.has_rdoc = false
 end
