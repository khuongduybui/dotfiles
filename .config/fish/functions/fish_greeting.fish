# Defined in /tmp/fish.38c0Li/fish_greeting.fish @ line 2
function fish_greeting
    test -n "$AWS_PROFILE"; and echo "☁️ $AWS_PROFILE"
end
