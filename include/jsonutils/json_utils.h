#ifndef MODERN_CMAKE_PROJ_JSONUTILS_JSON_UTILS_H_
#define MODERN_CMAKE_PROJ_JSONUTILS_JSON_UTILS_H_

#include <optional>
#include <string>

#include <rapidjson/document.h>

namespace jsonutils {

// Loads a JSON object from a URL or local file path.
//
// url: The URL or file path.
// Returns the loaded JSON document or std::nullopt on failure.
std::optional<rapidjson::Document> LoadJson(const std::string& url);

}  // namespace jsonutils

#endif  // MODERN_CMAKE_PROJ_JSONUTILS_JSON_UTILS_H_
