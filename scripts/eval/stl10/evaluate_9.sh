methods=(EFBSW FBSW lowerboundFBSW BSW)
obsw_weights=(10.0)
checkpoint_periods=(500)
fsw=0.5

datadir=data
outputdir=result
stat_dir=stats
image_dir=images

dims=2048
distribution=uniform
embed_size=48

batch_size=128
batch_size_test=128

seed=42
lr=0.0005
dataset=cifar10

gpu_id=5

for ckp in "${checkpoint_periods[@]}"; do

    for ((i=1; i<=10; i++)); do
        for lmbd in "${obsw_weights[@]}"; do
            CUDA_VISIBLE_DEVICES="$gpu_id" python3 evaluator.py \
                --dataset $dataset \
                --num-classes 10 \
                --datadir "$datadir" \
                --outdir "$outputdir" \
                --statdir "$stat_dir" \
                --imagedir "$image_dir" \
                --dims "$dims" \
                --distribution "$distribution" \
                --embedding-size "$embed_size" \
                --batch-size "$batch_size" \
                --batch-size-test "$batch_size_test" \
                --lr "$lr" \
                --seed "$seed" \
                --weight_fsw "$fsw" \
                --method OBSW \
                --lambda-obsw "$lmbd" \
                --checkpoint-period "$ckp"
        done

    done
done
