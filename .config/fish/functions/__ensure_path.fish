# Defined in /tmp/fish.691mg7/__ensure_path.fish @ line 2
function __ensure_path
	if __missing_path "$argv[1]"
        if string match -q ~ "$argv[1]"
            set -x PATH "$argv[1]" $PATH
        else
            set -x PATH $PATH "$argv[1]"
        end
    end
end
