# modern-cmake-proj

A modern CMake C++ project example based on "It's Time To Do CMake Right".

## Dependencies

- CMake 3.15+
- RapidJSON 1.0+

## Build

* Fetch RapidJSON

```bash
cmake -S . -B build -DCMAKE_EXPORT_COMPILE_COMMANDS=YES -DCMAKE_BUILD_TYPE=Release -DCMAKE_INSTALL_PREFIX=/tmp/install-test

cmake --build build

ctest -V --test-dir build

cmake --install build
```

* Use system RapidJSON

```bash
cmake -S . -B build -DCMAKE_EXPORT_COMPILE_COMMANDS=YES -DJSONUTILS_USE_SYSTEM_RAPIDJSON=ON -DCMAKE_PREFIX_PATH=/usr/local

cmake --build build

ctest -V --test-dir build

cmake --install build --prefix /tmp/install-test
```

## Reference

* [It's Time To Do CMake Right](https://pabloariasal.github.io/2018/02/19/its-time-to-do-cmake-right/)
