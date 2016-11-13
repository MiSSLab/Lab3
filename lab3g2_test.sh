#!/bin/bash
set -e
# set -xv 

precision=4
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
    echo "range=${range}"
    echo "n=${n}"
    echo "m=${m}"
    echo "seed=${seed}"

    echo "${seed}" | ./lab3g2.o $n-$m > test.dat

    basic_stats=$(cat test.dat | ../Lab1/lab1 ${precision})
    basic_mean=$(echo ${basic_stats} | awk '{print $1}')
    basic_variance=$(echo ${basic_stats} | awk '{print $2}')
    basic_period=$(echo ${basic_stats} | awk '{print $3}')
    echo "mean=$basic_mean"
    echo "variance=$basic_variance"
    echo "period=$basic_period"
    [[ $basic_period -ne $(($range + 1)) ]] &&  echo "wrong period" && exit 1

    test_stats=$(cat test.dat | sed "s@\([^ ]*\)@\1/4294967296@g" | ../Lab2/lab2 ${precision})
    test_chi=$(echo ${test_stats} | awk '{print $1}')
    test_kplus=$(echo ${test_stats} | awk '{print $2}')
    test_kminus=$(echo ${test_stats} | awk '{print $3}')
    
    chi_sq_k50=34 # actually 34.7643
    echo "chi square=$test_chi"
    [[ $chi_square -gt $chi_sq_k50 ]] && echo "wrong chi" && exit 1
    echo "K+=$test_kplus"
    echo "K-=$test_kminus"

    echo "$n,$m,$range,$seed,$basic_mean,$basic_variance,$basic_period,$test_chi,$test_kplus,$test_kminus" >>  result2.csv
}

echo "n,m,range,seed,mean,variance,period,chi,kp,km" > result2.csv
run 10000 test

