NAME=RayTracer
OUTFILE=test.ppm

build:
	swift build

release:
	swift build -c release

clean:
	rm -rf ./.build
	swift build --clean

runDebug:
	lldb ./.build/debug/$(NAME)

run:
	./.build/debug/$(NAME)
