# Determine all branches checked out for truffle worktree and bind the branch
# names as completion options for specific worktree commands
branches=$(ls ${TRUFFLE_TREE_ROOT})
complete -W "$branches" use-truffle-tree
complete -W "$branches" use-truffle-tree-debug
complete -W "$branches" use-truffle-tree-bundle

