scripts=(
	# truflle debug aliases
	debug.sh

	# fuzzy eip command
	eip.sh

	# scratchpad aliases
	scratchpad.sh
)

# for fn in $(ls ${TRUFFLE_DOTFILES}/scripts); do
for fn in "${scripts[@]}"; do
	source "$TRUFFLE_DOTFILES/scripts/${fn}"
done

#vi: ft=zsh
