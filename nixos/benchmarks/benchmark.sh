#!/usr/bin/env bash

{
    echo -e "\n$(date) - CPU benchmark"
    sysbench cpu --cpu-max-prime=20000 --threads=$(nproc) run
    echo -e "\n$(date) - Memory benchmark"
    sysbench memory --threads=$(nproc) run
} >>~/sysbench-all.log
