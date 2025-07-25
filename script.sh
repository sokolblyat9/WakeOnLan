function Proverka_OS {
    os_info=$(uname -a)
    proverka_ethtool=$(sudo ethtool --version)
    if [[ $os_info == *"Debian"* || $os_info == *"Ubuntu"* ]]; then
        echo "Проверка установленного пакета ETHTOOL"
        if [[ $proverka_ethtool == *"ethtool version"* ]]; then
            echo -e "\nEthtool установлен\n"
            sleep 3
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
            sleep 3
        else
            sudo pacman -Sy && sudo pacman -S ethtool
        fi

    else
        echo "Ты используешь хуй знает что..."
    fi
}
Proverka_OS


function PROPUSK {
echo -e "\n===========================================================================================\n"
}

function Proverka_CRON {

os_info=$(uname -a)
    if [[ $os_info == *"Debian"* || $os_info == *"Ubuntu"* ]]; then
        echo "Проверка установленного пакета CRONTAB"
        proverka_cron_bubuntu=$(which crontab)
        if [[ $proverka_cron_bubuntu == *"/usr/"* ]]; then
            echo -e "\nCRONTAB установлен\n"
            sleep 3
        else
            sudo apt update && sudo apt install cron -y
            sudo systemctl enable cron && sudo systemctl start cron
        fi

    elif [[ $os_info == *"MANJARO"* || $os_info == *"Linux archlinux"* ]]; then
        echo "Проверка установленного пакета CRONTAB"
        proverka_cron=$(crontab -V)
        if [[ $proverka_cron == *"cronie"* ]]; then
            echo -e "\nCrontab установлен\n"
            sleep 3
        else
            sudo pacman -Sy && sudo pacman -S cron
            sudo systemctl enable cronie && sudo systemctl start cronie
        fi

    else
            echo "Ты используешь хуй знает что..."
    fi
}
Proverka_CRON


function Uznayu_Adapters_and_zapusk_Wake_on_LAN {

uznayu_adapters=$(ip a | awk '/192.168./ {print $NF}')

echo "Запускаю команду для включения Wake on LAN"

sleep 2

sudo ethtool -s $uznayu_adapters wol g
}
Uznayu_Adapters_and_zapusk_Wake_on_LAN

function Avtomatizaciya {

echo "Создам скрипт, который будет запускать CRON"
touch $HOME/cron_wol.sh
sudo chmod 744 $HOME/cron_wol.sh
echo "sudo ethtool -s $uznayu_adapters wol g" > $HOME/cron_wol.sh
PROPUSK
echo -ne "\r\033[KСкопируй команды и вставь в другом окне терминала\n\nСКРИПТ ПОКАЖЕТ ИНФУ 30 СЕКУНД"
PROPUSK
echo ""
echo -e "1) sudo crontab -e"
sleep 15
echo -ne "\r\033[K\033[1A\033[K"
echo -e "Добавь команду в CRON\n\n2) @reboot $HOME/cron_wol.sh"
sleep 15
echo -ne "\r\033[K\033[1A\033[K\r\033[K\033[1A\033[K\r\033[K\033[1A\033[K"
}
Avtomatizaciya

