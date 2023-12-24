perc=$(pmset -g batt | egrep -ow '([0-9]{1,3})[%]' | egrep -ow '[0-9]{1,3}')
power=$(expr $perc + 0)

# if [[ $perc -gt 80 ]]; then
#     echo "数字大于80"
# else
#     echo "数字小于等于80"
# fi

if [[ $power -gt 79 ]] && pmset -g batt | grep -q " charg"; then
  echo 1
else
  echo 0
fi
