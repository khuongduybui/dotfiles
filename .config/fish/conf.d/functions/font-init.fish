function font-init
    sudo mkdir -p /etc/fonts
    if test -f /etc/fonts/local.conf
        if not grep -q /etc/fonts/local.conf -e 'AppData/Local/Microsoft/Windows/Fonts'
            echo -n Adding User fonts ...
            sudo sed -i "s|<fontconfig>|<fontconfig>\n    <dir>$W/AppData/Local/Microsoft/Windows/Fonts</dir>|" /etc/fonts/local.conf
            echo Done
        end
        if not grep -q /etc/fonts/local.conf -e (wslpath 'C:/Windows/Fonts')
            echo -n Adding System fonts ...
            sudo sed -i "s|<fontconfig>|<fontconfig>\n    <dir>"(wslpath 'C:/Windows/Fonts')"</dir>|" /etc/fonts/local.conf
            echo Done
        end
    else
        info 'Checking Windows fonts into WSL'
        echo '<?xml version="1.0"?>' | sudo tee /etc/fonts/local.conf
        echo '<!DOCTYPE fontconfig SYSTEM "fonts.dtd">' | sudo tee -a /etc/fonts/local.conf
        echo '<fontconfig>' | sudo tee -a /etc/fonts/local.conf
        echo "    <dir>"(wslpath 'C:/Windows/Fonts')"</dir>" | sudo tee -a /etc/fonts/local.conf
        echo "    <dir>$W/AppData/Local/Microsoft/Windows/Fonts</dir>" | sudo tee -a /etc/fonts/local.conf
        echo '</fontconfig>' | sudo tee -a /etc/fonts/local.conf
    end
end
