import json
import boto3
import sys

preserved_ports = [80, 443, 444, 8080, 8082, 8117]

def query_to_json():
    return json.load(sys.stdin)

def check_target_groups():
    client = boto3.client('elbv2', region_name='us-east-1')
    target_groups = client.describe_target_groups()['TargetGroups']
    ports = []
    jsonqueries = query_to_json()
    for target_group in target_groups:
        if(jsonqueries["target_group_name"] and jsonqueries["target_group_name"] == target_group["TargetGroupName"]):
            return target_group["Port"]
        ports.append(target_group['Port'])

    return ports

def available_port():
    available_port = 8080
    checked_ports = check_target_groups()
    if(type(checked_ports) is list):
        checked_ports += preserved_ports
    else:
        return checked_ports
    while available_port < 65535 and available_port in checked_ports:
        available_port += 1
    
    if available_port >= 65535:
        raise Exception("Unable to find available port")

    return available_port
    
try:
    print(json.dumps({"port": str(available_port())}))
except Exception as err:
    print(err, file=sys.stderr)
    sys.exit(1)