## Executing these functions will create aliases for truffle & db-kit

show-truffle-env () {
  print "Aliases"
  print "  truffle: $(which truffle)"
  print "  db-kit: $(which db-kit)"
  print "Dependencies"
  local yok="  ☑️  "
  local nok="  ⚠️  "
  declare -a CMDS=( "nvm" "faker-cli" "tree" )
  for cmd in "${CMDS[@]}"; do
    if [ $(command -v $cmd) ]; then
      print "${yok}${cmd}: detected"
    else
      print "${nok}${cmd}: missing: please install"
    fi
  done
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

use-db-core () {
  alias db-kit=node\ ${TRUFFLE_ROOT}/packages/db-kit/dist/bin/cli.js
}

use-db-core-debug () {
  alias  db-kit=node\ --inspect-brk\ ${TRUFFLE_ROOT}/packages/db-kit/dist/bin/cli.js
}

use-db-stable () {
  unalias db-kit
}

truffle-link () {
  print "usage: from root folder\n\ttruffle-link pkg1 pkg2 pkg3"
  for pkg in "$@";  do
    cd packages/$pkg ; yarn unlink ; yarn link ; cd -
  done
}

truffle-unlink () {
  print "usage: from root folder\n\ttruffle-unlink pkg1 pkg2 pkg3"
  for pkg in "$@";  do
    cd packages/$pkg ; yarn unlink ; cd -
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
      print "Warning: directory exists for today with name \"${name}\""
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
