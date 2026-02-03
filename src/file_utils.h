#ifndef MODERN_CMAKE_PROJ_SRC_FILE_UTILS_H_
#define MODERN_CMAKE_PROJ_SRC_FILE_UTILS_H_

#include <string>

namespace jsonutils {

// Checks if a file exists at the given path.
bool FileExists(const std::string& path);

}  // namespace jsonutils

#endif  // MODERN_CMAKE_PROJ_SRC_FILE_UTILS_H_
