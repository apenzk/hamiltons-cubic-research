#!/bin/zsh
# Reviewer 199: sabotage variants, serialised (three at once was OOM-killed).
#
# Sandbox setup, from the repo root -- nothing under review is touched:
#   mkdir -p scripts/reviewers/r199/sandbox && cd $_
#   cp ../../../runs/run_n5_{adapted,highest_weight,evaluate,weyl_module}.py .
#   cp ../../../runs/n5_hw_cache.json .
#   ln -s "$PWD/../../../runs/n5_adapted.pkl" n5_adapted.pkl
#   cp ../../../runs/run_n5_assemble.py base_assemble.py
#   python3 ../patch.py cross_plant cross_data h_swap inhom square   # one per call
#
# base_assemble.py is a byte copy of run_n5_assemble.py at 774e03b; every
# var_*.py differs from it only in the planted defect.
cd "$(dirname "$0")"
log() { echo "### $1 $2 $(date +%T)" >> drive.log }
log s_plantA start;    R199_LAM='(6,4)' R199_A=0 R199_B=127 python3 var_cross_plant.py > s_plantA.log 2>&1; log s_plantA exit=$?
log s_plantC start;    R199_LAM='(6,4)' R199_A=8 R199_B=5   python3 var_cross_plant.py > s_plantC.log 2>&1; log s_plantC exit=$?
log s_inhom start;     R199_LAM='(4,2)' R199_T=100          python3 var_inhom.py       > s_inhom.log 2>&1;  log s_inhom exit=$?
log s_hswap start;     R199_LAM='(4,2)'                     python3 var_h_swap.py      > s_hswap.log 2>&1;  log s_hswap exit=$?
log s_crossdata start; R199_LAM='(6,4)' R199_T=400          python3 var_cross_data.py  > s_crossdata.log 2>&1; log s_crossdata exit=$?
log ALL done
