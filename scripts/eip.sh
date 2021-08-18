function eip () {
  URL="https://github.com/ethereum/EIPs/blob/master/EIPS"
  (cat "$TRUFFLE_DOTFILES/.cache/eip-index") |
  fzf +s \
    --prompt 'Ethereum Improvement Proposal (EIP) >' \
    --preview='echo {}' --preview-window=down:1:wrap \
    --height=80% | \
  awk '{ print $1 }'  | \
  if $(uname | grep -iq darwin); then
    xargs -I '{}' open -a 'Google Chrome' "${URL}/eip-{}.md"
    # xargs -I '{}' open -a 'Safari' "${URL}/eip-{}.md"
  else
    xargs -I '{}' brave "${URL}/eip-{}.md"
    # xargs -I '{}' google-chrome-beta "${URL}/eip-{}.md"
    # xargs -I '{}' google-chrome-stable "${URL}/eip-{}.md"

    # xdg-open has issues on arch, which might be my setup.
    # xargs -I '{}' nohup xdg-open  "${URL}/eip-{}.md" > /dev/null 2>&1 &
  fi
}

#vi: ft=zsh
