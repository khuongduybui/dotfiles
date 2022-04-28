# Defined in /tmp/fish.Kzm86z/vf-init.fish @ line 2
function vf-init
    vf deactivate
    test -f .venv; and vf rm (cat .venv)
    vf new -p (asdf which python) --connect (basename (dirname (pwd)))-(basename (pwd))
end
