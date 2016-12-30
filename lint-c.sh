cppcheck .
make -j clean && scan-build make -j
make -j clean && infer -- make -j
