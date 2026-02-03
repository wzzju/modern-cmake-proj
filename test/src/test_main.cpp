#include "jsonutils/json_utils.h"

#include <iostream>
#include <string>

int main() {
  std::string url = "test.json";
  auto result = jsonutils::LoadJson(url);
  if (result) {
    std::cout << "Loaded JSON successfully." << std::endl;
  } else {
    std::cout << "Failed to load JSON (expected if file missing)." << std::endl;
  }
  return 0;
}
