http://stackoverflow.com/questions/12335848/opencv-program-compile-error-libopencv-core-so-2-4-cannot-open-shared-object-f
http://askubuntu.com/questions/165027/why-cant-my-program-find-the-libraries-in-usr-local-lib

```
pkg-config --cflags opencv
pkg-config --libs opencv
```

Histoire de compiler les dépendances
--------------------------------------------------

Le tutoriel sur Debian est très bien, changer la ligne de make en 

``cmake -D CMAKE_BUILD_TYPE=Release -D CMAKE_INSTALL_PREFIX=/usr/local -DWITH_QT=ON -DWITH_OPENGL=ON -DFORCE_VTK=ON -DWITH_TBB=ON -DWITH_GDAL=ON -DWITH_XINE=ON -DBUILD_EXAMPLES=ON  ..`` surtout avec ``-D CMAKE_BUILD_TYPE=Release -D CMAKE_INSTALL_PREFIX=/usr/local`` il faut qu'on sache où se situe la librairie... qui est en fait dans /usr/local/lib !!!

### Petit truc sur FFMPEG
Peut marcher sans ffmpeg mais traitement vidéo limité, pour bien s'assurer, suivre les instructions d'installation du manuel.

---


Prérequis :
-----------------------

``/etc/environnement`` :
``PATH="/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games````:/usr/local/lib:usr/local"``


Puis reboot, ou bien faire

PATH="/usr/local/lib:usr/local:$PATH"
export PATH

LD_LIBRARY_PATH="/lib:/usr/lib:/usr/local/lib"
export LD_LIBRARY_PATH


dans le ``.profile`` au niveau local et faire un ``source``

Compilation du programme :
-----------------------------------------

Si il y a un message qui dit qu'il n'arrive pas à trouver l'environnement ``OpenCV_DIR`` et que ``OpenCV_FOUND`` est mis sur ``FALSE``, ça veut dire que le shell pointe vers la mauvaise location de OpenCV (ancienne installation ou autre) il faut donc enlever l'installation fautive. Puis retenter et cela devrait être bon.

S'il y a erreur lors du cmake à cause du message suivant : 

````

                 from /usr/local/include/opencv2/core.hpp:54,
                 from /usr/local/include/opencv2/highgui.hpp:46,
                 from /usr/local/include/opencv2/highgui/highgui.hpp:48,
                 from /home/pop/dossier_de_test/opencv1/DisplayImage.cpp:1:
/usr/include/c++/5/bits/stringfwd.h:74:33: note:   ‘std::__cxx11::string’
   typedef basic_string<char>    string;   
                                 ^
/usr/include/c++/5/bits/stringfwd.h:74:33: note:   ‘std::__cxx11::string’
CMakeFiles/DisplayImage.dir/build.make:54: recipe for target 'CMakeFiles/DisplayImage.dir/DisplayImage.cpp.o' failed
make[2]: *** [CMakeFiles/DisplayImage.dir/DisplayImage.cpp.o] Error 1
CMakeFiles/Makefile2:60: recipe for target 'CMakeFiles/DisplayImage.dir/all' failed
make[1]: *** [CMakeFiles/DisplayImage.dir/all] Error 2
Makefile:75: recipe for target 'all' failed
make: *** [all] Error 2
pop@POP2012:~/dossier_de_test/opencv1$ ./DisplayImage sardiche.ts 
terminate called after throwing an instance of 'std::out_of_range'
  what():  basic_string::substr: __pos (which is 140) > this->size() (which is 2)
Abandon (core dumped)
pop@POP2012:~/dossier_
````

Il faut que le script ait un main obligatoire!!!

```
int main( int argc, char** argv ) {
    ...
}
```

http://stackoverflow.com/questions/8628051/cmake-undefined-reference-to-main
http://stackoverflow.com/questions/23922620/open-cv-not-loading-correctly

------

Supprimer/Détécter openCV : 

```
sudo find /usr/local/lib/ -name "*opencv*" -exec echo {} \;
```

Plusieurs versions de OpenCV et CMAKING : 

http://answers.opencv.org/question/65178/install-multiple-versions-of-opencv-on-ubuntu/
http://code.litomisky.com/2014/03/09/how-to-have-multiple-versions-of-the-same-library-side-by-side/

Script installation Debian
-----------------------

https://github.com/milq/scripts-ubuntu-debian/blob/master/install-opencv.sh

Compilation installation de ffmpeg
-------------------------------

./configure --enable-shared
sudo make install

```
cmake -D CMAKE_BUILD_TYPE=Release -D CMAKE_INSTALL_PREFIX=/usr/local -DOPENCV_EXTRA_MODULES_PATH=../../opencv_contrib/modules -DWITH_QT=ON -DWITH_OPENGL=ON -DFORCE_VTK=ON -DWITH_TBB=ON -DWITH_GDAL=ON -DWITH_XINE=ON -DBUILD_EXAMPLES=ON  .. && make -j5 && sudo make install && sudo ldconfig
```

http://opencv.org/documentation.html

https://www.google.com/search?q=cmakelists+include+headers&oq=cmakelists+include+headers&aqs=chrome..69i57j69i60j0l4.5667j0j4&client=ubuntu&sourceid=chrome&ie=UTF-8

OpenGL Warning: glXGetFBConfigAttrib for 096f82b0, failed to get XVisualInfo
-------------------------------------------------

https://text.sourcegraph.com/code-usage-examples-in-your-editor-as-you-type-f7fc89d894dd#.62u34359x

http://stackoverflow.com/questions/14743389/using-opencv-to-match-an-image-from-a-group-of-images-for-purpose-of-identificat

http://docs.opencv.org/2.4/doc/tutorials/features2d/feature_flann_matcher/feature_flann_matcher.html

http://docs.opencv.org/2.4/modules/stitching/doc/matching.html

----

INSTALLER openCV nonfree pour supporter SURF, SITD et le reste en 3.0.0 (finalement switché sous 2.4.9)
``-DOPENCV_EXTRA_MODULES_PATH=../../opencv_contrib/modules ``


Link les librairies manquantes si on installe un framework dans un endroit spécifique!

libopencv_features2d.so     -->         -lopencv_features2d

http://stackoverflow.com/questions/12335848/opencv-program-compile-error-libopencv-core-so-2-4-cannot-open-shared-object-f


VERSION 32 bits

sudo apt-get install g++-4.8-multilib

sudo apt-get install gcc-multilib g++-multilib