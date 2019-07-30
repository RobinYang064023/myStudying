# install
sudo apt-get update && sudo apt-get upgrade
sudo apt-get install tmux zsh
sudo usermod -s /usr/bin/zsh $(whoami)

# change theme
sudo apt install zsh-theme-powerlevel9k
echo "source /usr/share/powerlevel9k/powerlevel9k.zsh-theme" >> ~/.zshrc
sudo apt install zsh-syntax-highlighting
echo "source /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" >> ~/.zshrc

# apply powerline for vim
sudo apt-get install python3-pip
pip3 install --user powerline-status
touch .vimrc
echo "set laststatus=2
set t_Co=256
python3 from powerline.vim import setup as powerline_setup
python3 powerline_setup()
python3 del powerline_setup" > .vimrc

cd
git clone https://github.com/gpakosz/.tmux.git
ln -s -f .tmux/.tmux.conf
cp .tmux/.tmux.conf.local .

