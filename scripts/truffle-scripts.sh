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
  echo "usage: from root folder\n\ttruffle-link pkg1 pkg2 pkg3"
  for pkg in "$@";  do
    cd packages/$pkg ; yarn unlink ; yarn link ; cd -
  done
}

truffle-unlink () {
  echo "usage: from root folder\n\ttruffle-unlink pkg1 pkg2 pkg3"
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
      echo "Warning: directory exists for today with name \"${name}\""
  fi

  mkdir -p $dir
  cd $dir
}
