#!/bin/sh

#
# De moment només baixa volum
#

target_vol="$1"
target_host="$2"

if [ -z "${target_host}" ] ; then
  exit 1
fi

print_volume_bar() {
  local count="$1"
  local total="100"

  local open="["
  local pstr="========================================================================="
  local lstr="-------------------------------------------------------------------------"
  local close="]"
  pd=$(( $count * 73 / $total ))
  ld=$(( ( $total - $count ) * 73 / $total ))

  printf "\r%3d.%1d%% [%.${pd}s%-.${ld}s]" $(( $count * 100 / $total )) $(( ($count * 1000 / $total) % 10 )) $pstr $lstr
}

do_ssh() {
  ssh informatica@${target_host} -- $@
}

get_current_volume() {
 do_ssh osascript -e "'output volume of (get volume settings)'"
}

set_volume() {
  do_ssh osascript -e "'set volume output volume ${1}'"
}

w_vol=${target_vol}
wait=5
step=2


c_vol="$( get_current_volume )"

while [ "${c_vol}" -gt "${w_vol}" ] ; do
  print_volume_bar ${c_vol}
  new_vol="$(( ${c_vol} - ${step} ))"
  set_volume ${new_vol}
  print_volume_bar ${new_vol}
  sleep $wait
  c_vol="$( get_current_volume )"
done

echo

