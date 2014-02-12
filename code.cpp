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

	Mat colored = imread("original.jpg",1);
	if (!colored.data)
	{
		printf("cvLoadImage failed!\n");
		return 0;
	}


	Mat labels(colored.size(), CV_32SC1); // Mat doesn't support 32-bit unsigned directly, but this should work fine just to hold data.
	
	vl_slic_segment(labels.ptr<vl_uint32>(),(const float *)(colored),colored.cols,colored.rows,colored.channels(),100,0.3,50);
/*	Size s = labels.size();
	int rows = s.height;
	int cols = s.width;
	int found, val;
	cout << rows << " " << cols << endl;
	Mat superpixel = Mat::ones(colored.size(), CV_32SC1);
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
					break;
				}
			}
		}
	}
	imwrite( "superpixel.jpg", superpixel);*/
}
