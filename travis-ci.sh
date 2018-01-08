

GITNAME="${GIT_NAME:-"ci"}"
GITEMAIL="${GIT_EMAIL:-"ci@me"}"

git config --global user.name $GITNAME
git config --global user.email $GITEMAIL

opm install; 
opm install 1testrunner; 
opm install 1bdd; 
opm test; 
