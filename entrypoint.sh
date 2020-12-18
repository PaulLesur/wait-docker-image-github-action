#!/bin/bash -l

echo "Image:           $1"
echo "Tag:             $2"
echo "Timeout:         $3"
echo "Exit on timeout: $4"
echo "User:            $5"
echo "Password:        $6"

wait_docker_image_loop() {
    if [ "$5" != "no_auth" ]
    then
        auth="--creds=$5:$6"
    fi
    while :
    do
        printf .
        skopeo inspect $auth docker://$1:$2 >/dev/null 2>error_output
        if [ "$?" = "0" ]
        then
            break
        fi
        sleep 1
    done;

}

if [ "$4" = "true" ]
then
    set -e
fi

echo "Waiting for image $1:$2 to be available."
export -f wait_docker_image_loop
timeout -s SIGTERM $3 bash -c "wait_docker_image_loop $1 $2 $3 $4 $5 $6"

if [ "$?" = "0" ]
then
    echo "Image $1:$2 is available !"
else 
    echo "Image not available after timeout ! Error: "
    cat error_output
fi