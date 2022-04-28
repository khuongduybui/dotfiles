function __missing_path
    pathchk $argv[1]
    and test -d $argv[1]
    and not echo $PATH | grep -q (realpath $argv[1])
end
