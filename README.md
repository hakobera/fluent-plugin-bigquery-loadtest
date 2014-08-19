# fluent-plugin-bigquery-loadtest

Load test for fluent-plugin-bigquery

## Prerequisities

You must finish setup [bq Command-Line Tool](https://developers.google.com/bigquery/bq-command-line-tool?hl=ja).

## How to run

Open cosole and run:

```
$ bundle install
$ ./create_table.sh
$ ./run_dummer
```

Open another console and run:

```
$ EMAIL=YOUR_SERVICE_ACCOUNT_EMAIL PRIVATE_KEY_PATH=/path/to/keyfile PROJECT=YOUR_PROJECT_ID bundle exec fluentd -c fluent.conf -vv --use-v1-config
```
