function Proverka_OS {
    os_info=$(uname -a)
    proverka_ethtool=$(ethtool --version >/dev/null)
    if [[ $os_info == *"Debian"* || $os_info == *"Ubuntu"* ]]; then
        echo "Проверка установленного пакета ETHTOOL"
        if [[ $proverka_ethtool == *"ethtool version"* ]]; then
            echo -e "\nEthtool установлен\n"
        else
            sudo apt update && sudo apt install ethtool -y
        fi
#    elif [[ $os_info == *"Linux calculate"* ]]; then
#        echo "Проверка на наличие нужного пакета - parallel - для будущего пинга сети в несколько потоков одновременно"
#        if [[ $proverka_parallel == *"License"* ]]; then
#            echo -e "\nParallel установлен\n"
#        elif [[ $proverka_parallel == *"Error"* ]]; then
#            parallel -V --unsafe >/dev/null
#            if [[ $(parallel -V --unsafe) == *"License"* ]]; then
#               echo -e "\nParallel установлен\n"
#            fi
#        else
#            cl-update -s && sudo emerge sys-process/parallel
#        fi
    elif [[ $os_info == *"MANJARO"* || $os_info == *"Linux archlinux"* ]]; then
        echo "Проверка установленного пакета ETHTOOL"
        if [[ $proverka_ethtool == *"ethtool version"* ]]; then
            echo -e "\nEthtool установлен\n"
        else
            sudo pacman -Sy && sudo pacman -S ethtool
        fi

    else
        echo "Ты используешь хуй знает что..."
    fi
}
Proverka_OS
