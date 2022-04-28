function __fish_complete_ssm-env
    aws autoscaling describe-auto-scaling-instances | jq -r '.AutoScalingInstances[].AutoScalingGroupName'
end
