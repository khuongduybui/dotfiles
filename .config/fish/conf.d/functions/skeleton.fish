# Defined in /tmp/fish.dY16ru/skeleton.fish @ line 2
function skeleton
    if git remote | grep -q skeleton
        git remote get-url skeleton
    else
        test -e feathers-gen-specs.json
        and git remote add skeleton https://git-codecommit.us-east-1.amazonaws.com/v1/repos/feathers-plus-api

        test -e aurelia_project
        and git remote add skeleton https://git-codecommit.us-east-1.amazonaws.com/v1/repos/feathers-plus-web
    end
    git fetch skeleton

    set -l current (git branch | grep '*' | sed 's/* //')
    if git branch | grep -q skeleton
        git checkout skeleton
    else
        if test -e static/vendor/materialadmin
            git checkout skeleton/materialadmin -b skeleton
        else if test -e static/dashkit
            git checkout skeleton/dashkit -b skeleton
        else
            git checkout skeleton/master -b skeleton
        end
    end
    git pull
    git checkout $current
end
