# Defined in /tmp/fish.H6lHps/espanso.fish @ line 2
function espanso
  if type -qf espanso
    command espanso $argv
  else if test -f ~/winhome/OneDrive/Software/scratch/espanso/espansod.exe
    ~/winhome/OneDrive/Software/scratch/espanso/espansod.exe $argv
  else
    echo espanso not found.
  end
end
