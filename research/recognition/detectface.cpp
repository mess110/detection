#define CV_NO_BACKWARD_COMPATIBILITY

#include "cv.h"
#include "highgui.h"

#include <iostream>
#include <cstdio>

#ifdef _EiC
#define WIN32
#endif

using namespace std;
using namespace cv;

String cascadeName = "haarcascades/haarcascade_frontalface_alt.xml";
void cleanup(CvCapture* capture);
int detectFace( Mat& img, CascadeClassifier& cascade, double scale, int count);

int main( int argc, const char** argv )
{
    CvCapture* capture = 0;

    cvNamedWindow( "result", 1 );

    CascadeClassifier cascade;
    if( !cascade.load( cascadeName ) )
    {
        cerr << "ERROR: Could not load classifier cascade" << endl;
        return -1;
    }

    capture = cvCaptureFromCAM(0);
    if( capture )
    {
        Mat frame, frameCopy;
        int count = 1;
        for(;;)
        {
          IplImage* iplImg = cvQueryFrame( capture );
          frame = iplImg;
          if( frame.empty() )
            break;
          if( iplImg->origin == IPL_ORIGIN_TL )
            frame.copyTo( frameCopy );
          else
            flip( frame, frameCopy, 0 );

          count = detectFace(frame, cascade, 1, count);

          if( waitKey( 10 ) >= 0 ) {
             cleanup(capture);
             break;
          }
        }
    }
    cvDestroyWindow("result");
    return 0;
}

int detectFace( Mat& img, CascadeClassifier& cascade, double scale, int count)
{
    int i = 0;
    double t = 0;
    vector<Rect> faces;
    Mat gray, smallImg( cvRound (img.rows/scale), cvRound(img.cols/scale), CV_8UC1 );

    cvtColor( img, gray, CV_BGR2GRAY );
    resize( gray, smallImg, smallImg.size(), 0, 0, INTER_LINEAR );
    equalizeHist( smallImg, smallImg );

    cascade.detectMultiScale( smallImg, faces,
        1.1, 2, 0 |CV_HAAR_FIND_BIGGEST_OBJECT, Size(80, 80) );

    Mat smallImgROI;
    if (faces.size() == 1)
    {
        //get the face
        smallImgROI = smallImg(*faces.begin());
        IplImage *imageProcessed;
        imageProcessed = cvCreateImage(cvSize(92, 112), IPL_DEPTH_8U, 1);
        Mat dst(imageProcessed);
        //resize
        cv::resize(smallImgROI, dst, dst.size(), 0, 0, INTER_LINEAR);
        //equalize
        cv::equalizeHist( dst, dst );

        char buffer[128];
        snprintf(buffer, sizeof(buffer), "people/%d%s", count, ".pgm");
        std::cout << buffer << std::endl;
        cv::imwrite(buffer, dst);
        cv::imshow( "result", dst );
        sleep( 0.5 );
        count++;
    }
    return count;
}

void cleanup(CvCapture* capture)
{
  cvReleaseCapture( &capture );
}
