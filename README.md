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
