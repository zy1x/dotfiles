free=$(free -h | awk ' /Mem:/ {print $3}')
echo " $free"