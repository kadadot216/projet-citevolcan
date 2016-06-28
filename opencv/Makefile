CPP = g++

# OpenCV 2.4.9
CPPFLAGS = -I/home/$(USER)/bin/opencv249/include/opencv \
	-I/home/$(USER)/bin/opencv249/include/opencv2 \
	-I/home/$(USER)/bin/opencv249/include 

MORE = -I/usr/include/c++/4.9

LIBLINKS = -L/home/$(USER)/bin/opencv249/lib

# Pour nonfree
LINKERS = -lopencv_core \
	-lopencv_imgproc \
	-lopencv_highgui \
	-lopencv_nonfree \
	-lopencv_features2d \

all: match_img debug #mon_programme32 

match_img: main.cpp
	$(CPP) $(CPPFLAGS) $(LIBLINKS) $^ -o $@ $(LINKERS)

debug: SURF_original.cpp
		$(CPP) $(CPPFLAGS) $(LIBLINKS) $^ -o $@ $(LINKERS)

mon_programme32: main.cpp
	$(CPP) -m32 $(MORE) $(CPPFLAGS) $(LIBLINKS) $^ -o $@ $(LINKERS)