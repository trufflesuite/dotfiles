# Truffle dotfiles

Useful scripts for Truffle testers and maintainers on \*nix OS.

- [Installation](#installation)
  - [Node Version Manager](#node-version-manager)
  - [dotfiles](#dotfiles)
- [Command Reference](#command-reference)
  - [reprod](#reprod)
  - [list-reprod-year](#list-reprod-year)
  - [list-reprod-month](#list-reprod-month)
  - [list-reprod-day](#list-reprod-day)
  - [list-reprod-today](#list-reprod-today)
  - [show-truffle-env](#show-truffle-env)
  - [truffle-core variants](#truffle-core-variants)
    - [use-truffle-core](#use-truffle-core)
    - [use-truffle-core-debug](#use-truffle-core-debug)
- [use-truffle-bundle](#use-truffle-bundle)
- [use-truffle-stable](#use-truffle-stable)
- [@truffle/db-kit](#-truffle-db-kit)

<small><i><a href='http://ecotrust-canada.github.io/markdown-toc/'>Table of contents generated with markdown-toc</a></i></small>

## Installation

### Node Version Manager

It's recommended that you use [Node Version Manager
(nvm)](https://github.com/nvm-sh/nvm) to manage node versions for Truffle
development.
A list of frequently used packages can be stored in a file named `default-packages` at the NVM directory , this list will be automatically installed globally every time a new node version is added.

First, create the $NVM_DIR/default-packages file.

```sh
touch $NVM_DIR/default-packages
```

We recommend adding `faker-cli` and `typescript`.

```sh
# $NVM_DIR/default-packages

faker-cli
typescript
```

### Scripts

1. Clone this repo
   ```sh
   git clone git@github.com:trufflesuite/dotfiles ~/.truffle-dotfiles
   ```
2. edit your shell startup script to set a couple of env variables, and
   source the dotfiles.

   ```sh
   # in your .(zsh/bash)rc file

   ## TRUFFLE_ROOT is the path to your cloned truffle project
   export TRUFFLE_ROOT=~/work/truffle # YOU SHOULD ADJUST THIS FOR YOURSELF

   ## REPROD_ROOT is where you would like reproductions to be created.
   export REPROD_ROOT=~/work/reprod

   source ~/.truffle-dotfiles/scripts/truffle-scripts.sh

   ```

## Command Reference

### reprod

Create and navigate to a new folder organized by `year/month/date`.

You will create many truffle projects in the course of your work and `reprod`
makes it easier with the benefit of organizing the folders by date. This is a
lifesaver when jumping between projects.

```
usage: reprod [ name ]
Options:
  name        specify the name of the project. A random name will
              be used if not spcified.
```

Here's directory that's created after running `reprod safe-eval`.

```
work/reproduce      <-- This is REPROD_ROOT
├── 2021
│   └── 05
│       └── 25
│           └── safe-eval

```

Before using list-reprod

```
 brew install tree
```

For displaying directories as trees.

### list-reprod-year

List all reprod folders for a year.

```
usage: list-reprod-year [ year  ]
Options:
  year      specify the year. [default: current year]
```

### list-reprod-month

List all reprod folders for a month.

```
usage: list-reprod-month [ month  ]
Options:
  month     specify the month. [default: current month]
```

### list-reprod-day

List all reprod folders for a day in current month.

```
usage: list-reprod-day [ day  ]
Options:
  day       specify the day. [default: today]
```

### list-reprod-today

You busy 🐝! List all reprod folders for today

```
usage: list-reprod-today
```

### show-truffle-env

Display your current truffle resolutions. Useful for sanity checking.

```sh
$ show-truffle-env
truffle: /Users/cds/.nvm/versions/node/v12.22.1/bin/truffle
db-kit: db-kit: aliased to node /Users/cds/work/truffle/packages/db-kit/dist/bin/cli.js

Truffle v5.3.6 (core: 5.3.6)
Solidity v0.5.16 (solc-js)
Node v12.22.1
Web3.js v1.3.5
$
```

### truffle-core variants

As you add features, debug issues you'll need to run specific versions truffle.
There's the released version, the current bundled version, and the unbundled
source. These two variants allow you to perform a regular execution and one
with the node [debug
inspector](https://nodejs.org/en/docs/guides/debugging-getting-started/)
enabled for acts of debuggerie.

Both variants use the truffle source currently in your `TRUFFLE_ROOT` folder.

#### use-truffle-core

Invoke the truffle version you're currently developing.

`usage: use-truffle-core`

```
$ use-truffle-core
$ which truffle
truffle: aliased to node /home/amal/work/truffle/packages/core/cli.js
```

#### use-truffle-core-debug

Invoke the truffle code in your current git branch with the debug inspector
enabled. This allows you to debug the truffle process by using a debug client.
For example, to use chrome dev tools, navigate to `chrome://inspect` **in a
chrome browser.**

`usage: use-truffle-core`

```
$ use-truffle-core-debug
$ which truffle
truffle: aliased to node --inspect-brk /home/amal/work/truffle/packages/core/cli.js
```

## use-truffle-bundle

Invoke the bundled truffle version in your current git branch. This bundle
will eventually be published to the npm registry. **N.B.** You should have
already built truffle

`usage: use-truffle-bundle`

```
$ use-truffle-bundle
$ which truffle
truffle: aliased to node /home/amal/work/truffle/packages/truffle/build/cli.bundled.js
```

## use-truffle-stable

Use the version of truffle installed by npm. Note, all this does is unalias
truffle to allow normal PATH environment resolution.

`usage: use-truffle-stable`

```
$ use-truffle-stable
$ which truffle
/home/amal/.nvm/versions/node/v12.22.1/bin/truffle
```

## @truffle/db-kit

Similarly, aliases are created for @truffle/db-kit
3 commands are available

| command             | description                                                |
| ------------------- | ---------------------------------------------------------- |
| `use-db-core`       | use local developed version of `db-kit`                    |
| `use-db-core-debug` | use local version of `db-kit` with debug inspector enabled |
| `use-db-stable`     | use npm installed version of `db-kit`                      |
