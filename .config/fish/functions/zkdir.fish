# Defined in /tmp/fish.0366Gc/zkdir.fish @ line 2
function zkdir
  mkdir -p $argv[1]; and cd $argv[1]
end
