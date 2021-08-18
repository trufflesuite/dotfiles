## Executing these functions will create aliases for truffle & db-kit
##

## aliases
show-truffle-env() {
  print truffle: $(which truffle)
  print db-kit: $(which db-kit)
  print
  truffle version
}

use-truffle-core() {
  alias truffle=node\ ${TRUFFLE_ROOT}/packages/core/cli.js
}

use-truffle-core-debug() {
  alias truffle=node\ --inspect-brk\ ${TRUFFLE_ROOT}/packages/core/cli.js
}

use-truffle-bundle() {
  alias truffle=node\ ${TRUFFLE_ROOT}/packages/truffle/build/cli.bundled.js
}

use-truffle-stable() {
  unalias truffle
}

use-db-core() {
  alias db-kit=node\ ${TRUFFLE_ROOT}/packages/db-kit/dist/bin/cli.js
}

use-db-core-debug() {
  alias db-kit=node\ --inspect-brk\ ${TRUFFLE_ROOT}/packages/db-kit/dist/bin/cli.js
}

use-db-stable() {
  unalias db-kit
}

truffle-link() {
  if [ "$PWD" != "$TRUFFLE_ROOT" ]; then
    echo "\e[1;31m[Warning]\e[0m This command can only be run from TRUFFLE_ROOT: $TRUFFLE_ROOT\n"
  fi

  if [ $# -eq 0 ]; then
    echo "usage: truffle-link pkg1 pkg2 pkg3\n"
  else
    for pkg in "$@"; do
      if [ -d "packages/$pkg" ]; then
        cd packages/$pkg
        yarn unlink
        yarn link
        cd -
        echo linking $pkg
      else
        echo "\e[1;31m$pkg\e[0m is not a Truffle package!"
      fi
    done
  fi
}

truffle-unlink() {
  if [ "$PWD" != "$TRUFFLE_ROOT" ]; then
    echo "\e[1;31m[Warning]\e[0m This command can only be run from TRUFFLE_ROOT: $TRUFFLE_ROOT\n"
  fi
  echo "usage: truffle-unlink pkg1 pkg2 pkg3\n"

  for pkg in "$@"; do
    if [ -d "packages/$pkg" ]; then
      cd packages/$pkg
      yarn unlink
      cd -
      echo linking $pkg
    else
      echo "\e[1;31m$pkg\e[0m is not a Truffle package!"
    fi
  done
}
