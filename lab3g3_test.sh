#!/bin/bash
set -e
# set -xv 

precision=4
k_chi=${1}
run() {
    number=$1
    shift
    for i in `seq $number`; do
      $@
    done
}

test() {
    n=$RANDOM
    range=$(shuf -i 50-100000 -n 1)
    m=$(( $n + $range ))
    seed=$RANDOM
    seed2=$RANDOM
    seed3=$RANDOM
    echo "range=${range}"
    echo "n=${n}"
    echo "m=${m}"
    echo "seed=${seed} ${seed2} ${seed3}"

    echo "${seed} ${seed2} ${seed3}" | ./lab3g3.o $n-$m > test.dat

    basic_stats=$(cat test.dat | ../Lab1/lab1 ${precision})
    basic_mean=$(echo ${basic_stats} | awk '{print $1}')
    basic_variance=$(echo ${basic_stats} | awk '{print $2}')
    basic_period=$(echo ${basic_stats} | awk '{print $3}')
    echo "mean=$basic_mean"
    echo "variance=$basic_variance"
    echo "period=$basic_period"

    test_stats=$(cat test.dat | sed "s@\([^ ]*\)@\1/4294967296@g" | ../Lab2/lab2 ${precision} ${k_chi})
    test_chi=$(echo ${test_stats} | awk '{print $1}')
    test_kplus=$(echo ${test_stats} | awk '{print $2}')
    test_kminus=$(echo ${test_stats} | awk '{print $3}')
    
    echo "chi square=$test_chi"
    echo "K+=$test_kplus"
    echo "K-=$test_kminus"

    echo "$n,$m,$range,$seed,$seed2,$seed3,$basic_mean,$basic_variance,$basic_period,$test_chi,$test_kplus,$test_kminus" >>  result3.csv
}

echo "n,m,range,seed,seed2,seed3,mean,variance,period,chi,kp,km" > result3.csv
run 2 test

