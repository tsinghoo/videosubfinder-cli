
mkdir -p /tmp/work 

#function comment(){
  apt install -y git cmake wget libtbb-dev \
  libavcodec-dev libgtk-3-dev libavformat-dev libswscale-dev libavfilter-dev build-essential 
      
 cd /tmp/work 
 git clone https://github.com/wxWidgets/wxWidgets.git 
 cd wxWidgets/ 
 git checkout v3.2.2.1 
 git submodule update --init --recursive 
 mkdir buildgtk 
 cd buildgtk/ 
 ../configure --disable-gui 
 make -j$(nproc) 
 make install 
 read -p "Press Enter to conitnue"
 rm -rf /tmp/work/wxWidgets

 cd /tmp/work 
 git clone https://github.com/opencv/opencv.git -b 4.8.0 --depth=1 
 cd opencv 
 mkdir -p build 
 cd build 
 cmake -DCMAKE_BUILD_TYPE=Release  -DWITH_GTK=OFF -DWITH_FFMPEG=ON -D CMAKE_BUILD_TYPE=RELEASE \
    -D CMAKE_INSTALL_PREFIX=/usr/local   -D WITH_TBB=ON -D WITH_V4L=ON -D WITH_OPENGL=ON \
    -D WITH_CUBLAS=ON -DWITH_QT=OFF -DCUDA_NVCC_FLAGS="-D_FORCE_INLINES" .. 
 cmake --build . --config Release -j $(nproc) 
 make install 

#}

read -p "press Enter to continue"

rm -rf /tmp/work/opencv

read -p "press Enter to continue"


cp -rf . /tmp/work/videosubfinder-src
cd /tmp/work/videosubfinder-src 
cp -rf ./Build/Linux_x64/* /tmp/work/ 
mkdir /tmp/work/settings && cp -rf ./Settings/general.cfg /tmp/work/settings/ 
rm -rf linux_build 
mkdir -p linux_build 
cd linux_build/ 

cmake -DCMAKE_BUILD_TYPE=Release -DUSE_CUDA=OFF .. 

read -p "press Enter to continue"

cmake --build . --config Release -j $(nproc) 

read -p "press Enter to continue"

cp ./Interfaces/VideoSubFinderCli/VideoSubFinderCli /tmp/work/ 
rm -rf /tmp/work/videosubfinder-src
cp -L /usr/local/lib/libwx_baseu-?.?.so.? \
          /usr/local/lib/libopencv_videoio.so.??? \
          /usr/local/lib/libopencv_core.so.??? \
          /usr/local/lib/libopencv_imgproc.so.??? \
          /usr/local/lib/libopencv_imgcodecs.so.??? \
          /tmp/work/

echo "ls /tmp/work"
ls /tmp/work

