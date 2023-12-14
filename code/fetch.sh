year=$1
day=$2
mkdir -p $HOME"/code/advent/input/"$year
url="https://adventofcode.com/20"$year"/day/"$day"/input"
sh ~/code/aoc/code/secret.sh $url $HOME"/code/advent/input/"$year"/"$day".in"
