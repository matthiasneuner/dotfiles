# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
for condapath in "/home/matthias/constitutive_modeling/miniforge3" "/home/matthias/constitutive_modeling/mambaforge3" "/home/matthias/anaconda3"; do
    if [ -f "$condapath/bin/conda" ]; then
        __conda_setup="$('$condapath/bin/conda' 'shell.bash' 'hook' 2> /dev/null)"
        if [ $? -eq 0 ]; then
            eval "$__conda_setup"
            conda activate base 2>/dev/null || true
        else
            if [ -f "$condapath/etc/profile.d/conda.sh" ]; then
                . "$condapath/etc/profile.d/conda.sh"
                conda activate base 2>/dev/null || true
            else
                export PATH="$condapath/bin:$PATH"
            fi
        fi
        unset __conda_setup
        break
    fi
done
# <<< conda initialize <<<

# User local bin
if [ -d "/home/matthias/.local/bin" ]; then
    export PATH="/home/matthias/.local/bin:$PATH"
fi

if [ "${HOSTNAME}" = "x9" ]; then
    TEXTCOLOR=35 #purple
elif [ "${HOSTNAME}" = "rabbit" ]; then
    TEXTCOLOR=35 #purple
elif [ "${HOSTNAME}" = "ryzen23-3-neuner" ]; then
    TEXTCOLOR=32 # green
elif [ "${HOSTNAME}" = "matthias-pc" ]; then
    TEXTCOLOR=32 # green
elif [ "${HOSTNAME}" = "leo4.uibk.ac.at" ]; then
    TEXTCOLOR=34 # blue 
elif [ "${HOSTNAME}" = "leo5.uibk.ac.at" ]; then
    TEXTCOLOR=31 # red
fi

[[ $- != *i* ]] && return

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
		PS1='\[\033[01;31m\][\h\[\033[01;36m\] ${PWD/#$HOME/\~}\[\033[01;31m\]]\$\[\033[00m\] '
	else
		PS1='\[\033[01;${TEXTCOLOR}m\][\u@\h\[\033[01;37m\] ${PWD/#$HOME/\~}\[\033[01;${TEXTCOLOR}m\]]\$\[\033[00m\] '
	fi

	alias ls='ls --color=auto'
	alias grep='grep --colour=auto'
	alias egrep='egrep --colour=auto'
	alias fgrep='fgrep --colour=auto'
else
	if [[ ${EUID} == 0 ]] ; then
		# show root@ when we don't have colors
		PS1='\u@\h \W \$ '
	else
		PS1='\u@\h \w \$ '
	fi
fi

unset use_color safe_term match_lhs sh

alias cp="cp -i"                          # confirm before overwriting something
alias df='df -h'                          # human-readable sizes
alias free='free -m'                      # show sizes in MB
alias np='nano -w PKGBUILD'
alias more=less

xhost +local:root > /dev/null 2>&1

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

#
# # ex - archive extractor
# # usage: ex <file>
ex ()
{
  if [ -f $1 ] ; then
    case $1 in
      *.tar.bz2)   tar xjf $1   ;;
      *.tar.gz)    tar xzf $1   ;;
      *.bz2)       bunzip2 $1   ;;
      *.rar)       unrar x $1     ;;
      *.gz)        gunzip $1    ;;
      *.tar)       tar xf $1    ;;
      *.tbz2)      tar xjf $1   ;;
      *.tgz)       tar xzf $1   ;;
      *.zip)       unzip $1     ;;
      *.Z)         uncompress $1;;
      *.7z)        7z x $1      ;;
      *)           echo "'$1' cannot be extracted via ex()" ;;
    esac
  else
    echo "'$1' is not a valid file"
  fi
}

# better yaourt colors
export YAOURT_COLORS="nb=1:pkg=1:ver=1;32:lver=1;45:installed=1;42:grp=1;34:od=1;41;5:votes=1;44:dsc=0:other=1;35"

# added by Anaconda3 installer
# export PATH="/home/matthias/anaconda3/bin:$PATH"  # commented out by conda initialize

alias ll='ls -lh'
if [ -f "$HOME/constitutive_modeling/next_v2611/EdelweissFE/edelweissfe/_cli/edelweissfe.py" ]; then
    alias edelweiss='python ~/constitutive_modeling/next_v2611/EdelweissFE/edelweissfe/_cli/edelweissfe.py'
elif [ -f "$HOME/constitutiveModelling/EdelweissFE/edelweiss.py" ]; then
    alias edelweiss='python ~/constitutiveModelling/EdelweissFE/edelweiss.py'
fi

if [ -f "/home/matthias/abaqus-2024-EL7-gcdp-viscoplasticity.sif" ]; then
    alias abaqus="apptainer exec --nv /home/matthias/abaqus-2024-EL7-gcdp-viscoplasticity.sif abaqus"
elif [ -f "/home/matthias/abaqus-2019-centos-7.simg" ]; then
    alias abaqus="singularity exec --nv /home/matthias/abaqus-2019-centos-7.simg abaqus"
fi

alias wbsp='python ~/constitutiveModelling/Abaqus-Workbench/workbenchJobSinglePoint.py'
alias vim='PATH=/usr/bin:$PATH vim'
alias mpfem='singularity exec /home/matthias/constitutiveModelling/SingularityMPFEM/mpFEM.img /mpFEM/mpFEM'
alias mountainmaster='python ~/constitutiveModelling/MountainMaster/meshgenerator.py'
alias ensight='singularity exec --nv  ~/ansys19-centos-7.simg /ansys/ansys_inc/v194/CEI/bin/ensight194'
alias ens_checker='singularity exec ~/constitutiveModelling/SingularityAnsys/ansys19-centos-7.simg /ansys/ansys_inc/v194/CEI/bin/ens_checker'

if [ -e /etc/profile.d/vte.sh ]; then
    . /etc/profile.d/vte.sh
fi

alias sudo='sudo -E'
alias config='/usr/bin/git --git-dir=/home/matthias/.cfg/ --work-tree=/home/matthias'

# if matebook special includes found ..
source matebookincludes.sh  &> /dev/null || true
