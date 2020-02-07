# pipe-to-slack-bash
It's like https://github.com/clarkie/pipe-to-slack but in Bash because... it was available

## Why

I wanted to play around with [Slack Incoming Webhooks](https://api.slack.com/messaging/webhooks). 🤷‍♂️

## Prerequisites

1. Either [HTTPie](https://httpie.org/) or [CuRL](https://curl.haxx.se/) is installed and available in your PATH.

## Config

You need to add some sort of app that supports "Incoming Webhooks" to your Slack, and then install this app as a user into your channel. That will give you a URL. Paste that URL into `~/.p2s.sh` and now you're ready to spam the channel with whatever logspam you want!

## Usage

```
ls /some/interesting/directory | p2s.sh
```

```
tail /var/log/app.logs | p2s.sh
```

```
head -c 50 /dev/urandom | base64 | ./p2s.sh
```

```
echo 'No code block for me, please!' | ./p2s.sh text
```
