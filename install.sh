
# installing pathogen
mkdir -p .vim/autoload .vim/bundle 
curl -LSso .vim/autoload/pathogen.vim https://tpo.pe/pathogen.vim

# symlinking all the vim stuff
ln -sf ptools/.vim ~/.vim
ln -sf ptools/.vimrc ~/.vimrc
ln -sf ptools/.powerline ~/.powerline
ln -sf ptools/.tmux.conf ~/.tmux.conf
