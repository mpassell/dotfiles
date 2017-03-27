# Path to your oh-my-zsh configuration.
ZSH=~/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="robbyrussell"

# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

# Set to this to use case-sensitive completion
# CASE_SENSITIVE="true"

# Comment this out to disable bi-weekly auto-update checks
# DISABLE_AUTO_UPDATE="true"

# Uncomment to change how often before auto-updates occur? (in days)
# export UPDATE_ZSH_DAYS=13

# Uncomment following line if you want to disable colors in ls
# DISABLE_LS_COLORS="true"

# Uncomment following line if you want to disable autosetting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment following line if you want to disable command autocorrection
# DISABLE_CORRECTION="true"

# Uncomment following line if you want red dots to be displayed while waiting for completion
# COMPLETION_WAITING_DOTS="true"

# Uncomment following line if you want to disable marking untracked files under
# VCS as dirty. This makes repository status check for large repositories much,
# much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(git python ruby go pip mvn svn osx gradle rvm)

source $ZSH/oh-my-zsh.sh

export EDITOR=/usr/local/bin/emacs

export JAVA_HOME=/Library/Java/Home

# Customize to your needs...
export PATH=/usr/local/bin:$PATH:/usr/bin:/bin:/usr/sbin:/sw/bin

# Include this if you have Maven 3.x and want to perform parallel builds (eg. 4 = 4 concurrent threads, 1C = 1 x <# of CPU cores), etc...)
export BUILD_PARALLEL_THREADS_COUNT=1C

export DEPLOY_STATIC=yes
export PROJECTS_HOME=~/git_checkouts
export PUSH_HOME=$PROJECTS_HOME/cg-build/local/devbox-push
export CG_MAIN=$PROJECTS_HOME/cg-main

ssh-add -A

[[ -s `brew --prefix`/etc/autojump.sh ]] && . `brew --prefix`/etc/autojump.sh

current_git_branch() {
    git branch | grep \* | awk '{ print $2 }'
}
# a smart git checkout, with no args it switches to last branch.
gch() {
    if [ -n "$1" ]; then
	echo `current_git_branch` >"/tmp/last_git_branch_used.txt"
	git checkout "$@"
    else
	if [ ! -f "/tmp/last_git_branch_used.txt" ]; then echo >&2 "ERROR: Please run gch with 1 argument first."
	else
	    echo `current_git_branch` >"/tmp/last_git_branch_used.temp"
	    git checkout `cat /tmp/last_git_branch_used.txt`
	    mv "/tmp/last_git_branch_used."{temp,txt}
	fi
    fi
}

#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
[[ -s "${HOME}/.sdkman/bin/sdkman-init.sh" ]] && source "${HOME}/.sdkman/bin/sdkman-init.sh"

test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"
