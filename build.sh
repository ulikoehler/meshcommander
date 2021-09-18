#!/bin/sh

user=ulikoehler
imagename=meshcommander

# build
docker pull node:latest
docker build --no-cache=true -t $user/$imagename:latest

# get npm-installed version
version=$( docker run -it --rm node:latest npm info meshcommander version | head -n1 )
if [ -z "$version" ] ; then
	echo "Could not grep installed version. Exit."
	exit 1
fi

# append my version number
version="$version"

# tag
echo "Tagging lastbuilt as $user/$imagename:$version"
docker tag $user/$imagename:lastbuilt $user/$imagename:$version

# hint
echo
echo "* Run it with"
echo "  docker run -d -p 127.0.0.1:3000:3000 --name meshcommander ulikoehler/meshcommander:lastbuilt"
echo "* If it behaves well, push with the following commands:"
echo "  docker push $user/$imagename:$version"
echo "  docker tag $user/$imagename:$version $user/$imagename:latest"
echo "  docker push $user/$imagename:latest"
