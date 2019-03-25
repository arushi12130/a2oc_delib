#!/bin/bash
epsilons=(0.2)
psis=(0 0.1)
seeds=(200)
gamename="Pong"

if [ -f fileNamesrun2.txt ] ; then
    rm fileNamesrun2.txt
fi

for epsilon in "${epsilons[@]}"; do
	for psi in "${psis[@]}"; do
		for seed in "${seeds[@]}"; do
			folder_name=""$gamename"_PSI"$psi"_EPS"$epsilon"_SEED"$seed
			nohup THEANO_FLAGS=floatX=float32 python2.7 train.py --sub-env $gamename --seed $seed --folder-name $folder_name --option-epsilon $epsilon --psi $psi
			echo "$folder_name" >> fileNamesrun2.txt
		done		
	done
done
