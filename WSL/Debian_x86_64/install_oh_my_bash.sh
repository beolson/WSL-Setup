#!/bin/bash -i

echo '******************* install Oh My Bash starting'


wget -qO- https://raw.githubusercontent.com/ohmybash/oh-my-bash/master/tools/install.sh | bash
sed -i 's/^OSH_THEME.*/OSH_THEME="agnoster"/' ~/.bashrc
echo '******************* install Oh My Bash completed'
