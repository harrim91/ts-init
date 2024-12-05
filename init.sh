#!/bin/bash

# get the directory of this script in TS_INIT_DIR variable
TARGET_DIR=$(pwd)
TS_INIT_FILE="${BASH_SOURCE[0]}"
while [ -h "$TS_INIT_FILE" ]; do
  TS_INIT_DIR="$( cd -P "$( dirname "$TS_INIT_FILE" )" >/dev/null 2>&1 && pwd )"
  TS_INIT_FILE="$(readlink "$TS_INIT_FILE")"
  [[ $TS_INIT_FILE != /* ]] && TS_INIT_FILE="$TS_INIT_DIR/$TS_INIT_FILE"
done
TS_INIT_DIR="$( cd -P "$( dirname "$TS_INIT_FILE" )" >/dev/null 2>&1 && pwd )"

# check for updates
echo "[ts-init] Checking for updates..."
cd $TS_INIT_DIR
git remote update &>/dev/null;

if [[ $(git status -sb) == *behind* ]]
then
  echo -n "[ts-init] Would you like to update? [Y/n] "

  read -r should_update

  should_update=${should_update:-y}

  case "$should_update" in
      [yY$'\n'])
        git pull --ff-only
        echo "[ts-init] Updated successfully."
        echo "[ts-init] Please run ts-init again to use the latest version."
        exit 0
        ;;

      *)
        echo "[ts-init] Skipping update."
        ;;
  esac
else
  echo "[ts-init] No updates available."
fi

echo

cd $TARGET_DIR

# set up default parameter values
name=${name}
git_email=${git_email:-$(git config --global user.email)}
package_manager=${package_manager:-npm}
use_git=${use_git:-true}
template=${template:-standard}

# loop through given named parameters and set them as variables
while [ $# -gt 0 ]; do
   if [[ $1 == *"--"* ]]; then
        param="${1/--/}"
        param=$(echo $param | tr - _)
        declare $param="$2"
   fi
  shift
done

# validate parameters
if [ -z $name ]
then
  echo "[ts-init] No project name given. Please pass a project name using the --name flag."
  exit 1
fi

if [ -d $name ]
then
  echo "[ts-init] A directory with this name already exists."
  exit 1
fi

if [ $package_manager != npm ] && [ $package_manager != yarn ]
then
  echo "[ts-init] Invalid package manager specified. Valid values are 'npm' and 'yarn'."
  exit 1
fi

if [ $use_git != true ] && [ $use_git != false ]
then
  echo "[ts-init] Invalid value for \"--use_git\". Valid values are 'true' and 'false'."
  exit 1
fi

if [ $template != "standard" ] && [ $template != "express" ] && [ $template != "lambda" ]
then
  echo "[ts-init] Invalid template name specified. Valid values are 'standard' and 'express'."
  exit 1
fi

echo "[ts-init] Creating new TypeScript project in $TARGET_DIR/$name."
echo

# copy project template to new directory
cp -r $TS_INIT_DIR/templates/$template $name
cd $name

# update project name in package.json
sed -e "s;ts-init;$name;g" package.json > package.json.tmp
mv package.json.tmp package.json

# create a basic readme
echo "# $name" > README.md

echo "[ts-init] Installing dependencies with $package_manager..."

DEPENDENCIES=$(cat dependencies.txt)

INSTALL_COMMAND="install"

if [ $package_manager == yarn ]
then
  INSTALL_COMMAND="add"
fi

$package_manager $INSTALL_COMMAND $DEPENDENCIES

rm dependencies.txt

echo "[ts-init] Done!"

echo

echo "[ts-init] Installing dev dependencies with $package_manager..."

DEV_DEPENDENCIES=$(cat dev-dependencies.txt)

INSTALL_DEV_COMMAND="install -D"

if [ $package_manager == yarn ]
then
  INSTALL_DEV_COMMAND="add -D"
fi

$package_manager $INSTALL_DEV_COMMAND $DEV_DEPENDENCIES

rm dev-dependencies.txt

echo "[ts-init] Done!"

echo

if [ $use_git == true ]
then
  echo "[ts-init] Creating Git repository..."
  git init
  git config user.email $git_email
  git add .
  git commit -m "Initial commit"
  echo
fi

echo "[ts-init] Done!"
