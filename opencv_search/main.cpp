#include "opencv2/core/core.hpp"
#include "opencv2/highgui/highgui.hpp"
#include "opencv2/imgproc/imgproc.hpp"

// using namespace cv;

int main(int argc, char const *argv[])
{
    cv::Mat src, dst;
    src = cv::imread("lena.jpg", 1);
    cv::resize(src, dst, cv::Size(100,100));
    cv::imwrite("output.jpg", dst);
    return 0;
}