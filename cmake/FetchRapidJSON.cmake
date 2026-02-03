# Eliminate usage warnings for FetchContent_Populate (CMake 3.30+).
if(POLICY CMP0169)
    cmake_policy(SET CMP0169 OLD)
endif()

# Force sub-projects to use OLD behavior for CMP0175 (CMake 3.31+).
set(CMAKE_POLICY_DEFAULT_CMP0175 OLD)

include(FetchContent)

FetchContent_Declare(
    rapidjson
    GIT_REPOSITORY https://github.com/Tencent/rapidjson.git
    GIT_TAG        master
    GIT_SHALLOW    TRUE
)
set(RAPIDJSON_BUILD_DOC OFF CACHE BOOL "" FORCE)
set(RAPIDJSON_BUILD_EXAMPLES OFF CACHE BOOL "" FORCE)
set(RAPIDJSON_BUILD_TESTS OFF CACHE BOOL "" FORCE)
# set(FETCHCONTENT_UPDATES_DISCONNECTED ON CACHE BOOL "" FORCE)

# RapidJSON install rules are trying to install to system directories
# even when used via FetchContent, which is needed to disable.
# FetchContent_MakeAvailable(rapidjson)
# if(TARGET rapidjson)
#     # Prevent RapidJSON from installing itself when included via FetchContent
#     set_property(DIRECTORY ${rapidjson_SOURCE_DIR} PROPERTY EXCLUDE_FROM_ALL YES)
# endif()

FetchContent_GetProperties(rapidjson)
if(NOT rapidjson_POPULATED)
    FetchContent_Populate(rapidjson)
    add_subdirectory(${rapidjson_SOURCE_DIR} ${rapidjson_BINARY_DIR} EXCLUDE_FROM_ALL)
endif()

if(TARGET rapidjson)
    if(NOT TARGET RapidJSON::RapidJSON)
        add_library(RapidJSON::RapidJSON ALIAS rapidjson)
    endif()
else()
    if(NOT TARGET RapidJSON::RapidJSON)
        add_library(RapidJSON::RapidJSON INTERFACE IMPORTED)
        set_target_properties(RapidJSON::RapidJSON PROPERTIES
            INTERFACE_INCLUDE_DIRECTORIES "${rapidjson_SOURCE_DIR}/include"
        )
    endif()
endif()
