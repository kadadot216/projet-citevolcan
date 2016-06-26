#include <stdio.h>
#include <iostream>
#include <cstdlib>
#include <cmath>
#include "opencv2/core/core.hpp"
#include <opencv2/legacy/legacy.hpp>
#include <opencv2/nonfree/features2d.hpp>
#include "opencv2/highgui/highgui.hpp"

using namespace cv;
using namespace std;



int main( int argc, char** argv )
{
  if( argc != 3 )
   { return -1; }

  Mat img_1 = imread( argv[1], CV_LOAD_IMAGE_GRAYSCALE );
  Mat img_2 = imread( argv[2], CV_LOAD_IMAGE_GRAYSCALE );

  if( !img_1.data || !img_2.data )
   { return -1; }

  // Détéction de chaque pixel intéressant grâce à SURF
  int minHessian = 400;

  SurfFeatureDetector detector( minHessian );

  vector<KeyPoint> keypoints_1, keypoints_2;

  detector.detect( img_1, keypoints_1 );
  detector.detect( img_2, keypoints_2 );

  // Crée les vecteurs avec chaque point de correspondance
  SurfDescriptorExtractor extractor;

  Mat descriptors_1, descriptors_2;

  extractor.compute( img_1, keypoints_1, descriptors_1 );
  extractor.compute( img_2, keypoints_2, descriptors_2 );

  //Méthode de matching de type BruteForce qui cherche chaque pixel.
  BruteForceMatcher< L2<float> > matcher;
  vector< DMatch > matches;
  matcher.match( descriptors_1, descriptors_2, matches );

// Affiche chaque keypoint ainsi que la différence qui permet de déterminer la possible similitude
// cout << "Keypoints image 1 : " << keypoints_1.size() << endl;
// cout << "Keypoints image 2 : " << keypoints_2.size() << endl;
int diff = abs((int)keypoints_2.size()-(int)keypoints_1.size());
cout <<  diff << endl;

  return 0;
  // return abs((int)keypoints_2.size()-(int)keypoints_1.size());
  }
