for fn in $(ls ${TRUFFLE_DOTFILES}/scripts); do
  source "$TRUFFLE_DOTFILES/scripts/${fn}"
done

#vi: ft=zsh
