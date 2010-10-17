# gem building script

echo "Building cvwrapper-gem"
cd cvwrapper-gem
gem build cvwrapper.gemspec
cd ..

echo "Building encrypt-gem"
cd encrypt-gem
gem build encrypt.gemspec
cd ..

echo "Building ruby-opencv"
cd ruby-opencv
ruby ext/extconf.rb
make
cd ..
