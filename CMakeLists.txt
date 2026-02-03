cmake_minimum_required(VERSION 3.15)
project(modern-cmake-proj VERSION 1.0.0 LANGUAGES CXX)

# set c++17 globally, which is required for std::optional and std::regex
set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

# Add cmake directory to module path
list(APPEND CMAKE_MODULE_PATH "${CMAKE_CURRENT_SOURCE_DIR}/cmake")

# --- Dependencies ---

option(JSONUTILS_USE_SYSTEM_RAPIDJSON "Use system RapidJSON" OFF)

# Fetch RapidJSON using FetchContent
if(JSONUTILS_USE_SYSTEM_RAPIDJSON)
    # find_package will locate FindRapidJSON.cmake
    # within CMAKE_MODULE_PATH and execute it
    find_package(RapidJSON REQUIRED MODULE)
else()
    include(FetchRapidJSON)
endif()

# --- Target Definition ---

# Create library target
add_library(JSONUtils src/json_utils.cpp)
add_library(JSONUtils::JSONUtils ALIAS JSONUtils)

# Define properties
target_include_directories(JSONUtils
    PUBLIC
        $<INSTALL_INTERFACE:include>
        $<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}/include>
    PRIVATE
        ${CMAKE_CURRENT_SOURCE_DIR}/src
)

# Compiler options
target_compile_options(JSONUtils PRIVATE -Werror)
# set the target JSONUtils c++17 explicitly for std::optional and std::regex
# target_compile_features(JSONUtils PUBLIC cxx_std_17)

# Link libraries
target_link_libraries(JSONUtils
    PUBLIC
        RapidJSON::RapidJSON
)

# --- Installation ---

include(GNUInstallDirs)

# Install the target and export it
install(TARGETS JSONUtils
    EXPORT jsonutils-export
    LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR}
    ARCHIVE DESTINATION ${CMAKE_INSTALL_LIBDIR}
)

# Install the export set
install(EXPORT jsonutils-export
    FILE JSONUtilsTargets.cmake
    NAMESPACE JSONUtils::
    DESTINATION ${CMAKE_INSTALL_LIBDIR}/cmake/JSONUtils
)

# Install public headers
install(DIRECTORY include/
    DESTINATION ${CMAKE_INSTALL_INCLUDEDIR}
)

# Install the Config file
install(FILES
    cmake/JSONUtilsConfig.cmake
    cmake/FindRapidJSON.cmake
    DESTINATION ${CMAKE_INSTALL_LIBDIR}/cmake/JSONUtils
)

# Add test subdirectory
enable_testing()
add_subdirectory(test)

configure_file(
    ${CMAKE_CURRENT_SOURCE_DIR}/cmake/CTestCustom.cmake.in
    ${CMAKE_BINARY_DIR}/CTestCustom.cmake
    @ONLY
)
