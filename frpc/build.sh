#!/bin/sh


MODULE=frpc
VERSION="1.3"
TITLE=frpc穿透
DESCRIPTION=内网穿透利器，谁用谁知道。
HOME_URL=Module_frpc.asp

old_version=`cat version | sed -n 1p`
old_md5sum=`cat version | sed -n 2p`

# backup old package
if [ "$old_version" != "$VERSION" ];then
  [ ! -d ./history/ ] && mkdir -p ./history/
  echo old_version $old_version
  echo VERSION $VERSION
  mv ${MODULE}.tar.gz ./history/"${MODULE}"_"$old_version".tar.gz
  echo $old_version $old_md5sum >> ./history/version
fi

# Check and include base
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
if [ "$MODULE" == "" ]; then
	echo "module not found"
	exit 1
fi

if [ -f "$DIR/$MODULE/$MODULE/install.sh" ]; then
	echo "install script not found"
	exit 2
fi
sed -i "s/VERSION=.*/VERSION=\"${VERSION}\"/g" $DIR/$MODULE/$MODULE/install.sh
# now include build_base.sh
. $DIR/../softcenter/build_base.sh

# change to module directory
cd $DIR

# do something here

do_build_result