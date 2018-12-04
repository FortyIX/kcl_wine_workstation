#/bin/bash

# A POSIX variable
OPTIND=1         # Reset in case getopts has been used previously in the shell.


download_link=0
wine_version=2.22
install_dir=$HOME

function install_wine {
    local bitnes=$(echo $1 | rev | cut -c -2 | rev)
    local download_link="https://www.playonlinux.com/wine/binaries/linux-$1/PlayOnLinux-wine-$wine_version-linux-$1.pol"
    wget -c $download_link -P /tmp
    mkdir $install_dir/wine$bitnes
    cd $install_dir/wine$bitnes
    tar vxf /tmp/PlayOnLinux-wine-2.22-linux-$1.pol wineversion/$wine_version/ --strip-components=2
}

function show_help {
    echo "-h is for help"
    echo "-i <x86/amd64> is for installing wine, default is amd64"
    echo "source: $0 <86/64> , to enable wine"
}

while getopts "h?i:" opt; do
    case "$opt" in
    h|\?)
        show_help
        exit 0
        ;;
    i)  install_wine $OPTARG
        ;;
    esac
done

export PATH=$PATH:$install_dir/wine$1/bin
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$install_dir/wine$1/lib::$install_dir/wine$1/lib64
export WINEPREFIX=$HOME/.wine$1 

# shift $((OPTIND-1))

# [ "${1:-}" = "--" ] && shift

echo "install=$install Leftovers: $@"

# End of file