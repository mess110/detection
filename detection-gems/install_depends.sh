# cvwrapper
ruby depends.rb cvwrapper
if [ $? -eq 1 ];then
  echo "Building and installing cvwrapper-gem"
  cd cvwrapper-gem
  gem build cvwrapper.gemspec
  sudo gem install cvwrapper-0.0.1.gem
  cd ..
else
  echo "cvwrapper gem is already installed"
fi

# encrypt
ruby depends.rb encrypt
if [ $? -eq 1 ];then
  echo "Building and installing encrypt-gem"
  cd encrypt-gem
  gem build encrypt.gemspec
  sudo gem install encrypt-0.0.1.
  cd ..
else
  echo "encrypt gem is already installed"
fi

# opencv
ruby depends.rb opencv
if [ $? -eq 1 ];then
  echo "Building ruby-opencv"
  cd ruby-opencv
  ruby ext/extconf.rb
  make
  sudo make install
  cd ..
else
  echo "ruby-opencv is already installed"
fi

echo 'Done.'
