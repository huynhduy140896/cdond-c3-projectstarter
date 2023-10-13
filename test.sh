export OldWorkflowID=$(aws cloudformation \
                      list-exports --query "Exports[?Name==\`WorkflowID\`].Value" \
                      --no-paginate --output text)
echo ${OldWorkflowID:10:17} > old_WorkflowID.txt

echo $OldWorkflowID


export OldWorkflowID=$(cat ./old_WorkflowID.txt)
export STACKS=($(aws cloudformation list-stacks --query "StackSummaries[*].StackName" \
    --stack-status-filter CREATE_COMPLETE --no-paginate --output text))
echo Stack names: "${STACKS[@]}" 


echo "========="
for stack in ${STACKS[@]}
do
    if [[ $stack != *"${OldWorkflowID}"*  && $stack != "InitialStack"  ]] 
    then
        echo $stack
    fi
done
