# Install

```
bundle
rails db:setup
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