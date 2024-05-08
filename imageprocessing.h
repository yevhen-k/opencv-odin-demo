#ifndef IMPROC_H
#define IMPROC_H
#include <stdbool.h>

typedef void *Mat;
typedef void *VideoCapture;

#ifdef __cplusplus
extern "C" {
#endif

//! Imread flags
enum ImageReadModes {
  IMREAD_UNCHANGED =
      -1, //!< If set, return the loaded image as is (with alpha channel,
          //!< otherwise it gets cropped). Ignore EXIF orientation.
  IMREAD_GRAYSCALE = 0, //!< If set, always convert image to the single channel
                        //!< grayscale image (codec internal conversion).
  IMREAD_COLOR =
      1, //!< If set, always convert image to the 3 channel BGR color image.
  IMREAD_ANYDEPTH =
      2, //!< If set, return 16-bit/32-bit image when the input has the
         //!< corresponding depth, otherwise convert it to 8-bit.
  IMREAD_ANYCOLOR =
      4, //!< If set, the image is read in any possible color format.
  IMREAD_LOAD_GDAL = 8, //!< If set, use the gdal driver for loading the image.
  IMREAD_REDUCED_GRAYSCALE_2 =
      16, //!< If set, always convert image to the single channel grayscale
          //!< image and the image size reduced 1/2.
  IMREAD_REDUCED_COLOR_2 =
      17, //!< If set, always convert image to the 3 channel BGR color image
          //!< and the image size reduced 1/2.
  IMREAD_REDUCED_GRAYSCALE_4 =
      32, //!< If set, always convert image to the single channel grayscale
          //!< image and the image size reduced 1/4.
  IMREAD_REDUCED_COLOR_4 =
      33, //!< If set, always convert image to the 3 channel BGR color image
          //!< and the image size reduced 1/4.
  IMREAD_REDUCED_GRAYSCALE_8 =
      64, //!< If set, always convert image to the single channel grayscale
          //!< image and the image size reduced 1/8.
  IMREAD_REDUCED_COLOR_8 =
      65, //!< If set, always convert image to the 3 channel BGR color image
          //!< and the image size reduced 1/8.
  IMREAD_IGNORE_ORIENTATION = 128 //!< If set, do not rotate the image
                                  //!< according to EXIF's orientation flag.
};

Mat cv_new_mat();

Mat cv_image_read(const char *file, int flags);

bool cv_mat_isempty(Mat mat);

void cv_named_window(const char *name);

void cv_image_show(const char *name, Mat img);

int cv_wait_key(int delay);

void cv_destroy_window(const char *name);

bool cv_image_write(const char *filename, Mat img);

void cv_free_mem(void *data);

VideoCapture cv_new_videocapture();

bool cv_videocapture_open(VideoCapture cap, int device_id, int api_id);

void cv_videocapture_release(VideoCapture cap);

bool cv_videocapture_isopened(VideoCapture cap);

bool cv_videocapture_read(VideoCapture cap, Mat frame);

#ifdef __cplusplus
}
#endif

#endif