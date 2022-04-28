# Defined in /tmp/fish.u2EzPk/ssh-init.fish @ line 2
function ssh-init
    mkdir -p ~/.ssh-agent
    if test -f ~/.ssh-agent/pid
        if ps aux | grep (cat ~/.ssh-agent/pid) | grep ssh-agent >/dev/null
            echo -n 'Agent pid '
            cat ~/.ssh-agent/pid
            set -x SSH_AGENT_PID (cat ~/.ssh-agent/pid)
            set -x SSH_AUTH_SOCK (cat ~/.ssh-agent/sock)
        else
            rm ~/.ssh-agent/*
            bass 'eval $(ssh-agent)'
        end
    else
        bass 'eval $(ssh-agent)'
    end

    echo $SSH_AGENT_PID >~/.ssh-agent/pid
    echo $SSH_AUTH_SOCK >~/.ssh-agent/sock
    set -xg SSH_AGENT_PID (cat ~/.ssh-agent/pid)
    set -xg SSH_AUTH_SOCK (cat ~/.ssh-agent/sock)

    test -x ~/bin/rsync-ssh.sh
    ~/bin/rsync-ssh.sh
    ssh-add ~/.ssh/*.pem
    ssh-add ~/.ssh/*.pem-cert.pub
end
