WEB_HOME=$HOME/work/shora/shora-web
API_HOME=$HOME/work/shora/shora-api

kitty @ launch --type=os-window --cwd $WEB_HOME --tab-title "Web" --hold npm run dev
kitty @ launch --type=tab --cwd $WEB_HOME --tab-title "Vim" --hold --keep-focus nvim 
kitty @ launch --type=tab --cwd $WEB_HOME --tab-title "Git" --hold --keep-focus git status
kitty @ launch --type=tab --cwd $WEB_HOME --tab-title "Shell" --keep-focus

kitty @ launch --type=os-window --cwd $API_HOME --title "API" --hold npm run start:dev
kitty @ launch --type=tab --cwd $API_HOME --tab-title "Vim" --hold --keep-focus nvim 
kitty @ launch --type=tab --cwd $API_HOME --tab-title "Git" --hold --keep-focus git status
kitty @ launch --type=tab --cwd $API_HOME --tab-title "Shell" --keep-focus
