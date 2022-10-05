## Executing these functions will create aliases for truffle & db-kit
##

if [ -z "${TRUFFLE_ENV_NAME}" ]; then
  export TRUFFLE_ENV_NAME="core"
fi

if [ -z "${DBKIT_ENV_NAME}" ]; then
  export DBKIT_ENV_NAME="core"
fi

## aliases
show-truffle-cli-entrypoint() {
  case "${TRUFFLE_ENV_NAME}" in 
    stable)
      echo "$(npm prefix -g)/bin/truffle"
      ;;
    core|core-debug)
      echo "${TRUFFLE_ROOT}/packages/core/cli.js"
      ;;
    bundle)
      echo "${TRUFFLE_ROOT}/packages/truffle/build/cli.bundled.js"
      ;;
    tree|tree-debug)
      echo "${TRUFFLE_TREE_ROOT}/${TRUFFLE_TREE_BRANCH}/packages/core/cli.js"
      ;;
    tree-bundle)
      echo "${TRUFFLE_TREE_ROOT}/${TRUFFLE_TREE_BRANCH}/packages/truffle/build/cli.bundled.js"
      ;;
    *)
      echo "truffle environment named '$TRUFFLE_ENV_NAME' not recognized" >&2
      ;;
  esac
}

show-dbkit-cli-entrypoint() {
  case "${DBKIT_ENV_NAME}" in 
    stable)
      echo "$(npm prefix -g)/bin/db-kit"
      ;;
    core|core-debug)
      echo "${TRUFFLE_ROOT}/packages/db-kit/dist/bin/cli.js"
      ;;
    *)
      echo "db-kit environment named '$DBKIT_ENV_NAME' not recognized" >&2
      return 1
      ;;
  esac
}

show-truffle-env () {
  print truffle: "${TRUFFLE_ENV_NAME}" "($(show-truffle-cli-entrypoint))"
  print db-kit: "${DBKIT_ENV_NAME}" "($(show-dbkit-cli-entrypoint))"
  print
  truffle version
}

use-truffle-core () {
  export TRUFFLE_ENV_NAME="core"
  source ~/.oh-my-zsh/themes/mira.zsh-theme
}

use-truffle-core-debug () {
  export TRUFFLE_ENV_NAME="core-debug"
  source ~/.oh-my-zsh/themes/mira.zsh-theme
}

update-truffle-trees () {
  source ${TRUFFLE_DOTFILES}/scripts/trees.sh
  printf "git-worktrees updated!\n"
}

use-truffle-tree () {
  if [[ -z "${TRUFFLE_TREE_ROOT}" ]]; then
    echo git-worktree not configured for truffle 
  else
    export TRUFFLE_TREE_BRANCH=$1
    export TRUFFLE_ENV_NAME="tree"
    source ~/.oh-my-zsh/themes/mira.zsh-theme
  fi
}

use-truffle-tree-debug () {
  if [[ -z "${TRUFFLE_TREE_ROOT}" ]]; then
    echo git-worktree not configured for truffle 
  else
    export TRUFFLE_TREE_BRANCH=$1
    export TRUFFLE_ENV_NAME="tree-debug"
    source ~/.oh-my-zsh/themes/mira.zsh-theme
  fi
}

use-truffle-tree-bundle () {
  if [[ -z "${TRUFFLE_TREE_ROOT}" ]]; then
    echo git-worktree not configured for truffle 
  else
    export TRUFFLE_TREE_BRANCH=$1
    export TRUFFLE_ENV_NAME="tree-bundle"
    source ~/.oh-my-zsh/themes/mira.zsh-theme
  fi
}

use-truffle-bundle () {
  export TRUFFLE_ENV_NAME="bundle"
  source ~/.oh-my-zsh/themes/mira.zsh-theme
}

use-truffle-stable () {
  export TRUFFLE_ENV_NAME="stable"
  source ~/.oh-my-zsh/themes/mira.zsh-theme
}

use-dbkit-core () {
  export DBKIT_ENV_NAME="core"
}

use-dbkit-core-debug () {
  export DBKIT_ENV_NAME="core-debug"
}

use-dbkit-stable () {
  export DBKIT_ENV_NAME="stable"
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

truffle () {
  TRUFFLE_CLI_ENTRYPOINT="$(show-truffle-cli-entrypoint)"

  if [ $? -ne 0 ]; then
    return 1
  fi

  NODE_ARGS=""

  echo "${TRUFFLE_ENV_NAME}" | grep -qE -- '-debug$' && NODE_ARGS="--inspect-brk"

  node $NODE_ARGS "${TRUFFLE_CLI_ENTRYPOINT}" $@
}

db-kit () {
  DBKIT_CLI_ENTRYPOINT="$(show-truffle-cli-entrypoint)"

  if [ $? -ne 0 ]; then
    return 1
  fi

  NODE_ARGS=""

  echo "${DBKIT_ENV_NAME}" | grep -qE -- '-debug$' && NODE_ARGS="--inspect-brk"

  node $NODE_ARGS "${DBKIT_CLI_ENTRYPOINT}" $@
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
