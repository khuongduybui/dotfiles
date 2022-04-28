# Defined in /tmp/fish.XSKyMm/dotenv.fish @ line 2
function dotenv
	if test -e .env
        if not test (count $argv) = 0
            posix-source .env
        else
            set -l num (grep -E '^export ' .env | wc -l)
            if not test num = 0
                echo "$num variables exported from .env."
                bax source .env
            end
        end
    end
end
