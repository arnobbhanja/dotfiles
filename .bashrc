#!/bin/env bash
#########################################
##                           ___.      ##
## _____ _______  ____   ____\_ |__    ##
## \__  \\_  __ \/    \ /  _ \| __ \   ##
##  / __ \|  | \/   |  (  <_> ) \_\ \  ##
## (____  /__|  |___|  /\____/|___  /  ##
##      \/           \/           \/   ##
##                                     ##
#########################################

################################################################
# LOCAL VARIABLE
################################################################

ANACONDA=/home/arnob/anaconda3/bin
FLATBUFFERS=/home/arnob/binaries/flatbuffers
GNUGLOBAL=/home/arnob/executables/global/bin
CHROME=/usr/lib/chrome
UNICTAGS=/home/arnob/executables/ctags_bld/bin
DOTFILES='~/dotfiles'
SAVE_CMD="python3 ~/dotfiles/save_command.py"
#phantomjs required for youtube-dl
#PHANTOMJS=/home/arnob/Downloads/phantomjs-2.1.3/bin
LIVE_LATEX_PREVIEW='~/.vim/bundle/vim-live-latex-preview/bin/'
DOT_SETUP_FILE='~/dotfiles/dot_setup.sh'

################################################################
# EXPORT
################################################################

export EDITOR=vim
export MYVIMRC=~/.vimrc
export HISTFILE=~/.bash_history
# better yaourt colors
export YAOURT_COLORS="nb=1:pkg=1:ver=1;32:lver=1;45:installed=1;42:grp=1;34:od=1;41;5:votes=1;44:dsc=0:other=1;35"
export YAY_COLORS="nb=1:pkg=1:ver=1;32:lver=1;45:installed=1;42:grp=1;34:od=1;41;5:votes=1;44:dsc=0:other=1;35"
#export PS1=${debian_chroot:+($debian_chroot)}\u@\h:\w\$ #old value
#export PS1="[\u]:[\W]$" #[username]:[baseWorkingDirectory]
export PATH=$UNICTAGS:$CHROME:$LIVE_LATEX_PREVIEW:$GNUGLOBAL:$PATH:/home/arnob/executables/

################################################################
# ALIAS
################################################################

alias gp="git push"
alias gl="git pull"
alias st="git status"
alias br="git branch"
alias log="git log"
alias emacs="emacs & &> /dev/null"
alias suvim="sudo -E gvim"
#remove unused packages(orphans): if none found o/p :"no targets specified"
alias cleanpac="sudo pacman -Rns $(pacman -Qtdq)"
alias cdp="cd /mnt/windows/projects"
alias diffhead="git diff --ignore-cr-at-eol --ignore-space-at-eol --ignore-all-space --ignore-space-change --ignore-blank-lines HEAD"
alias prp="pipenv run python"
alias psh="pipenv shell"
alias ipshow="ip link show"
alias tux="sudo arpon -d -i wlp3s0 -D"
alias vv="vim ~/.vimrc"
alias vc="vim ~/.vim/sources/custom_functions.vim"
alias va="vim ~/.vim/sources/abbreviations.vim"
alias vs="vim ~/.vim/sources/statusline.vim"
alias vp="vim ~/.vim/sources/plugins.vim"
alias vb="vim ~/.bashrc"
alias sb="source ~/.bashrc"
alias more=less
alias gv="gvim"
alias spac="$SAVE_CMD sudo -i pacman -Sy"
alias syao="$SAVE_CMD yaourt -Sy"
alias v="vim "
alias gv="gvim "
alias vd="vimdiff "
alias gvd="gvimdiff "
alias wg="wget --recursive --timestamping --level=inf --no-remove-listing --convert-links --show-progress --progress=bar:force --no-parent --execute robots=off --compression=auto --verbose --continue --wait=2 --random-wait --reject htm,html,tmp,dstore,db,dll --directory-prefix=guest_dir --regex-type=pcre"
alias cdw="cd /mnt/windows/Users/AB/Downloads/"
alias tv="find media/TV\ Series/ -maxdepth 2 -mindepth 2 -type d  | sed -e 's/^.*\///g' | sort -bdf > list_tv.txt"
alias u0="du --max-depth=0 -h"
alias u1="du --max-depth=1 -h"
alias l="ls -lrth --color=auto"
alias upe="cat updatelog | xargs -I{} pacman -Qo {} 2>&1 | sed 's/^error:.*owns //g' > noowner && cat noowner | xargs sudo rm -rf"
alias df='df -h'                          # human-readable sizes
alias free='free -m'                      # show sizes in MB
alias grep='grep --colour=auto'
alias egrep='egrep --colour=auto'
alias rsync='rsync -azvhP'

################################################################
# CUSTOM FUNCTIONS
################################################################

function lstcmd(){
  fc -ln "$1" "$1" | sed '1s/^[[:space:]]*//' | xargs echo >> $DOT_SETUP_FILE
}

function lmed(){
  find $1 -maxdepth 2 -mindepth 2 -type d  | sed -e 's/^.*\///g' | sort -bdf > $2
}

function mp(){
  touch $1.cpp && touch $1.in && vim $1.cpp
}

function bench(){
  time $@ 1>/dev/null 2>&1
}

function gpp(){
  echo 'hello'
  /usr/bin/g++ -g -Dfio -o $-std=gnu++17 1 $1.cpp
}

function grl(){
  grep -Rl --exclude-dir={docs,deploy} --include=\*.{cpp,cc,h,H,hpp,xslt,xml,makefile,mk,yml,log\*,ksh,sh} $@ 2>/dev/null
}

function grn(){
  grep -Rn --exclude-dir={docs,deploy} --include=\*.{cpp,cc,h,H,hpp,xslt,xml,makefile,mk,yml,ksh,sh} $@ 2>/dev/null
}
# ex - archive extractor
ex ()
{
  if [ -f $1 ] ; then
    case $1 in
      *.tar.bz2|*.tbz2|*.tb2) tar kxjf $1       ;;
      *.tar.bz|*.tbz)         tar kxjf $1       ;;
      *.tar.gz|*.tgz)         tar kxzf $1       ;;
      *.tar.xz|*.txz)         tar kxJf $1       ;;
      *.lzip)                 tar kxf --lzip $1 ;;
      *.lzop)                 tar kxf --lzop $1 ;;
      *.lzma)                 tar kxf --lzma $1 ;;
      *.tar)                  tar kxf $1        ;;
      *.bz2)                  bunzip2 -kd $1    ;;
      *.rar)                  unrar x $1        ;;
      *.gz)                   gunzip $1         ;;
      *.zip)                  unzip $1          ;;
      *.Z)                    uncompress $1     ;;
      *.7z)                   7z x $1           ;;
      *)                      echo "'$1' cannot be extracted via ex()" ;;
    esac
  else
    echo "'$1' is not a valid file"
  fi
}

# ar - archiver
ar ()
{
  if [ -f $1 ] ; then
    case $1 in
      tbz2) tar kcjf $1       ;;
      tbz)  tar kcjf $1       ;;
      tgz)  tar kczf $1       ;;
      txz)  tar kcJf $1       ;;
      tar)  tar kcf $1        ;;
      lzip) tar kcf --lzip $1 ;;
      lzop) tar kcf --lzop $1 ;;
      lzma) tar kcf --lzma $1 ;;
      *)    echo "'$1' cannot be compressed via ar()" ;;
    esac
  else
    echo "'$1' is not a valid file"
  fi
}
colors() {
	local fgc bgc vals seq0

	printf "Color escapes are %s\n" '\e[${value};...;${value}m'
	printf "Values 30..37 are \e[33mforeground colors\e[m\n"
	printf "Values 40..47 are \e[43mbackground colors\e[m\n"
	printf "Value  1 gives a  \e[1mbold-faced look\e[m\n\n"

	# foreground colors
	for fgc in {30..37}; do
		# background colors
		for bgc in {40..47}; do
			fgc=${fgc#37} # white
			bgc=${bgc#40} # black

			vals="${fgc:+$fgc;}${bgc}"
			vals=${vals%%;}

			seq0="${vals:+\e[${vals}m}"
			printf "  %-9s" "${seq0:-(default)}"
			printf " ${seq0}TEXT\e[m"
			printf " \e[${vals:+${vals+$vals;}}1mBOLD\e[m"
		done
		echo; echo
	done
}

################################################################
##  CONFIG
################################################################

# If not running interactively, don't do anything
 [[ $- != *i* ]] && return

[ -r /usr/share/bash-completion/bash_completion ] && . /usr/share/bash-completion/bash_completion

# Change the window title of X terminals
case ${TERM} in
	xterm*|rxvt*|Eterm*|aterm|kterm|gnome*|interix|konsole*)
		PROMPT_COMMAND='echo -ne "\033]0;${USER}@${HOSTNAME%%.*}:${PWD/#$HOME/\~}\007"'
		;;
	screen*)
		PROMPT_COMMAND='echo -ne "\033_${USER}@${HOSTNAME%%.*}:${PWD/#$HOME/\~}\033\\"'
		;;
esac

use_color=true

# Set colorful PS1 only on colorful terminals.
# dircolors --print-database uses its own built-in database
# instead of using /etc/DIR_COLORS.  Try to use the external file
# first to take advantage of user additions.  Use internal bash
# globbing instead of external grep binary.
safe_term=${TERM//[^[:alnum:]]/?}   # sanitize TERM
match_lhs=""
[[ -f ~/.dir_colors   ]] && match_lhs="${match_lhs}$(<~/.dir_colors)"
[[ -f /etc/DIR_COLORS ]] && match_lhs="${match_lhs}$(</etc/DIR_COLORS)"
[[ -z ${match_lhs}    ]] \
	&& type -P dircolors >/dev/null \
	&& match_lhs=$(dircolors --print-database)
[[ $'\n'${match_lhs} == *$'\n'"TERM "${safe_term}* ]] && use_color=true

if ${use_color} ; then
	# Enable colors for ls, etc.  Prefer ~/.dir_colors #64489
	if type -P dircolors >/dev/null ; then
		if [[ -f ~/.dir_colors ]] ; then
			eval $(dircolors -b ~/.dir_colors)
		elif [[ -f /etc/DIR_COLORS ]] ; then
			eval $(dircolors -b /etc/DIR_COLORS)
		fi
	fi

	if [[ ${EUID} == 0 ]] ; then
		PS1='\[\033[01;31m\][\h\[\033[01;36m\] \w\[\033[01;31m\]]\$\[\033[00m\] '
	else
		PS1='\[\033[01;32m\][\u@\h\[\033[01;37m\] \w\[\033[01;32m\]]\$\[\033[00m\] '
	fi

else
	if [[ ${EUID} == 0 ]] ; then
		# show root@ when we don't have colors
		PS1='\u@\h \w \$ '
	else
		PS1='\u@\h \w \$ '
	fi
fi

# get rid of annoying dark blue color on black bg on terminal
LS_COLORS=$LS_COLORS:'di=01;33'
export LS_COLORS

unset use_color safe_term match_lhs sh

# running gui apps as root
xhost +local:root > /dev/null 2>&1
# sudo with tab completion
complete -cf sudo

# Bash won't get SIGWINCH if another process is in the foreground.
# Enable checkwinsize so that bash will check the terminal size when
# it regains control.  #65623
# http://cnswww.cns.cwru.edu/~chet/bash/FAQ (E11)
shopt -s checkwinsize

shopt -s expand_aliases

# export QT_SELECT=4

# Enable history appending instead of overwriting.  #139609
shopt -s histappend
shopt -s globstar
