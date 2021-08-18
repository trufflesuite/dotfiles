## aliases

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
