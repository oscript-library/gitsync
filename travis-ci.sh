

GITNAME="${GIT_NAME:-"ci"}"
GITEMAIL="${GIT_EMAIL:-"ci@me"}"

set -e

git config --global user.name $GITNAME
git config --global user.email $GITEMAIL

echo "Устанавливаю версию OScript <$OSCRIPT_VERSION>"
curl http://oscript.io/downloads/$OSCRIPT_VERSION/deb > oscript.deb 
dpkg -i oscript.deb 
rm -f oscript.deb

echo "Установка зависимостей"
opm install 1testrunner; 
opm install 1bdd;
opm install coverage;
opm update opm 

opm install; 
opm run install-opm-global;

echo "Запуск тестирования пакета"
opm run coverage; 
