year=$1
day=$2
target_dir=$HOME"/code/advent/input/"$year
advent_file=$HOME"/code/advent/input/"$year"/"$day".in"
mkdir -p $target_dir
url='https://adventofcode.com/20'$year'/day/'$day'/input'
sh ~/code/advent/code/secret.sh $url $advent_file
