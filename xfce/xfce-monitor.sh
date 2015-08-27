#!/bin/bash
sleep 5
if (xrandr | grep "VGA1 disconnected"); then
    xrandr --output HDMI1 --off --output LVDS1 --mode 1366x768 --pos 0x0 --rotate normal --output DP1 --off --output VGA1 --off
    xfconf-query -c xfce4-panel -p /panels/panel-1/output-name -s LVDS1
else    
    xrandr --output HDMI1 --off --output LVDS1 --mode 1366x768 --pos 0x0 --rotate normal --output DP1 --off --output VGA1 --mode 1920x1080 --pos 1366x0 --rotate normal
    xfconf-query -c xfce4-panel -p /panels/panel-1/output-name -s VGA1
fi
