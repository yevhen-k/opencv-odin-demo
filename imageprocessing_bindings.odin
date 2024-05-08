package imageprocessing

import "core:c"

// when ODIN_OS == .Linux do foreign import cv "imageprocessing.a"
when ODIN_OS == .Linux do foreign import cv "libimageprocessing.so"

Mat :: distinct rawptr
VideoCapture :: distinct rawptr


ImageReadModes :: enum c.int {
	IMREAD_UNCHANGED           = -1, //!< If set, return the loaded image as is (with alpha channel,
	//!< otherwise it gets cropped). Ignore EXIF orientation.
	IMREAD_GRAYSCALE           = 0, //!< If set, always convert image to the single channel
	//!< grayscale image (codec internal conversion).
	IMREAD_COLOR               = 1, //!< If set, always convert image to the 3 channel BGR color image.
	IMREAD_ANYDEPTH            = 2, //!< If set, return 16-bit/32-bit image when the input has the
	//!< corresponding depth, otherwise convert it to 8-bit.
	IMREAD_ANYCOLOR            = 4, //!< If set, the image is read in any possible color format.
	IMREAD_LOAD_GDAL           = 8, //!< If set, use the gdal driver for loading the image.
	IMREAD_REDUCED_GRAYSCALE_2 = 16, //!< If set, always convert image to the single channel grayscale
	//!< image and the image size reduced 1/2.
	IMREAD_REDUCED_COLOR_2     = 17, //!< If set, always convert image to the 3 channel BGR color image
	//!< and the image size reduced 1/2.
	IMREAD_REDUCED_GRAYSCALE_4 = 32, //!< If set, always convert image to the single channel grayscale
	//!< image and the image size reduced 1/4.
	IMREAD_REDUCED_COLOR_4     = 33, //!< If set, always convert image to the 3 channel BGR color image
	//!< and the image size reduced 1/4.
	IMREAD_REDUCED_GRAYSCALE_8 = 64, //!< If set, always convert image to the single channel grayscale
	//!< image and the image size reduced 1/8.
	IMREAD_REDUCED_COLOR_8     = 65, //!< If set, always convert image to the 3 channel BGR color image
	//!< and the image size reduced 1/8.
	IMREAD_IGNORE_ORIENTATION  = 128, //!< If set, do not rotate the image
	//!< according to EXIF's orientation flag.
}

VideoCaptureAPIs :: enum c.int {
	CAP_ANY           = 0, //!< Auto detect == 0
	CAP_VFW           = 200, //!< Video For Windows (obsolete, removed)
	CAP_V4L           = 200, //!< V4L/V4L2 capturing support
	CAP_V4L2          = CAP_V4L, //!< Same as CAP_V4L
	CAP_FIREWIRE      = 300, //!< IEEE 1394 drivers
	CAP_FIREWARE      = CAP_FIREWIRE, //!< Same value as CAP_FIREWIRE
	CAP_IEEE1394      = CAP_FIREWIRE, //!< Same value as CAP_FIREWIRE
	CAP_DC1394        = CAP_FIREWIRE, //!< Same value as CAP_FIREWIRE
	CAP_CMU1394       = CAP_FIREWIRE, //!< Same value as CAP_FIREWIRE
	CAP_QT            = 500, //!< QuickTime (obsolete, removed)
	CAP_UNICAP        = 600, //!< Unicap drivers (obsolete, removed)
	CAP_DSHOW         = 700, //!< DirectShow (via videoInput)
	CAP_PVAPI         = 800, //!< PvAPI, Prosilica GigE SDK
	CAP_OPENNI        = 900, //!< OpenNI (for Kinect)
	CAP_OPENNI_ASUS   = 910, //!< OpenNI (for Asus Xtion)
	CAP_ANDROID       = 1000, //!< MediaNDK (API Level 21+) and NDK Camera (API level 24+) for Android
	CAP_XIAPI         = 1100, //!< XIMEA Camera API
	CAP_AVFOUNDATION  = 1200, //!< AVFoundation framework for iOS (OS X Lion will have the same API)
	CAP_GIGANETIX     = 1300, //!< Smartek Giganetix GigEVisionSDK
	CAP_MSMF          = 1400, //!< Microsoft Media Foundation (via videoInput). See platform specific notes above.
	CAP_WINRT         = 1410, //!< Microsoft Windows Runtime using Media Foundation
	CAP_INTELPERC     = 1500, //!< RealSense (former Intel Perceptual Computing SDK)
	CAP_REALSENSE     = 1500, //!< Synonym for CAP_INTELPERC
	CAP_OPENNI2       = 1600, //!< OpenNI2 (for Kinect)
	CAP_OPENNI2_ASUS  = 1610, //!< OpenNI2 (for Asus Xtion and Occipital Structure sensors)
	CAP_OPENNI2_ASTRA = 1620, //!< OpenNI2 (for Orbbec Astra)
	CAP_GPHOTO2       = 1700, //!< gPhoto2 connection
	CAP_GSTREAMER     = 1800, //!< GStreamer
	CAP_FFMPEG        = 1900, //!< Open and record video file or stream using the FFMPEG library
	CAP_IMAGES        = 2000, //!< OpenCV Image Sequence (e.g. img_%02d.jpg)
	CAP_ARAVIS        = 2100, //!< Aravis SDK
	CAP_OPENCV_MJPEG  = 2200, //!< Built-in OpenCV MotionJPEG codec
	CAP_INTEL_MFX     = 2300, //!< Intel MediaSDK
	CAP_XINE          = 2400, //!< XINE engine (Linux)
	CAP_UEYE          = 2500, //!< uEye Camera API
	CAP_OBSENSOR      = 2600, //!< For Orbbec 3D-Sensor device/module (Astra+, Femto, Astra2, Gemini2, Gemini2L, Gemini2XL, Femto Mega) attention: Astra2, Gemini2, and Gemini2L cameras currently only support Windows and Linux kernel versions no higher than 4.15, and higher versions of Linux kernel may have exceptions.
}

@(default_calling_convention = "c")
foreign cv {
	cv_new_mat :: proc() -> Mat ---
	cv_image_read :: proc(file: cstring, flags: c.int) -> Mat ---
	cv_mat_isempty :: proc(mat: Mat) -> c.bool ---
	cv_named_window :: proc(name: cstring) ---
	cv_image_show :: proc(name: cstring, img: Mat) ---
	cv_wait_key :: proc(delay: c.int) -> c.int ---
	cv_destroy_window :: proc(name: cstring) ---
	cv_image_write :: proc(filename: cstring, img: Mat) -> c.bool ---
	cv_free_mem :: proc(data: rawptr) ---

	cv_new_videocapture :: proc() -> VideoCapture ---
	cv_videocapture_open :: proc(capture: VideoCapture, device_id, api_id: c.int) -> c.bool ---
	cv_videocapture_release :: proc(capture: VideoCapture) ---
	cv_videocapture_isopened :: proc(capture: VideoCapture) -> c.bool ---
	cv_videocapture_read :: proc(capture: VideoCapture, frame: Mat) -> c.bool ---
}
