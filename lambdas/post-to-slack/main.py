import json
import requests
import os

WEBHOOK_URL = os.environ["SLACK_WEBHOOK_URL"]


def lambda_handler(event, context=None):

    text = f"New AWS Event ```{json.dumps(event, indent=4)}```"
    slack_data = {"text": text}
    response = requests.post(
        WEBHOOK_URL,
        data=json.dumps(slack_data),
        headers={"Content-Type": "application/json"},
    )
    if not response.ok:
        raise ValueError(
            f"Request to Slack returned {response.status_code} error code: {response.text}"
        )


if __name__ == "__main__":
    sample_event = {
        "version": "0",
        "id": "fe8d3c65-xmpl-c5c3-2c87-81584709a377",
        "detail-type": "RDS DB Instance Event",
        "source": "aws.rds",
        "account": "123456789012",
        "time": "2020-04-28T07:20:20Z",
        "region": "us-east-2",
        "resources": ["arn:aws:rds:us-east-2:123456789012:db:rdz6xmpliljlb1"],
        "detail": {
            "EventCategories": ["backup"],
            "SourceType": "DB_INSTANCE",
            "SourceArn": "arn:aws:rds:us-east-2:123456789012:db:rdz6xmpliljlb1",
            "Date": "2020-04-28T07:20:20.112Z",
            "Message": "Finished DB Instance backup",
            "SourceIdentifier": "rdz6xmpliljlb1",
        },
    }
    lambda_handler(sample_event)