add_executable(bela_executable
    ${CMAKE_SOURCE_DIR}/Bela/core/default_main.cpp
    ${CMAKE_CURRENT_SOURCE_DIR}/render.cpp
)

target_include_directories(bela_executable PRIVATE
    ${CMAKE_CURRENT_SOURCE_DIR}
)


target_link_libraries(bela_executable PRIVATE
    bela
    belaextra
    belafull
)

set_target_properties(bela_executable PROPERTIES
    CXX_STANDARD 17
)

target_compile_options(bela_executable PRIVATE
    -Wall
    -Wextra
    -Wno-unused-parameter
    # -Werror
)

add_custom_target(build_and_deploy
    ALL
    COMMAND scp ${CMAKE_BINARY_DIR}/bin/bela_executable root@$ENV{BBB_HOSTNAME}:~
)

add_dependencies(build_and_deploy
    bela_executable
)

set_target_properties(build_and_deploy PROPERTIES
    EXCLUDE_FROM_ALL true
)

