function __read_confirm
    set -l title 'Confirm'
    set -l message 'Do you want to continue?'

    getopts $argv | while read -l key value
        switch $key
            case title
                set title $value
            case message
                set message $value
        end
    end

    whiptail --title $title --yesno $message 8 64
end
