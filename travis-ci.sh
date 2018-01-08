

GITNAME="${GIT_NAME:-"ci"}"
GITEMAIL="${GIT_EMAIL:-"ci@me"}"

git config --global user.name $GITNAME
git config --global user.email $GITEMAIL

if [ $TRAVIS_OS_NAME == "linux" ]; then 
    export CXX="g++-4.9" CC="gcc-4.9" DISPLAY=:99.0;
    linux32 apt-get install -y -qq --no-install-recommends wine
fi

opm install; 
opm install 1testrunner; 
opm install 1bdd; 
opm test; 
