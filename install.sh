
# installing pathogen
mkdir -p .vim/autoload .vim/bundle 
curl -LSso .vim/autoload/pathogen.vim https://tpo.pe/pathogen.vim

# symlinking all the vim stuff
ln -sf ptools/.vim ~/.vim
ln -sf ptools/.vimrc ~/.vimrc
ln -sf ptools/.powerline.sh ~/.powerline.sh
ln -sf ptools/.utils.sh ~/.utils.sh
ln -sf ptools/.tmux.conf ~/.tmux.conf
mkdir -p ~/.config/alacritty/
cp ptools/alacritty.yml ~/.config/alacritty/
