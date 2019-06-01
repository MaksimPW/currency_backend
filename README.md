# Task

The task is to develop a small resource for currency exchange rates obtained through the API of Tinkoff Bank (https://www.tinkoff.ru/api/v1/currency_rates/).

The application must:
1) Build a graph based on data on fluctuations in the rate of purchase and sale of the dollar and the euro per day
2) show the average value per day

# Install

```
bundle

rails db:setup

cp config/database.sample.yml config/database.yml
```

# Run

```
rails s
```

# Run cron tasks

```
crontab -r
whenever --update-crontab --set environment='development'
```

> Clear crontab: `crontab -r`
