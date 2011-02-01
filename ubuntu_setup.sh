DETECTION_DIRECTORY=$(cd `dirname $0` && pwd)

# installing dependecies
sudo apt-get update; apt-get upgrade; apt-get install sudo git-core subversion cmake build-essential libgtk2.0-dev libjpeg-dev pkg-config postgresql libpq-dev libopenssl-ruby;

# setting up opencv
cd ~
mkdir opencv
cd opencv
svn co https://code.ros.org/svn/opencv/tags/latest_tested_snapshot
cd latest_tested_snapshot/opencv
mkdir release
cd release
cmake -D CMAKE_BUILD_TYPE=RELEASE -D CMAKE_INSTALL_PREFIX=/usr/local ..
make
sudo make install
sudo ldconfig -v

# installing light plugin
sudo gem install jeweler
cd $DETECTION_DIRECTORY
cd spoc
sh install.sh

cd $DETECTION_DIRECTORY
cd runner
sudo bundle install
