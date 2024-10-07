import os
import urllib.parse
import boto3
import awswrangler as wr


s3 = boto3.client("s3")


def lambda_handler(event, _):
    # Get the database name from the environment variable
    database_name = os.environ["DATABASE_NAME"]

    # Get the bucket and key from the event
    record_s3_part = event["Records"][0]["s3"]
    bucket = record_s3_part["bucket"]["name"]
    key = urllib.parse.unquote_plus(record_s3_part["object"]["key"], encoding="utf-8")

    # Read the CSV file from S3
    data = wr.s3.read_csv(f"s3://{bucket}/{key}", index_col=0)
    prefix = key.split("/")[1].split(".")[0]

    # Write the data to the Glue Data Catalog
    wr.s3.to_parquet(
        df=data,
        path=f"s3://{bucket}/database/{prefix}/",
        dataset=True,
        database=database_name,
        table=prefix,
    )
