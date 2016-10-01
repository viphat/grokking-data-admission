
**Grokking Data Engineer Mini Admission Challenges**

### Info

**Dương Vì Phát** - Ruby on Rails Developer - **Email**: viphat(at)gmail.com

### Challenge 1

#### Solution

> [https://github.com/viphat/grokking-data-admission/blob/master/challenge-1.md](https://github.com/viphat/grokking-data-admission/blob/master/challenge-1.md)

```
In this (contrived) scenario, orders from an e-commerce service are given to you as files.
The format is:
<unix_timestamp>,<user_id>,<unique item name>

For example:

1473772369,13579,Art-Insight-Science-Engineering-Complexity
1473792316,1651326,Designing-Data-Intensive-Applications

The information in each file is sorted in increasing time order.
You receive around 10 files per day, each file can be around 1 GB in size.

To gain insight in user order behavior, you need to extract a distribution of
orders for an item within a selected time range (i.e Book X, from Aug 10 to Aug 12)

Propose how you would achieve this.
If you decide to write a program, give us the pseudo code
```

### Challenge 2

#### Result

- **2.1**: `1842`

- **2.2**: `2441`

- **2.3**: [https://github.com/viphat/grokking-data-admission/blob/master/challenge-2/c2-3.csv](https://github.com/viphat/grokking-data-admission/blob/master/challenge-2/c2-3.csv)

- **2.4**: [https://github.com/viphat/grokking-data-admission/blob/master/challenge-2/c2-4.csv](https://github.com/viphat/grokking-data-admission/blob/master/challenge-2/c2-4.csv)

#### Solution

> [https://github.com/viphat/grokking-data-admission/blob/master/challenge-2/grokking-ch-2.rb](https://github.com/viphat/grokking-data-admission/blob/master/challenge-2/grokking-ch-2.rb)

```
For the given dataset
      Excel format: https://docs.google.com/spreadsheets/d/1U43NTwDYRlsOZqjHlCvFhCwT6FPREJ3iEPJc-hbksok/edit?usp=sharing
       CSV format: https://drive.google.com/open?id=0B3dHGVpTXDOhOE8yZXBObGpUX1U
Please perform some data analysis and answer the following questions:
- For people age, how many people are older than Mark Zuckerberg ? Hint: His birthday is May 14, 1984
- For province, how many people are living in Ho Chi Minh City ?
- The list of people who live in Ho Chi Minh City, age less than 20 and gender is “Female”
- The list of people who recruited on weekend from 6 PM to 10 PM, live in Ho Chi Minh City or Ha Noi City

Please submit the answers together with your work (Python code, SQL code or any other tools that you use)
```


### Challenge 3

#### Solution

> [https://github.com/viphat/grokking-data-admission/blob/master/challenge-3/postgres.sql](https://github.com/viphat/grokking-data-admission/blob/master/challenge-3/postgres.sql)

```
Given the following purchases table that record all purchases of an online ecommerce store:
create table purchases (
  id integer primary key,
  user_id integer,
  product_id integer,
  created_at timestamp without timezone
)

Please write a SQL query that show monthly unique buyers, broken down by first time buyers, and returned buyers.

A first time buyer is a buyer that hasn't made any purchase prior
A returned buyer is a buyer that has made at least 1 purchase prior

Your SQL should return 3 columns:
- month (date)
- first_time_buyers (integer),
- returned_buyers (integer)

Please submit your work (SQL) and state the SQL database you're using (MySQL, PostgreSQL, SQL Server or any other DBs). You can provide any explanation if you want to.

Examples (data below has been simplfied for ease of understanding, not how it is actually stored in the table, e.g. user_id will only contain integer)

id | user_id   | product_id | created_at |
1  | alice     | 1          | Jul 2016   |
2  | charlie   | 1          | Jul 2016   |
3  | alice     | 2          | Aug 2016   |
4  | bob       | 3          | Aug 2016   |
5  | david     | 3          | Aug 2016   |
6  | bob       | 2          | Sep 2016   |
7  | bob       | 3          | Sep 2016   |
8  | david     | 3          | Sep 2016   |

Expected results:

| month        | first_time_buyers | returned_buyers |
| 2016-07-01   | 2                 | 0               |
| 2016-08-01   | 2                 | 1               |
| 2016-09-01   | 0                 | 2               |
```
