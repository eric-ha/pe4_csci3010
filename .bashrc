# some useful commands for your .bashrc to make things more colorful (if you want)
alias egrep="egrep --color"
alias grep="grep --color"
alias ls="ls -G"  # colorized ls


# A decent stack exchange on color codes: https://unix.stackexchange.com/questions/124407/what-color-codes-can-i-use-in-my-ps1-prompt
# Recommendation: define named variables, then use those variables

# For example, this is the color reset code
RESET="\033[0m"
USER_COLOR="\033[01;34m" #01 makes it bold
C_RED="\033[0;31m"
C_GREEN="\033[0;32m"
C_YELLOW="\033[0;33m"
C_CYAN="\033[0;87m"
C_WHITE="\033[0;37m"

function git_indicator {
    local git_status="$(git status 2> /dev/null)"  # redirect stderr to /dev/null -- we just need it in this variable

    if [[ ! $git_status =~ "working directory clean" ]]; then
      echo -e $C_RED
    elif [[ $git_status =~ "Your branch is ahead of" ]]; then
      echo -e $C_YELLOW
    elif [[ $git_status =~ "nothing to commit" ]]; then
      echo -e $C_GREEN
    else
      echo -e $C_CYAN
    fi
}


function git_branch {
    local git_status="$(git status 2> /dev/null)"
    local on_branch="On branch ([^${IFS}]*)"
    local on_commit="HEAD detached at ([^${IFS}]*)"

    if [[ $git_status =~ $on_branch ]]; then
          local branch=${BASH_REMATCH[1]}
          echo "($branch)" #bam (master) eric
    elif [[ $git_status =~ $on_commit ]]; then
          local commit=${BASH_REMATCH[1]}
          echo "($commit)"
    fi
}

# edit to your heart's content
PS1="\[$C_WHITE\]\n[\W]"          # base of your PS 1
PS1+="\[\$(git_indicator)\]"        # indicates git status
PS1+="\$(git_branch)"           # prints current branch
PS1+="\[$USER_COLOR\] \$\[$RESET\] " # prints out "blah $" -- change this!
#PS1+="\[\033[01;32m\]\] eric \$\[$RESET\] " # prints out "blah $" -- change this!
echo $PS1 #prints PS1 echo statements

# don't forget to export it at the end!
# make sure that you run source ~/.bashrc to see the changes from your PS1!
export PS1
