# Fish abbreviations, sourced in ~/.config/fish/abbreviations.fish

abbr my-setup 'curl -sL https://git.io/JPi6g >/tmp/setup.sh; bash /tmp/setup.sh'
abbr ssh-ec2 'ssh -i ~/.ssh/ec2.pem -l ec2-user'
abbr ssh-raw 'ssh -F /dev/null'
abbr sshp 'ssh -o PreferredAuthentications=password'
abbr update-git-ll 'git config user.email "duy.bui@lunarline.com"; git config user.signingkey 083EF93045D6B22C'
abbr update-git-ct 'git config user.email "duy.bui@clevertech.biz"; git config user.signingkey 603790593AB493EA'
abbr update-git-msi 'git config user.email "duy.bui@motorolasolutions.com"; git config user.signingkey F9F596B7934A7B17'
abbr update-font 'curl -s https://api.github.com/repos/adam7/delugia-code/releases/latest | jq -r ".assets[] | select(.name | test(\"Complete.ttf\")) | .browser_download_url" | xargs wget -q -O ~/setup/Delugia.Nerd.Font.Complete.ttf; curl -s https://api.github.com/repos/adam7/delugia-code/releases/latest | jq -r ".assets[] | select(.name | test(\"Book.ttf\")) | .browser_download_url" | xargs wget -q -O ~/setup/Delugia.Nerd.Font.Book.ttf'
abbr rclone-code 'rclone sync ~/code onedrive:code --exclude \'**/node_modules/**/*\' --links'

abbr a add-abbr
abbr acc accounts
abbr bass replay
abbr bax replay
abbr d dot
abbr c c2c
abbr v view
abbr e edit
abbr s settings
abbr cmd command
abbr cdw 'cd ~/winhome'
abbr exit 'true; exit'

abbr ghb 'gh branch'
abbr gdf 'git diff --ignore-space-change'
abbr gdft 'git difftool -y --ignore-space-change'
abbr gb 'git branch'
abbr gbe 'git checkout --orphan'
abbr gbr 'git branch -r'
abbr gbD 'git branch -D'
abbr gbd 'git branch -d'
abbr gbdr 'git push --delete origin'
abbr gco 'git checkout'
abbr gl 'git lg'
abbr b 'bit status'
abbr g 'git status'
abbr y yarn
abbr yx 'yarn exec'
abbr ya 'yarn add'
abbr yad 'yarn add -D'
abbr ycu 'yarn upgrade-interactive --latest'
abbr p pnpm
abbr px pnpx
abbr pi 'pnpm install'
abbr pid 'pnpm install --save-dev'

abbr azrcc 'git clone git@ssh.dev.azure.com:v3/LunarlineProducts/'

abbr ghcc 'gh repo clone'
abbr drcc 'gh repo clone msi-activeeye/'
abbr bahcc 'gh repo clone Bijles-aan-Huis-B-V/'

abbr awscc 'git clone codecommit://'
abbr ssm 'aws ssm start-session --document-name AWS-StartInteractiveCommand --parameters command="bash -l" --target'
abbr bsm 'aws ssm start-session --document-name SSM-Bitnami --target'
abbr region 'aws configure set region'
abbr r53-ip 'curl -s https://ip-ranges.amazonaws.com/ip-ranges.json | jq -r \'.prefixes[] | select(.service == "ROUTE53_HEALTHCHECKS") | .ip_prefix\''

abbr ipc 'assume --console'
abbr mpc 'assume --browser-profile wasp --console'
abbr ipe 'assume --env'

abbr jb 'jenkins-build'

abbr edge microsoft-edge
abbr winget 'winget.exe'
abbr winst 'winget.exe install'
abbr wsl 'wsl.exe'
abbr wez '~/winhome/OneDrive/Software/scratch/WezTerm/wezterm.exe start --'
abbr awscli 'aws --cli-auto-prompt'
abbr myid 'bw sync; bw list items | jq -r ".[] | select(.type == 4)"'
abbr dc 'docker compose'
abbr dcb 'docker compose build'
abbr dce 'docker compose exec'
abbr dcl 'docker compose logs'
abbr up 'docker compose up'
abbr ub 'docker compose up --build'
abbr ubd 'docker compose up --build -d'
abbr down 'docker compose down -v --remove-orphans'
abbr docker-inspect-healthcheck 'docker inspect --format="{{json .State.Health}}"'
abbr dih 'docker inspect --format="{{json .State.Health}}"'
abbr venv 'test -d venv; and source venv/bin/activate.fish'
abbr virtualenv 'virtualenv -p ~/.asdf/shims/python venv'
abbr weather 'curl https://wttr.in/'
abbr playbook 'ansible-playbook -e \'ansible_python_interpreter="\'(which python)\'"\''
