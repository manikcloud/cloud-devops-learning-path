# ELK Stack Project - CloudWatch to Kibana

## Project Overview
Set up an Elasticsearch cluster on AWS and route all logs from CloudWatch to Kibana dashboard.

## Architecture
```
AWS CloudWatch → Kinesis Data Firehose → Elasticsearch → Kibana
```

## Setup Steps

### 1. Create Elasticsearch Cluster
```bash
# Using AWS CLI
aws es create-elasticsearch-domain \
  --domain-name my-elk-cluster \
  --elasticsearch-version 7.10 \
  --elasticsearch-cluster-config InstanceType=t3.small.elasticsearch,InstanceCount=1 \
  --ebs-options EBSEnabled=true,VolumeType=gp2,VolumeSize=20
```

### 2. Configure CloudWatch Log Streaming
```bash
# Create Kinesis Data Firehose delivery stream
aws firehose create-delivery-stream \
  --delivery-stream-name cloudwatch-to-es \
  --elasticsearch-destination-configuration \
  RoleARN=arn:aws:iam::ACCOUNT:role/firehose_delivery_role,\
  DomainARN=arn:aws:es:region:ACCOUNT:domain/my-elk-cluster/*,\
  IndexName=cloudwatch-logs
```

### 3. Set up Log Groups
```bash
# Create subscription filter
aws logs put-subscription-filter \
  --log-group-name /aws/lambda/my-function \
  --filter-name elasticsearch-filter \
  --filter-pattern "" \
  --destination-arn arn:aws:firehose:region:ACCOUNT:deliverystream/cloudwatch-to-es
```

## Kibana Queries
```json
{
  "query": {
    "bool": {
      "must": [
        {"range": {"@timestamp": {"gte": "now-1h"}}},
        {"match": {"level": "ERROR"}}
      ]
    }
  }
}
```

## Resources
- [AWS Elasticsearch Service](https://docs.aws.amazon.com/elasticsearch-service/)
- [Kibana Query DSL](https://www.elastic.co/guide/en/elasticsearch/reference/current/query-dsl.html)
