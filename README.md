# ptools
Tools and scripts to boost productivity across machines.

```
# vim & tmux
curl https://raw.githubusercontent.com/shelvinskyi/ptools/master/.vimrc -o ~/.vimrc \
  && curl https://raw.githubusercontent.com/shelvinskyi/ptools/master/.tmux.conf -o ~/.tmux.conf \
  && vim -c "PlugInstall"

# ipython
mkdir -p ~/.ipython/profile_default/ \
  && https://raw.githubusercontent.com/shelvinskyi/ptools/master/ipython_config.py -o ~/.ipython/profile_default/ipython_config.py
```
