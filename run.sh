#!/bin/bash

rootFolder="/root/bin"
hmFolder=${rootFolder}/drax-hmIp
keysPath="/root/keys.json"
relaysPath="/root/relays.json"

if [ ! -d $rootFolder ]
then
        echo "Creating folder..."
        mkdir -p $rootFolder
fi

if [ ! -f $keysPath ]
then
        echo "touching keys file..."
        touch $keysPath
        echo "{\"keys\": []}" > $keysPath
fi
chmod 777 $keysPath

if [ ! -f $relaysPath ]
then
        echo "touching keys file..."
        touch $relaysPath
        echo "{\"relays\": []}" > $relaysPath
fi
chmod 777 $relaysPath

cd $rootFolder

if [ -d $hmFolder ]
then
        echo "removing existing folder..."
        rm -rf $hmFolder
fi

wget https://github.com/applica-of-things/drax-homematicip/archive/refs/heads/main.zip

unzip main.zip

rm main.zip
mv drax-homematicip-main drax-hmIp
rm -rf drax-homematicip-main main.zip
cd drax-hmIp
npm install

while true
do
        node main.js "https://draxcloud.com/trv"
        /bin/sleep 5
done
