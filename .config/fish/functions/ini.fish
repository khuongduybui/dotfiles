# Defined in /tmp/fish.I0sDBE/ini.fish @ line 2
function ini
	if test (count $argv) = 2
        sed -nr "/^\[$argv[1]\]/ { :l /^$argv[2] *=/ { s/.*= *//; p; q;}; n; b l;}"
    else if test (count $argv) = 1
        awk "/\[$argv[1]\]/,/\$^/"
    else
        echo "Usage: ini <section> <key>"
    end
end
