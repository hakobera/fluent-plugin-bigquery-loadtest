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

Check result using bq command line tool.

```
$ bq query "SELECT id, time, method, level, uri, reqtime  FROM (TABLE_QUERY(fluentd_test, 'REGEXP_MATCH(table_id, r\"access\d\")')) ORDER BY time desc LIMIT 10"
Waiting on bqjob_r7bbba102f937b28d_00000147ed0b49a1_1 ... (7s) Current status: DONE
+-------+---------------------+--------+-------+------------------+--------------------+
|  id   |        time         | method | level |       uri        |      reqtime       |
+-------+---------------------+--------+-------+------------------+--------------------+
| 81843 | 2014-08-19 06:54:05 | POST   | WARN  | /api/v1/textdata |  2.992644436142631 |
| 81846 | 2014-08-19 06:54:05 | GET    | WARN  | /api/v1/people   |  4.202247813435515 |
| 81835 | 2014-08-19 06:54:05 | PUT    | INFO  | /api/v1/textdata |  4.951895430571021 |
| 81837 | 2014-08-19 06:54:05 | GET    | WARN  | /api/v1/people   | 1.1375395998393394 |
| 81833 | 2014-08-19 06:54:05 | POST   | INFO  | /api/v1/textdata |  0.810828842297196 |
| 81823 | 2014-08-19 06:54:05 | GET    | INFO  | /api/v1/people   | 2.4010146954485756 |
| 81842 | 2014-08-19 06:54:05 | GET    | WARN  | /api/v1/people   | 1.6581904706842845 |
| 81836 | 2014-08-19 06:54:05 | PUT    | WARN  | /api/v1/textdata |  1.487238197384085 |
| 81841 | 2014-08-19 06:54:05 | GET    | ERROR | /api/v1/people   |  2.842070260680093 |
| 81825 | 2014-08-19 06:54:05 | POST   | DEBUG | /api/v1/people   | 1.6226269005981386 |
+-------+---------------------+--------+-------+------------------+--------------------+

$ bq query "SELECT method, count(*) FROM (TABLE_QUERY(fluentd_test, 'REGEXP_MATCH(table_id, r\"access\d\")')) GROUP BY method"
Waiting on bqjob_r6d831a21161bbf37_00000147ed0c484a_1 ... (6s) Current status: DONE
+--------+-------+
| method |  f0_  |
+--------+-------+
| GET    | 34652 |
| PUT    | 34586 |
| POST   | 34732 |
+--------+-------+
```
