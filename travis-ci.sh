

GITNAME="${GIT_NAME:-"ci"}"
GITEMAIL="${GIT_EMAIL:-"ci@me"}"

set -e

git config --global user.name $GITNAME
git config --global user.email $GITEMAIL

echo "Устанавливаю версию OScript <$OSCRIPT_VERSION>"
curl http://oscript.io/downloads/$OSCRIPT_VERSION/deb > oscript.deb 
dpkg -i oscript.deb 
rm -f oscript.deb
echo "==================================="
echo "Установка зависимостей тестирования"
opm install 1testrunner; 
opm install 1bdd;
opm install coverage;

opm install; 

# cat /usr/bin/opm
echo "==================================="

echo "Запуск тестирования пакета"
oscript ./tasks/coverage.os; 
