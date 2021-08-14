#!/usr/bin/env bash

if [ ! -d EIPs ]; then
	printf "Clone EIP repository"
	git clone --depth 1 https://github.com/ethereum/EIPs.git
fi

for no in $(ls EIPs/EIPS | sed 's:eip-::' | sed 's:.md::' | sort -n); do
	file="EIPs/EIPS/eip-$no.md"

	# extract lines from ^eip to ^title
	# delete header of tuple
	# convert linefeeds to tabs
	sed -n '/^eip:/,/^title/p;' "$file" | sed -E 's/^.\+: //' | tr '\n' '\t'

	# separate entries
	printf "\n"
done | sed -E 's/(eip:|title:|\t)//g' | sed -E '/^$/d' >.cache/eip-index

[[ -d EIPs ]] && rm -rf EIPs

# TODO
# extract abstract
# sed -E -n '/# Abstract/,/# Motivation/p;' $file | sed '1d;$d' > "./abstract/$no-abstract.txt"
