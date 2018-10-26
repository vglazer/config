#!/bin/bash

starting_dir=$(pwd)

conda_path=$(which conda)
found_conda=false
if [[ -x $conda_path ]] ; then
    echo "Found conda at $conda_path"
    found_conda=true
    
    echo "Updating Anaconda..."
    conda update conda 
    conda update anaconda 
    conda clean --all 
    echo "Done updating Anaconda!"
else
    echo "Anaconda not found!"
fi

# Use apt-get on Linux and brew on the Mac
os_type=$(uname)
echo "The type of your OS is $os_type"

if [[ $os_type == "Darwin" ]] ; then
    brew_path=$(which brew)
    if [[ -x $brew_path ]] ; then
        echo "Found brew at $brew_path"

        # Having Anaconda in your PATH is known to confuse Homebrew, so let's get rid of it
        if [[ "$found_conda" == true ]] ; then
            echo "Removing Anaconda from PATH to avoid confusing Homebrew..."
            original_path=$PATH
#           echo "Original PATH: $original_path"
            remove_anaconda='chomp; print(join(":", grep { !/anaconda/ } split(/:/, $_)), "\n");'
            new_path=$(echo $PATH | perl -ne "$remove_anaconda")
#           echo "New PATH: $new_path"
            export PATH=$new_path
            echo "Done removing Anaconda from PATH!"
        fi

        echo "Updating Homebrew..."
        brew update
        brew upgrade
 #      brew linkapps
        brew cleanup
        brew prune
        echo "Done updating Homebrew!"

        # Leave PATH the way we found it
        if [[ $found_conda == true ]] ; then
            echo "Restoring original PATH..."
            export PATH=$original_path
            echo "Done restoring original PATH!"
        fi
    else
        echo "Homebrew not found!"
    fi
elif [[ $os_type == "Linux" ]] ; then
    echo "Running apt-get..."
    sudo apt-get update -y
    sudo apt-get upgrade -y
    sudo apt-get autoclean -y
    sudo apt autoremove -y
fi

torch_path=$(which th)
if [[ -x $torch_path ]]; then
    echo "Found torch at $torch_path"

    echo "Updating torch"
    cd $(dirname $torch_path)/../.. ; ./update.sh; cd -
    echo "Done updating Torch"
else
    echo "Torch not found!"
fi

git_path=$(which git)
if [[ -x $git_path ]]; then
    echo "Found git at $git_path"
    echo "Checking for repos..."
    if [[ -e $HOME/repos ]]; then
        echo "Found repos"
        for dir in $(ls $HOME/repos); do
            repo_dir=$HOME/repos/$dir
            echo "Updating $repo_dir..."
            cd $repo_dir
            git pull
        done
    fi
fi

cd $starting_dir

#opam_path=$(which opam)
#if [[ -x $opam_path ]] ; then
#    echo "Found opam at $opam_path"
#
#    echo "Updating OPAM..."
#    opam update -u -y
#    echo "Done updating OPAM"
#else
#    echo "OPAM not found!"
#fi
