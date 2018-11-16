#!/bin/bash
function print_header(){
    printf '%*s\n' "${COLUMNS:-$(tput cols)}" '' | tr ' ' -
    echo $1
    printf '%*s\n' "${COLUMNS:-$(tput cols)}" '' | tr ' ' -
}

# Directory of this script
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )" 

# Virtualenv
cd $DIR
virtualenv venv
source venv/bin/activate
pip3.6 install -r requirements.txt

# Add maddpg to python path
export PYTHONPATH=$DIR:$PYTHONPATH

# Add multiagent-particle env to python path
export PYTHONPATH=/home/dongki/research/lids/git/2018-meta-marl/thirdparty/multiagent-particle-envs:$PYTHONPATH

# Train tf 
print_header "Training network"
cd $DIR
python3.6 experiments/train.py \
--scenario simple_spread \
--max-episode-len 50 \
