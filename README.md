# ts-init

Utility to bootstrap TypeScript projects

## Install

- clone this repo to somewhere useful - `git clone git@github.com:harrim91/ts-init.git ~/.ts-init`
- create a symbolic link between the script and somewhere in your PATH - `ln -s ~/.ts-init/init.sh /usr/local/bin/ts-init`
- create a typescript project - `ts-init --name my-project`

## Usage

`ts-init` takes the following options:

- `--name` - the name of your project. required.
- `--git-email` - `ts-init` creates a git repository for you in your new project. By default it will use your global git email, but you can override it with this option.
- `--package-manager` - package manager to use - yarn or npm. default is npm.


