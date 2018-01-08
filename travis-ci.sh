

GITNAME="${GIT_NAME:-"ci"}"
GITEMAIL="${GIT_EMAIL:-"ci@me"}"

git config --global user.name $GITNAME
git config --global user.email $GITEMAIL

# if [ $TRAVIS_OS_NAME = "linux" ]; then 
    echo "Устанавливаю Wine"
    linux32 apt-get install -y -qq --no-install-recommends wine
# fi

opm install; 
opm install 1testrunner; 
opm install 1bdd; 
opm test; 
