function eip() {
	URL="https://github.com/ethereum/EIPs/blob/master/EIPS/eip"
	eip_number=$(
		fzf --no-sort \
			--prompt 'Ethereum Improvement Proposal (EIP) >' \
			--preview='echo {}' --preview-window=down:1:wrap \
			--height=80% <"$TRUFFLE_DOTFILES/.cache/eip-index" \
			| awk '{ print $1 }'
	)

  # do nothing if nothing selected
  [[ -z $eip_number ]] && return

	if uname | grep -q Darwin; then
    # OS X
		open -a 'Google Chrome' "${URL}-${eip_number}.md"
	elif uname -a | grep -q microsoft; then
    # WSL2
    /mnt/c/Program\ Files\ \(x86\)/Microsoft/Edge/Application/msedge.exe "${URL}-${eip_number}.md"
    # /mnt/c/Program\ Files\ \(x86\)/Google/Chrome/Application/chrome.exe "${URL}-${eip_number}.md" 
	else
    # default, Linux
		brave "${URL}-${eip_number}.md"
	fi
}

#vi: ft=zsh
