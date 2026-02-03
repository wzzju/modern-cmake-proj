get_filename_component(JSONUtils_CMAKE_DIR "${CMAKE_CURRENT_LIST_FILE}" PATH)
include(CMakeFindDependencyMacro)

# find_dependency(Boost 1.55 REQUIRED COMPONENTS regex)

# Depend on RapidJSON headers
list(APPEND CMAKE_MODULE_PATH "${JSONUtils_CMAKE_DIR}")
find_dependency(RapidJSON MODULE)

if(NOT TARGET JSONUtils::JSONUtils)
    include("${JSONUtils_CMAKE_DIR}/JSONUtilsTargets.cmake")
endif()
