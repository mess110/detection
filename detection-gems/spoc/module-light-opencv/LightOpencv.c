// Include the Ruby headers and goodies
#include "ruby.h"

#include "cv.h"
#include "highgui.h"

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <assert.h>
#include <math.h>
#include <float.h>
#include <limits.h>
#include <time.h>
#include <ctype.h>

VALUE LightOpencv = Qnil;
void Init_light_opencv();
VALUE method_detect(VALUE self, VALUE filename, VALUE cascade_path);

//const char* cascade_name = "haarcascade_frontalface_alt_tree.xml";

void Init_light_opencv() {
	  LightOpencv = rb_define_module("LightOpencv");
    rb_define_method(LightOpencv, "detect", method_detect, 2);
}

VALUE method_detect(VALUE self, VALUE filename, VALUE cascade_path) {
    VALUE ary = rb_ary_new();
    IplImage *img = cvLoadImage(StringValuePtr(filename),1);
    if (!img)
    {
      fprintf(stderr, "ERROR: Could not load image\n");
      return ary;
    }
    static CvMemStorage* storage = 0;
    static CvHaarClassifierCascade* cascade = 0;
    int scale = 1;
    int i;
    cascade = (CvHaarClassifierCascade*)cvLoad( StringValuePtr(cascade_path), 0, 0, 0 );

    if( !cascade )
    {
        fprintf( stderr, "ERROR: Could not load classifier cascade\n" );
        return ary;
    }

    storage = cvCreateMemStorage(0);
    cvClearMemStorage( storage );

    CvSeq* faces = cvHaarDetectObjects( img, cascade, storage,
                                        1.1, 2, CV_HAAR_DO_CANNY_PRUNING,
                                        cvSize(40, 40) );
    for( i = 0; i < (faces ? faces->total : 0); i++ )
    {
        CvRect* r = (CvRect*)cvGetSeqElem( faces, i );
        rb_ary_push(ary, INT2NUM(r->x*scale));             // pt1.x
        rb_ary_push(ary, INT2NUM((r->x+r->width)*scale));  // pt2.x
        rb_ary_push(ary, INT2NUM(r->y*scale));             // pt1.y
        rb_ary_push(ary, INT2NUM((r->y+r->height)*scale)); // pt2.y
    }
    cvReleaseImage( &img );
    return ary;
}

