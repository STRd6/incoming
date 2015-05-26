Incoming Mail Handler
=====================

When someone emails "appname@hyperweb.space" Mandrill posts a webhook to
this app with the message contents.

This app parses out the "appname" and posts a webhook to http://appname.hyperweb.space/email

