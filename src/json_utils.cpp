#include "jsonutils/json_utils.h"

#include <fstream>
#include <iostream>
#include <optional>
#include <regex>
#include <sstream>
#include <string>

#include <rapidjson/document.h>

#include "file_utils.h"

namespace jsonutils {

bool FileExists(const std::string& path) {
  std::ifstream f(path.c_str());
  return f.good();
}

std::optional<rapidjson::Document> LoadJson(const std::string& url) {
  // Check if it looks like a URL
  std::regex url_regex("http(s)?://.*");
  if (std::regex_match(url, url_regex)) {
    // In a real implementation, we would use a HTTP client here.
    // For now, we just print a message and return empty.
    std::cerr << "URL loading not implemented: " << url << std::endl;
    return std::nullopt;
  }

  // Assume it's a file
  if (!FileExists(url)) {
    std::cerr << "File not found: " << url << std::endl;
    return std::nullopt;
  }

  std::ifstream t(url);
  std::stringstream buffer;
  buffer << t.rdbuf();
  std::string content = buffer.str();

  rapidjson::Document d;
  if (d.Parse(content.c_str()).HasParseError()) {
    std::cerr << "JSON parse error" << std::endl;
    return std::nullopt;
  }

  return d;
}

}  // namespace jsonutils
