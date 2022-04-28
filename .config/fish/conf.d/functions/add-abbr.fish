# Defined in /tmp/fish.B4sd2E/add-abbr.fish @ line 2
function add-abbr
    echo abbr $argv >>~/setup/abbreviations.fish
    reload
end
