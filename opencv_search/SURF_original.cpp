#include <stdio.h>
#include <iostream>
#include "opencv2/core/core.hpp"
#include <opencv2/legacy/legacy.hpp>
#include <opencv2/nonfree/features2d.hpp>
#include "opencv2/highgui/highgui.hpp"

using namespace cv;
using namespace std;

void readme();

/** @function main */
int main( int argc, char** argv )
{
  if( argc != 3 )
   { return -1; }

  Mat img_1 = imread( argv[1], CV_LOAD_IMAGE_GRAYSCALE );
  Mat img_2 = imread( argv[2], CV_LOAD_IMAGE_GRAYSCALE );

  if( !img_1.data || !img_2.data )
   { return -1; }

  //-- Step 1: Detect the keypoints using SURF Detector
  int minHessian = 400;

  SurfFeatureDetector detector( minHessian );

  vector<KeyPoint> keypoints_1, keypoints_2;

  detector.detect( img_1, keypoints_1 );
  detector.detect( img_2, keypoints_2 );

  //-- Step 2: Calculate descriptors (feature vectors)
  SurfDescriptorExtractor extractor;

  Mat descriptors_1, descriptors_2;

  extractor.compute( img_1, keypoints_1, descriptors_1 );
  extractor.compute( img_2, keypoints_2, descriptors_2 );

  //-- Step 3: Matching descriptor vectors with a brute force matcher
  BruteForceMatcher< L2<float> > matcher;
  vector< DMatch > matches;
  matcher.match( descriptors_1, descriptors_2, matches );
  //-- Draw matches
  Mat img_matches;
  drawMatches( img_1, keypoints_1, img_2, keypoints_2, matches, img_matches );
cout << "keypoint1 : " << keypoints_1.size() << endl;
cout << "keypoint2 : " << keypoints_2.size() << endl;
  //-- Show detected matches
  imshow("Matches", img_matches );

  waitKey(0);

  return 0;
  }

 /** @function readme */
 void readme()
 { cout << " Usage: ./SURF_descriptor <img1> <img2>" << endl; }