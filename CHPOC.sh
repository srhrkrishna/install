sudo apt-get update;
sudo apt-get -y install apache2 git python-django python-djangorestframework python-pip libapache2-mod-wsgi keystone;
sudo pip install django-cors-headers django-rest-swagger;

sudo git clone https://github.com/srhrkrishna/CHPOC.git; 
cd CHPOC; 
sudo python manage.py syncdb --noinput; 
sudo cp apache_conf.txt /etc/apache2/apache2.conf;

cd ~/;
mkdir files; 
chmod 777 files;
sudo service apache2 restart;

sudo apt-get -y --force-yes install autoconf automake build-essential libass-dev libfreetype6-dev libgpac-dev libsdl1.2-dev libtheora-dev libtool libva-dev libvdpau-dev libvorbis-dev libxcb1-dev libxcb-shm0-dev libxcb-xfixes0-dev pkg-config texi2html zlib1g-dev libx264-dev cmake mercurial unzip libmp3lame-dev libopus-dev libfaac-dev;


mkdir ~/ffmpeg_sources;
cd ~/ffmpeg_sources;
hg clone https://bitbucket.org/multicoreware/x265;
cd ~/ffmpeg_sources/x265/build/linux;
PATH="$HOME/bin:$PATH" cmake -G "Unix Makefiles" -DCMAKE_INSTALL_PREFIX="$HOME/ffmpeg_build" -DENABLE_SHARED:bool=off ../../source;
make;
make install;
make distclean;

cd ~/ffmpeg_sources;
wget -O fdk-aac.zip https://github.com/mstorsjo/fdk-aac/zipball/master;
unzip fdk-aac.zip;
cd mstorsjo-fdk-aac*;
autoreconf -fiv;
./configure --prefix="$HOME/ffmpeg_build" --disable-shared;
make;
make install;
make distclean;

cd ~/ffmpeg_sources;
wget http://ffmpeg.org/releases/ffmpeg-snapshot.tar.bz2;
tar xjvf ffmpeg-snapshot.tar.bz2;
cd ffmpeg;
PATH="$HOME/bin:$PATH" PKG_CONFIG_PATH="$HOME/ffmpeg_build/lib/pkgconfig" ./configure \
--prefix="$HOME/ffmpeg_build" \
--pkg-config-flags="--static" \
--extra-cflags="-I$HOME/ffmpeg_build/include" \
--extra-ldflags="-L$HOME/ffmpeg_build/lib" \
--bindir="$HOME/bin" \
--enable-gpl \
--enable-libass \
--enable-libfdk-aac \
--enable-libfreetype \
--enable-libmp3lame \
--enable-libopus \
--enable-libtheora \
--enable-libvorbis \
--enable-libx264 \
--enable-libx265 \
--enable-nonfree \
--disable-yasm;
PATH="$HOME/bin:$PATH"; make;
make install;
make distclean;
hash -r;


source ~/.profile;
sudo mkdir /usr/local/bin/avi_to_mp4; sudo cp ~/CHPOC/Avit_to_MP4/avi_to_mp4.py /usr/local/bin/avi_to_mp4/avi_to_mp4.py; sudo chmod 755 /usr/local/bin/avi_to_mp4/avi_to_mp4.py;

sudo cp ~/CHPOC/Avit_to_MP4/avi_to_mp4.sh /etc/init.d/; sudo chmod 755 /etc/init.d/avi_to_mp4.sh;

sudo /etc/init.d/avi_to_mp4.sh start;