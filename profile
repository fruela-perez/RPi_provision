# ~/.profile: executed by the command interpreter for login shells.
# This file is not read by bash(1), if ~/.bash_profile or ~/.bash_login
# exists.
# see /usr/share/doc/bash/examples/startup-files for examples.
# the files are located in the bash-doc package.

# the default umask is set in /etc/profile; for setting the umask
# for ssh logins, install and configure the libpam-umask package.
#umask 022

# if running bash
if [ -n "$BASH_VERSION" ]; then
    # include .bashrc if it exists
    if [ -f "$HOME/.bashrc" ]; then
	. "$HOME/.bashrc"
    fi
fi

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/bin" ] ; then
    PATH="$HOME/bin:$PATH"
fi

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/.local/bin" ] ; then
    PATH="$HOME/.local/bin:$PATH"
fi

PS1=" $ "

# -- keystroke savers --
alias cl='clear'
alias ll='ls -l'
alias lla='ls -la'

# -- System info --
alias memu='ps -e -o rss=,args= | sort -b -k1,1n | pr -TW120'
alias psg='ps aux | grep' #requires an argument

# -- apt --
alias update='sudo apt-get update && sudo apt-get upgrade && sudo apt-get autoremove'

# -- Temperaturas --
alias cputemp="echo $((`cat /sys/class/thermal/thermal_zone0/temp`/1000))"
alias gputemp="vcgencmd measure_temp|cut -c6-9"

PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/local/games:/usr/games:/usr/local/go/bin
GOPATH=/home/pi/golang
