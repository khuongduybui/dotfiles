# Defined in /tmp/fish.qTKLmf/ssm-env.fish @ line 2
function ssm-env
    set -l asg
    if test (count $argv) = 1
        set -x asg (aws autoscaling describe-auto-scaling-instances | jq -r '.AutoScalingInstances[].AutoScalingGroupName' | uniq | fzf -1 -q $argv[1])
    else
        set -x asg (aws autoscaling describe-auto-scaling-instances | jq -r '.AutoScalingInstances[].AutoScalingGroupName' | uniq | fzf)
    end
    echo 'ASG:      '\uf7c2 $asg

    set -l instanceId (aws autoscaling describe-auto-scaling-instances | jq -r '.AutoScalingInstances | map(select(.AutoScalingGroupName == "'$asg'")) | .[].InstanceId' | fzf)
    echo 'Instance: '\uf878 $instanceId

    aws ssm start-session --document-name AWS-StartInteractiveCommand --parameters command="bash -l" --target $instanceId
end
