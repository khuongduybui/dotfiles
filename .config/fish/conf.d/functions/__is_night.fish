# Defined in /tmp/fish.4fQdnZ/__is_night.fish @ line 2
function __is_night
    set -lx TZ America/New_York
    set -l hours (date +%H)
    test $hours -gt 18
    or test $hours -lt 6
end
