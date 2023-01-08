# where to get the package sources from
vcpkg_from_git(
    OUT_SOURCE_PATH SOURCE_PATH
    URL https://github.com/glfw/glfw.git         # Git repository cloning URL
    REF 7482de6071d21db77a7236155da44c172a7f6c9e # commit hash (pointing to a version tag)
)

# how to configure the project
# thankfully, GLFW already has CMakeLists.txt
vcpkg_cmake_configure(
    # where CMakeLists.txt is (here's it's on the root level of the project)
    SOURCE_PATH "${SOURCE_PATH}"
    # CMake configuration options, just regular -D stuff
    OPTIONS
        -DGLFW_BUILD_EXAMPLES=0
        -DGLFW_BUILD_TESTS=0
        -DGLFW_BUILD_DOCS=0
)

# this one actually builds and installs the project
vcpkg_cmake_install()

# this will (try to) fix possible problems with imported targets
vcpkg_cmake_config_fixup(
    PACKAGE_NAME "glfw3"          # if the project name (glfw3) is different from the port name (glfw)
    CONFIG_PATH "lib/cmake/glfw3" # where to find project's CMake configs
)

# don't know what this is used for
#vcpkg_fixup_pkgconfig()

# this one you just need to have, and sometimes you'll need to delete even more things
# feels like a crutch, but okay
file(REMOVE_RECURSE "${CURRENT_PACKAGES_DIR}/debug/include")

# vcpkg expects license information to be contained in the file named "copyright"
file(
    INSTALL "${SOURCE_PATH}/LICENSE.md"
    DESTINATION "${CURRENT_PACKAGES_DIR}/share/${PORT}"
    RENAME copyright
)

# don't know what this is used for
#vcpkg_copy_pdbs()