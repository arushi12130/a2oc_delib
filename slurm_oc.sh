cores=16
epsilons=(0.2)
psis=(0)
seeds=(100)
gamename="MsPacman"


if [ -f fileNamesrun2.txt ] ; then
    rm fileNamesrun2.txt
fi

for epsilon in ${epsilons[@]}
do
    for psi in ${psis[@]}
    do
        for seed in ${seeds[@]}
        do            
            if [ -f temprun.sh ] ; then
              rm temprun.sh
            fi
            
            folder_name=""$gamename"_PSI"$psi"_EPS"$epsilon"_SEED"$seed
            echo "#!/bin/bash" >> temprun.sh
            echo "#SBATCH --output=temp_outputfiles/"$folder_name >> temprun.sh
            echo "#SBATCH --ntasks=1" >> temprun.sh
            echo "#SBATCH --cpus-per-task="$cores >> temprun.sh
            echo "#SBATCH --time=15:00:00" >> temprun.sh
            echo "#SBATCH --mem-per-cpu=2000">> temprun.sh
            echo "source ~/.bashrc" >> temprun.sh
            a="THEANO_FLAGS=floatX=float32 python2.7 train.py --sub-env "$gamename" --seed "$seed" --folder-name "$folder_name" --option-epsilon "$epsilon" --psi "$psi
            echo "$folder_name" >> fileNamesrun2.txt
            echo $a >> temprun.sh
            echo $a
            eval "sbatch temprun.sh"
            rm temprun.sh
        done
    done
done
