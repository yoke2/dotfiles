set -g -x PATH /usr/local/bin $PATHTH /usr/local/bin $PATH
set -g -x fish_greeting ''
set -U fish_user_paths $HOME/miniconda3/bin $fish_user_paths
source (conda info --root)/etc/fish/conf.d/conda.fish
