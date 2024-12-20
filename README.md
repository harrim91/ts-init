# ts-init

Utility to bootstrap TypeScript projects.

## Install

- clone this repo to somewhere useful - `git clone git@github.com:harrim91/ts-init.git ~/.ts-init`
- create a symbolic link between the script and somewhere in your PATH - `ln -s ~/.ts-init/init.sh /usr/local/bin/ts-init`
- create a typescript project - `ts-init --name my-project`

## Usage

`ts-init` takes the following options:

- `--name` - the name of your project. required.
- `--use-git` - `true` or `false` - whether to initialize a git repository in your project. default is `true`.
- `--git-email` - if `ts-init` creates a git repository for you in your new project, by default it will use your global git email. You can override it with this option.
- `--package-manager` - package manager to use - `yarn` or `npm`. default is `npm`.
- `--template` - use a template. Default value is `standard`. Other options are `express` or `lambda`.

## Uninstall

- remove the symbolic link between the script and somewhere in your PATH - `unlink /usr/local/bin/ts-init`
- remove the directory from somewhere useful `rm -rf ~/.ts-init`

## Templates

### Standard

A blank "Hello World" template.

### Express

Bootstraps a minimal Express.js app. Includes a production-ready Dockerfile, and local setup utilizing Docker Compose.

### Lambda

Bootstraps a minimal AWS Lambda function for the `node20` runtime.
