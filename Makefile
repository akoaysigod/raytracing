NAME=RayTracer
OUTFILE=test.ppm

build:
	swift build

release:
	swift build -c release

clean:
	rm -rf ./.build
	swift build --clean

run:
	./.build/debug/$(NAME) >> $(OUTFILE)
