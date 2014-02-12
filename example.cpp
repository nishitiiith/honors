extern "C" {
#include </home/orca/Downloads/vlfeat-0.9.17/vl/slic.h>
}
#include <stdio.h>
#include <iostream>
#include <string>
#include <opencv2/opencv.hpp>
#include<opencv/highgui.h>

using namespace std;
using namespace cv;

int main () {

	IplImage* colored = cvLoadImage("original.jpg", CV_LOAD_IMAGE_UNCHANGED);
	if (!colored)
	{
		printf("cvLoadImage failed!\n");
		return 0;
	}

	//  Allocate a new IPL_DEPTH_32F image with the same dimensions as the original
	IplImage* img_32f = cvCreateImage(cvGetSize(colored),IPL_DEPTH_32F,3);
	if (!img_32f)
	{
		printf("cvCreateImage failed!\n");
		return 0;
	}

	cvConvertScale(colored, img_32f);
	//  quantization for 32bit. Without it, this img would not be displayed properly
	cvScale(img_32f, img_32f, 1.0/255);

	Mat floatimg(img_32f);
//	Mat floatimg(colored);

	Mat labels(floatimg.size(), DataType<float>::type); // Mat doesn't support 32-bit unsigned directly, but this should work fine just to hold data.

	vl_slic_segment(labels.ptr<vl_uint32>(),floatimg.ptr<float>(),floatimg.cols,floatimg.rows,floatimg.channels(),100,0.3,1);

	Size s = labels.size();
	int rows = s.height;
	int cols = s.width;
	int found, val;
	cout << rows << " " << cols << endl;
	//Mat superpixel = Mat::ones(floatimg.size(), CV_32SC1);
	Mat superpixel = Mat::ones(floatimg.size(), DataType<int>::type);
	for(int i = 0; i < rows; i++) for(int j = 0; j < cols; j++) superpixel.at<int>(i,j) = 255;
	for(int i = 1; i < rows-1; i++) {
		for(int j = 1; j < cols-1; j++) {
			val = labels.at<int>(i,j);
			found = 0;
			for(int k = i-1; k < i+1 && !found; k++) {
				for(int l = j-1; l < j+1 && !found; l++) {
					if(labels.at<int>(k,l) != val) {
						superpixel.at<int>(i,j) = 0;
						found=1;
					}
				}
			}
		}
	}
	imwrite( "superpixel.jpg", superpixel);
	imwrite( "labels.jpg", labels);
	namedWindow("img_32f", WINDOW_NORMAL);
	imshow("img_32f",floatimg);
	waitKey(0);
}
