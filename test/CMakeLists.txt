add_executable(unit_tests src/test_main.cpp)

target_link_libraries(unit_tests
    PRIVATE
        JSONUtils::JSONUtils
)

add_test(NAME unit_tests COMMAND unit_tests)
