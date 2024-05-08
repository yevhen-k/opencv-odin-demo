package imageprocessing

import "core:c"
import "core:fmt"
import "core:os"


demo_read_image :: proc() {
	image_path :: "opencv-odin/c_wrapper/4838856.png"
	image := cv_image_read(image_path, cast(c.int)(ImageReadModes.IMREAD_COLOR))
	defer cv_free_mem(image)

	if cv_mat_isempty(image) {
		fmt.eprintfln("Error: can't find or open an image: %s", image_path)
		os.exit(1)
	}

	window_name :: "The Image"
	cv_named_window(window_name)
	defer cv_destroy_window(window_name)

	cv_image_show(window_name, image)
	cv_wait_key(0)
}

demo_read_camera :: proc() {
	// https://docs.opencv.org/4.x/d8/dfe/classcv_1_1VideoCapture.html

	frame := cv_new_mat()
	defer cv_free_mem(frame)

	capture := cv_new_videocapture()
	defer {
		cv_videocapture_release(capture)
		cv_free_mem(capture)
	}

	device_id: c.int = 0
	api_id: c.int = cast(c.int)VideoCaptureAPIs.CAP_ANY

	cv_videocapture_open(capture, device_id, api_id)

	window_name :: "Camera Video"
	cv_named_window(window_name)
	defer cv_destroy_window(window_name)

	if !cv_videocapture_isopened(capture) {
		fmt.eprintfln(
			"Error: can't open camera stream for device_id=%d and api_id=%d",
			device_id,
			api_id,
		)
		os.exit(1)
	}

	fmt.println(">>> Reading frames...")
	for {
		cv_videocapture_read(capture, frame)
		if cv_mat_isempty(frame) {
			fmt.eprintln("Error: empty frame... exiting")
			break
		}
		cv_image_show(window_name, frame)
		c := cv_wait_key(25)
		if c == 27 { 	// ESC key pressed
			break
		}
	}

}

main :: proc() {
	fmt.println(">>> OpenCV Odin Started...")
	// demo_read_image()
	demo_read_camera()

	fmt.println(">>> OpenCV Odin Ended...")
}
