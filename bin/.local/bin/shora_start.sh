kitty @ launch --type=tab --cwd $HOME/work/shora/shora-web --tab-title "Web" --keep-focus
kitty @ launch --type=tab --cwd $HOME/work/shora/shora-web --tab-title "Vim" --hold --keep-focus nvim 
kitty @ launch --type=tab --cwd $HOME/work/shora/shora-web --tab-title "Git" --hold --keep-focus git status
kitty @ launch --type=tab --cwd $HOME/work/shora/shora-web --tab-title "Shell" --keep-focus
kitty @ close-tab --match "state:focused"
