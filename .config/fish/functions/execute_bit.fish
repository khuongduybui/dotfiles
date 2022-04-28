# Defined in /tmp/fish.igASpV/execute_bit.fish @ line 2
function execute_bit
    if type -q starship
        starship prompt
    else
        set_color cyan
        echo -n (basename (pwd))
        set_color normal
        echo -n ' on '
        set_color magenta
        echo -n ' '(git branch | grep '*' | sed -e 's/* //')
        set_color green
        echo -n '❯ '
        set_color normal
    end

    set_color $fish_color_command
    echo -n git' '
    set_color $fish_color_param
    echo $argv
    set_color normal

    git $argv
    echo
end
