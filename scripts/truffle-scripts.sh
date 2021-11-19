## Executing these functions will create aliases for truffle & db-kit
##

## aliases
show-truffle-env () {
  print truffle: $(which truffle)
  print db-kit: $(which db-kit)
  print
  truffle version
}

use-truffle-core () {
  alias truffle=node\ ${TRUFFLE_ROOT}/packages/core/cli.js
}

use-truffle-core-debug () {
  alias truffle=node\ --inspect-brk\ ${TRUFFLE_ROOT}/packages/core/cli.js
}

use-truffle-bundle () {
  alias truffle=node\ ${TRUFFLE_ROOT}/packages/truffle/build/cli.bundled.js
}

use-truffle-stable () {
  unalias truffle
}

use-dbkit-core () {
  alias db-kit=node\ ${TRUFFLE_ROOT}/packages/db-kit/dist/bin/cli.js
}

use-dbkit-core-debug () {
  alias  db-kit=node\ --inspect-brk\ ${TRUFFLE_ROOT}/packages/db-kit/dist/bin/cli.js
}

use-dbkit-stable () {
  unalias db-kit
}

truffle-link () {
  if [ "$PWD" != "$TRUFFLE_ROOT" ]; then
    echo "\e[1;31m[Warning]\e[0m This command can only be run from TRUFFLE_ROOT: $TRUFFLE_ROOT\n"
  fi

  if [ $# -eq 0 ]; then
    echo "usage: truffle-link pkg1 pkg2 pkg3\n"
  else
    for pkg in "$@";  do
      if [ -d "packages/$pkg" ]; then
        cd packages/$pkg ; yarn unlink ; yarn link ; cd -
        echo linking $pkg
      else
        echo "\e[1;31m$pkg\e[0m is not a Truffle package!"
      fi
    done
  fi
}

truffle-unlink () {
  if [ "$PWD" != "$TRUFFLE_ROOT" ]; then
    echo "\e[1;31m[Warning]\e[0m This command can only be run from TRUFFLE_ROOT: $TRUFFLE_ROOT\n"
  fi
  echo "usage: truffle-unlink pkg1 pkg2 pkg3\n"

  for pkg in "$@";  do
    if [ -d "packages/$pkg" ]; then
    cd packages/$pkg ; yarn unlink ; cd -
    echo linking $pkg
  else
    echo "\e[1;31m$pkg\e[0m is not a Truffle package!"
    fi
  done
}

reprod () {
  # customize these (FAKER: `npm install -g faker-cli`)
  # TODO: make sure ~/.nvm/default-packages include faker-cli
  #       so that when a new node version is installed, faker-cli is
  #       installed
  local FAKER=${NVM_BIN}/faker-cli
  local year="$(date +%Y)"
  local month="$(date +%m)"
  local day="$(date +%d)"

  local parent="${REPROD_ROOT}/${year}/${month}/${day}"
  local name="${1:-$(${FAKER} --lorem slug | tr -d '"')}"

  local dir="${parent}/${name}"
  if [ -d "${dir}" ]; then
      echo "Warning: directory exists for today with name \"${name}\""
  fi

  mkdir -p $dir && cd $_
}

list-reprod-today () {
  local year="$(date +%Y)"
  local month="$(date +%m)"
  local day="$(date +%d)"
  local dir="${REPROD_ROOT}/${year}/${month}/${day}"

  if [ -d $dir ]; then
    cd $dir && tree $dir -d -L 1
  else
    echo "No repros for $dir"
  fi
}

list-reprod-day () {
  local year="$(date +%Y)"
  local month="$(date +%m)"
  local day=$(printf '%02d' ${1:-$(date +%d)})
  local dir="${REPROD_ROOT}/${year}/${month}/${day}"
  if [ -d $dir ]; then
    cd $dir && tree $dir -d -L 1
  else
    echo "No repros for $dir"
  fi
}

list-reprod-month () {
  local year="$(date +%Y)"
  local month=$(printf '%02d' ${1:-$(date +%m)})
  local dir="${REPROD_ROOT}/${year}/${month}"
  if [ -d $dir ]; then
    cd $dir && tree $dir -d -L 2
  else
    echo "No repros for $dir"
  fi
}

list-reprod-year () {
  local year="${1:-$(date +%Y)}"
  local dir="${REPROD_ROOT}/${year}"
  if [ -d $dir ]; then
    cd $dir && tree $dir -d -L 3
  else
    echo "No repros for $dir"
  fi
}
