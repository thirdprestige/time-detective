TIME DETECTIVE
==============

Time Detective helps find holes in timesheet entries for knowledge workers.

For example, when Developer John deploys a hotfix to the Brigham server on Tuesday at 3 PM,
we expect a time entry billing the client for the fix. If the timesheet doesn't
have any time for John on the Brigham project on Tuesday afternoon, we know to ask John
to double-check the timesheet.

The end product is a weekly report to the account owner showing how much money we made him
that particular week. When we remind John to enter in an extra 5 hours, and Harvest tells us
John bills out at $150 per hour, we can politely let John's boss, Karl, know that Time Detective
made him an extra $750, just this week.

In order to do this, we have to be able to find the gaps. There are two main types of data for
each account: time entries, and activities. An activity may be: a GitHub commit, a Heroku deploy,
an email, or a Dropbox file update. When we have an activity that doesn't overlap a time entry,
we know we need to follow up with the worker.

SCHEDULE
========

Each day, we pull in data from all connected apps. For Harvest, we create any time entries
that have been entered since we last batched the job. For all activity-related apps, we
create an activity entry.

Once these are finished processing, we kick off a job that
runs a diff between the entries and activities, then creates a pending entry when it finds a
potential hole (that is, an activity without an overlapping time entry.) Ideally, we craft a
possible entry description for the worker to use, and guess at how many billable hours he will want to log.

Finally, once all of the pending entries are created, we run a report emailing each worker with the entries
he needs to check over.

When any entries have been pending > 48 hours, or there are pending entries on Friday morning, we
send a phone call to the worker.

USER EXPERIENCE
===============

There is a lot of initial set up for an administrator to do.

First, we have to tie in all our 3rd party apps: Harvest, GitHub, Heroku.

Second, we need to tie each project together across all of those apps,
which means we have to continually pull in all of the projects across each of those integrations.
