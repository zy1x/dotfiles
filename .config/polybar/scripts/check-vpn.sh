if (nmcli c show --active | grep 'tun') &>/dev/null; then
    echo " ON"
else 
    echo " OFF"
fi