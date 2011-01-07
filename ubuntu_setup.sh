DETECTION_DIRECTORY=$(cd `dirname $0` && pwd)

# installing dependecies
sudo apt-get install git subversion cmake build-essential libgtk2.0-dev libjpeg8-dev pkg-config

# setting up opencv
cd ~/Public
mkdir opencv
cd opencv
svn co https://opencvlibrary.svn.sourceforge.net/svnroot/opencvlibrary/tags/latest_tested_snapshot
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
cd detection-gems/light-opencv-wrapper
sh install.sh

# installing runner
sudo apt-get install postgresql-8.4 pgadmin3 libpq-dev

sudo gem install bundler
cd $DETECTION_DIRECTORY
cd detection-runner
sudo bundle install
