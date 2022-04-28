# Defined in /tmp/fish.Y6dCyJ/pr.fish @ line 2
function pr
    if not test -d .git
        echo "Not a git repository"
        return 1
    end

    set -l base "master"
    if not test (count $argv) = 0
        set -x base $argv[1]
    end

    set here (pwd)
    set branch (git branch --show-current)

    starship prompt
    set_color $fish_color_command
    echo -n gh
    set_color $fish_color_param
    echo -n ' pr create --base='
    set_color $fish_color_quote
    echo \"$base\"
    set_color normal
    gh pr create --base="$base"

    set title (gh pr view --jq .title --json title)
    set url (gh pr view --jq .url --json url)

    cd ..
    if test (ls | wc -l) -lt 2
        return
    end

    set -l sub_pr 0
    for repo in (ls */.git | grep .git: | sed -e 's|/\.git:||')
        if test $repo = (basename $here)
            continue
        end

        cd $repo
        starship prompt

        set current_branch (git branch --show-current)
        if not test $current_branch = $branch
            set_color $fish_color_autosuggestion
            echo -n 'Skipping '
            set_color $fish_color_quote
            echo -n \"$repo\"
            set_color $fish_color_autosuggestion
            echo -n ' (branch '
            set_color $fish_color_quote
            echo -n \"$current_branch\"
            set_color $fish_color_autosuggestion
            echo -n ', not '
            set_color $fish_color_quote
            echo -n \"$branch\"
            set_color $fish_color_autosuggestion
            echo ')'
            set_color normal
        else
            set -x sub_pr (math "$sub_pr + 1")
            set_color $fish_color_command
            echo -n gh
            set_color $fish_color_param
            echo -n ' pr create --base='
            set_color $fish_color_quote
            echo \"$base\"
            set_color $fish_color_param
            echo -n ' --title='
            set_color $fish_color_quote
            echo \"$title\"
            set_color $fish_color_param
            echo -n ' --body='
            set_color $fish_color_quote
            echo \"See $url\"
            set_color normal
            gh pr create --base="$base" --title="$title" --body="See $url"
        end

        cd -
    end

    cd $here
    if test $sub_pr -gt 0
        starship prompt
        set_color $fish_color_command
        echo -n gh
        set_color $fish_color_param
        echo -n ' pr comment --body='
        set_color $fish_color_quote
        echo \"Please review along with $sub_pr related PRs\"
        set_color normal

        gh pr comment --body "Please review along with $sub_pr related PRs"
    end
end
