

GITNAME="${GIT_NAME:-"ci"}"
GITEMAIL="${GIT_EMAIL:-"ci@me"}"

git config --global user.name $GITNAME
git config --global user.email $GITEMAIL



if [ "$TRAVIS_OS_NAME" = "linux" ]; then 
    if [ ! test $(wine --version) ]; then

    echo "Устанавливаю Wine"
    add-apt-repository ppa:ubuntu-wine/ppa
    apt-get update
    apt-get install wine1.8 winetricks
   
    fi
fi

opm install; 
opm install 1testrunner; 
opm install 1bdd; 
opm test; 
