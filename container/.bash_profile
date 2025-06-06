PROJECT_ROOT="/src"
BUILD_ROOT="/build"

if [[ ! -d "$PROJECT_ROOT" ]]; then
  echo "You didn't mount the project volume."
  return 1
fi

if [[ ! -d "$BUILD_ROOT" ]]; then
  echo "You didn't mount the build volume."
  return 1
fi

cd "$PROJECT_ROOT"

build() {
  pushd "$BUILD_ROOT" || return 1
  cmake "$PROJECT_ROOT" -DCMAKE_BUILD_TYPE=Debug
  make -j8
  popd || return 1
}

run_tests() {
  pushd "$BUILD_ROOT" || return 1
  ctest "$@"
  popd || return 1
}

run_specific_tests() {
  pushd "$BUILD_ROOT" || return 1
  case "$#" in
    0)
      ctest
      ;;
    1)
      ctest -R "$1"
      ;;
    *)
      local test_filter="$2"
      local suite_filter="$1"
      shift 2
      GTEST_FILTER="$test_filter" ctest -R "$suite_filter" "$@"
      ;;
  esac
  popd || return 1
}

cat <<EOF
Commands:

build                Builds the project
run_tests            Runs all tests. Any extra arguments are passed directly to
                     ctest.

run_specific_tests suite_filter gtest_filter
                     Runs specific tests. The suite_filter is a regex for
                     the test executable file, and the gtest_filter is a
                     regex for the Google Test suite and (optionally) test
                     name. Example:

                     run_specific_tests skiplist_test SkipListTest.LongKeys
EOF

