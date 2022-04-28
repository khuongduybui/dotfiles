# Defined in /tmp/fish.qBvRVm/browser-init.fish @ line 2
function browser-init
  if not test -e ~/.browser            
    info 'Searching for Browsers'            
    if type -q wslview                
      set -x BROWSER (which wslview)            
    else if type -q microsoft-edge                
      set -x BROWSER (which microsoft-edge)            
    else if type -q microsoft-edge-dev                
      set -x BROWSER (which microsoft-edge-dev)            
    end            
    if test -n "$BROWSER"                
      echo "$BROWSER" | tee ~/.browser            
      set -e BROWSER
      set -xU BROWSER (command cat ~/.browser)
    end        
  end
end
