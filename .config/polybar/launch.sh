killall polybar
if type "xrandr"; then
  for m in $(xrandr --query | grep " connected" | cut -d" " -f1); do
    MONITOR=$m polybar --reload main --config=$HOME/.config/polybar/config.ini &
  done
else
  polybar --reload main &
fi
