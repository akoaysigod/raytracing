#!/bin/bash

for i in {1..20}
do
  ./.build/release/RayTracingWeekend $i 20 > p$i.ppm& 
done
wait

cat p1.ppm > test.ppm 
for i in {1..20}
do 
  cat p$i.ppm >> test.ppm 
done
