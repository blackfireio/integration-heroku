# Heroku Buildpack: Blackfire

> **If your app is written in PHP, you currently don't need to use this buildpack** as it is already [integrated in the
> official PHP buildpack](https://blackfire.io/docs/integrations/paas/heroku).

This is the official Heroku Buildpack for [Blackfire](https://blackfire.io).

Blackfire Profiler is a Software-as-a-Service tool which measures how your code consumes resources at run-time. It enables to find performance bottlenecks and understand the code's behavior. It can be used in development, test/staging and production (with no overhead for end-users).

Intuitive visualizations enable you to browse through your call stack, and review Wall-time, CPU time, I/O time, Memory, Network calls, HTTP requests and SQL queries usage.

This buildpack provides the **Blackfire Agent** and the **Blackfire CLI Tool**. Please refer to the Blackfire documentation for [more details on the Blackfire stack](https://blackfire.io/docs/reference-guide/faq#the-blackfire-stack).

The Blackfire Agent is a daemon processing the data collected by the Blackfire Probe, and sending it to the Blackfire servers. The Blackfire Probe is a language extension; it collects resources consumption metrics on profiled code.

The Blackfire CLI Tool provides a client with 2 main commands:

* An HTTP client wrapping cURL to [profile web based apps](https://blackfire.io/docs/cookbooks/profiling-http-via-cli);
* A client to [profile CLI Commands](https://blackfire.io/docs/cookbooks/profiling-cli).

## Requirements

- [Signup or login to Blackfire.io](https://blackfire.io/signup)
- Make sure the Blackfire Probe is installed (see installation procedures for each supported language below)
- [Make sure that the Blackfire servers can reach your servers](https://blackfire.io/docs/cookbooks/reverse-proxies).

### PHP

If your app is written in PHP, **you currently don't need to use this buildpack as it is already [integrated in the
official PHP buildpack](https://blackfire.io/docs/integrations/paas/heroku)**.

### Python

Install the Blackfire Probe by referring `blackfire` as dependency in your `requirements.txt` file, e.g.:

```
django
jinja2
gunicorn
blackfire
```

### Go

1. Import the Blackfire module in your code base:

   ```go
   import github.com/blackfireio/go-blackfire
   ```

2. [Update your code](https://blackfire.io/docs/integrations/go/sdk) to enable profiling in your Go app.

   Check that there are no errors in the logs. To debug problems, change the log level and the log file in the
   [probe configuration](https://blackfire.io/docs/configuration/go).

## Configuration

To set your config vars, you may use `heroku config:set` command:

```bash
heroku config:set BLACKFIRE_SERVER_ID=xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx
heroku config:set BLACKFIRE_SERVER_TOKEN=xxxxxxxxxx
heroku config:set BLACKFIRE_CLIENT_ID=xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx
heroku config:set BLACKFIRE_CLIENT_TOKEN=xxxxxxxxxx
```

> You may also define them in your app dashboard, in the *Settings* tab.

> **Important note:**: Each time you set or update a config var, **you must redeploy your app on Heroku**, using a
> `git push heroku master`.

### Mandatory Config Vars

The following configuration vars **must be set**:

- `BLACKFIRE_SERVER_ID`
- `BLACKFIRE_SERVER_TOKEN`
- `BLACKFIRE_CLIENT_ID`
- `BLACKFIRE_CLIENT_TOKEN`

Server credentials are used by the agent itself to authenticate against Blackfire servers in order to transfer
profiles data. You may use your Blackfire *personal server credentials* or *environment server credentials*.

Client credentials are used by `blackfire` CLI command, and by the Blackfire SDK. 

### Optional Config Vars

- `BLACKFIRE_LOG_LEVEL`
- `BLACKFIRE_COLLECTOR`
- `BLACKFIRE_AGENT_SOCKET`

> More details in [Blackfire Agent configuration documentation](https://blackfire.io/docs/configuration/agent#configuring-the-agent-via-environment-variables).

## Logs

Log files are located in your app at `/app/.blackfire/var/log`.
