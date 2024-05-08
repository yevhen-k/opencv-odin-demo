# Experiment with Odin and OpenCV

Building Odin with OpenCV demo.

## Build

### Build static or shared library

```bash
just static
```

```bash
just shared
```

## Build Odin app

```bash
odin build ../opencv-odin-demo -extra-linker-flags:"`pkg-config --libs opencv4` -lstdc++"
```

## Run Odin app
```bash
./opencv-odin-demo
```

## References
1. Binding to C: https://odin-lang.org/news/binding-to-c/
2. Odin build flags: https://gist.github.com/laytan/8dc137336d57b121c368a8f9ccb20a69
3. OpenCV bindings
   1. Go: https://github.com/hybridgroup/gocv
   2. Zig: https://github.com/ryoppippi/zigcv