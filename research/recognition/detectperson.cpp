#define CV_NO_BACKWARD_COMPATIBILITY

#include "cv.h"
#include "cvaux.h"
#include "highgui.h"

#include <iostream>
#include <cstdio>

#ifdef _EiC
#define WIN32
#endif

using namespace std;
using namespace cv;

int nTrainFaces               = 0;
int nEigens                   = 0;
IplImage ** faceImgArr        = 0;
CvMat    *  personNumTruthMat = 0;
IplImage *  pAvgTrainImg      = 0;
IplImage ** eigenVectArr      = 0;
CvMat    *  eigenValMat       = 0;
CvMat    * projectedTrainFaceMat = 0;
String cascadeName = "haarcascades/haarcascade_frontalface_alt.xml";

int  findNearestNeighbor(float * projectedTestFace);
void cleanup(CvCapture* capture);
int detectFace( Mat& img, CascadeClassifier& cascade, double scale, int count);
void recognize();
int  loadFaceImgArr(char * filename);
int loadTrainingData(CvMat ** pTrainPersonNumMat);
void rec(Mat& img);

int main( int argc, const char** argv )
{
    CvCapture* capture = 0;
    
    cvNamedWindow( "result", 1 );

    // load cascade
    CascadeClassifier cascade;
    if( !cascade.load( cascadeName ) )
    {
        cerr << "ERROR: Could not load classifier cascade" << endl;
        return -1;
    }

    // start capturing
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
        1.1, 2, 0 |CV_HAAR_FIND_BIGGEST_OBJECT, Size(100, 100) );

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
        rec(dst);
        cv::imshow( "result", img );
    }
    count = count++;
    return count;
}

void cleanup(CvCapture* capture)
{
  cvReleaseCapture( &capture );
}

void rec(Mat& face)
{
  int i, nTestFaces  = 0;         // the number of test images
	CvMat * trainPersonNumMat = 0;  // the person numbers during training
	float * projectedTestFace = 0;
	
	if( !loadTrainingData( &trainPersonNumMat ) ) return;
	
	projectedTestFace = (float *)cvAlloc( nEigens*sizeof(float) );
	int iNearest, nearest, truth;
  cv::imwrite("kiki.pgm", face);
  IplImage * sad = cvLoadImage("kiki.pgm", CV_LOAD_IMAGE_GRAYSCALE);
		// project the test image onto the PCA subspace
		cvEigenDecomposite(
			sad,
			nEigens,
			eigenVectArr,
			0, 0,
			pAvgTrainImg,
			projectedTestFace);

		iNearest = findNearestNeighbor(projectedTestFace);
  cout << iNearest << endl;
}

int loadTrainingData(CvMat ** pTrainPersonNumMat)
{
	CvFileStorage * fileStorage;
	int i;

	// create a file-storage interface
	fileStorage = cvOpenFileStorage( "facedata.xml", 0, CV_STORAGE_READ );
	if( !fileStorage )
	{
		fprintf(stderr, "Can't open facedata.xml\n");
		return 0;
	}

	nEigens = cvReadIntByName(fileStorage, 0, "nEigens", 0);
	nTrainFaces = cvReadIntByName(fileStorage, 0, "nTrainFaces", 0);
	*pTrainPersonNumMat = (CvMat *)cvReadByName(fileStorage, 0, "trainPersonNumMat", 0);
	eigenValMat  = (CvMat *)cvReadByName(fileStorage, 0, "eigenValMat", 0);
	projectedTrainFaceMat = (CvMat *)cvReadByName(fileStorage, 0, "projectedTrainFaceMat", 0);
	pAvgTrainImg = (IplImage *)cvReadByName(fileStorage, 0, "avgTrainImg", 0);
	eigenVectArr = (IplImage **)cvAlloc(nTrainFaces*sizeof(IplImage *));
	for(i=0; i<nEigens; i++)
	{
		char varname[200];
		sprintf( varname, "eigenVect_%d", i );
		eigenVectArr[i] = (IplImage *)cvReadByName(fileStorage, 0, varname, 0);
	}

	// release the file-storage interface
	cvReleaseFileStorage( &fileStorage );

	return 1;
}

int findNearestNeighbor(float * projectedTestFace)
{
	//double leastDistSq = 1e12;
	double leastDistSq = DBL_MAX;
	int i, iTrain, iNearest = 0;

	for(iTrain=0; iTrain<nTrainFaces; iTrain++)
	{
		double distSq=0;

		for(i=0; i<nEigens; i++)
		{
			float d_i =
				projectedTestFace[i] -
				projectedTrainFaceMat->data.fl[iTrain*nEigens + i];
			distSq += d_i*d_i / eigenValMat->data.fl[i];  // Mahalanobis
			//distSq += d_i*d_i; // Euclidean
		}

		if(distSq < leastDistSq)
		{
			leastDistSq = distSq;
			iNearest = iTrain;
		}
	}

	return iNearest;
}
