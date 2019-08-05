# set error handing
set -o errexit

# build
echo docker build --pull -f "$2/$3" -t sowalabs/$1:$TAG "$2"/..
docker build --pull -f "$2/$3" -t sowalabs/$1:$TAG "$2"/..

# tag & push
if [[ $TAG == *.* ]]; then
	VER=""
	for TAG_PART in $(echo $TAG | tr "." "\n"); do
		VER=$VER.$TAG_PART
		echo docker tag sowalabs/$1:$TAG sowalabs/$1:${VER:1} 
		docker tag sowalabs/$1:$TAG sowalabs/$1:${VER:1} 
		if [ "$PUSH" = yes ]
		then
			echo docker push sowalabs/$1:${VER:1}
			docker push sowalabs/$1:${VER:1}
		fi
	done
else
	if [ "$PUSH" = yes ]
	then
		echo docker push sowalabs/$1:$TAG
		docker push sowalabs/$1:$TAG
	fi
fi