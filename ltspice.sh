if [ ! -d wine64 ]; then
    bash ./wine.sh -i amd64
fi

source ./wine.sh 64 

if [ ! -d ltspice ]; then
    git clone https://github.com/M4a1x/ltspice
    cd ltspice
    git checkout 17
fi  

wine XVIIx64.exe