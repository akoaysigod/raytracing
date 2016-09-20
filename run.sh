#!/bin/bash
./.build/release/RayTracingWeekend 1 4 > p1.ppm& 
./.build/release/RayTracingWeekend 2 4 > p2.ppm&
./.build/release/RayTracingWeekend 3 4 > p3.ppm&
./.build/release/RayTracingWeekend 4 4 > p4.ppm&
wait
echo p1.ppm > test.ppm 
echo p2.ppm >> test.ppm 
echo p3.ppm >> test.ppm 
echo p4.ppm >> test.ppm 

