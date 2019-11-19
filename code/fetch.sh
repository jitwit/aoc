year=$1
day=$2
target_dir=$HOME"/code/advent/input/"$year
advent_file=$HOME"/code/advent/input/"$year"/"$day".in"
mkdir -p $target_dir
curl 'https://adventofcode.com/20'$year'/day/'$day'/input' -H 'User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:70.0) Gecko/20100101 Firefox/70.0' -H 'Accept: text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8' -H 'Accept-Language: en-CA,en-US;q=0.7,en;q=0.3' --compressed -H 'Referer: https://adventofcode.com/2018/day/2' -H 'DNT: 1' -H 'Connection: keep-alive' -H 'Cookie: session=53616c7465645f5fde007d08a4991fa5ff53611aadfb2f38799e37bf2b7431a0c227a27ec0dbd27af7f27c0d4eb658ae' -H 'Upgrade-Insecure-Requests: 1' -H 'Pragma: no-cache' -H 'Cache-Control: no-cache' -H 'TE: Trailers' -o $advent_file
