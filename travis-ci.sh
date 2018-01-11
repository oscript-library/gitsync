

GITNAME="${GIT_NAME:-"ci"}"
GITEMAIL="${GIT_EMAIL:-"ci@me"}"

git config --global user.name $GITNAME
git config --global user.email $GITEMAIL


wget -O os.deb http://oscript.io/downloads/1_0_19/onescript-engine_1.0.19_all.deb
sudo dpkg -i *.deb; sudo apt install -f

rm os.deb
# if [ "$TRAVIS_OS_NAME" = "linux" ]; then 
    # if [ ! test $(wine --version) ]; then

    echo "Устанавливаю Wine"
    # add-apt-repository ppa:ubuntu-wine/ppa
    apt-get update
    apt-get install -ywine winetricks
   
    # fi
# fi


opm install 1testrunner; 
opm install 1bdd; 

opm install; 

opm test; 
