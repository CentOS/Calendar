# The CentOS Project Calendar

This project aims to provide an easier way to track CentOS related meetings. Every project meeting is defined by a YAML files.  These are combined using yaml2ical into a web page listing all meetings and an `.ical` file that can be read by your calendaring application of choice.

For the actual calendar, please see (soon to be published url or output/index.html).  Instructions for adding or changing a meeting are also there.

This system is based on the fantastic work done by the OpenStack Project as documented at https://github.com/openstack-infra/irc-meetings for managing their internal meetings.

# YAML Meeting File Format

Each meeting consists of:

* ``project``: the name of the project
* ``project_url`` the URL to the page of the project
* ``meeting_id``: the name given to the ``#startmeeting`` meetbot command
* ``agenda_url`` the URL to the page with the agenda for the meeting,
  usually in the wiki
* ``schedule``: a list of schedule each consisting of

  * ``time``: time string in UTC
  * ``day``: the day of week the meeting takes place
  * ``irc``: the irc room in which the meeting is held
  * ``frequency``: frequent occurrence of the meeting
* ``chair``: name of the meeting's chair
* ``description``: a paragraph description about the meeting

The file name should be a lower-cased, hyphenated version of the meeting name,
ending with ``.yaml`` . For example, ``Atomic SIG Team Meeting`` should be
saved under ``atomic-sig-team-meeting.yaml``.

## Example

This is an example for the yaml meeting for Software Collections SIG.  The whole file
will be import into Python as a dictionary.

* The project name is shown below.

        project:  Software Collections SIG Sync-up

* The schedule is a list of dictionaries each consisting of `time` in UTC,
  `day` of the week, the `irc` meeting room, and the `frequency` of the
  meeting. Options for the `frequency` are `weekly`, `biweekly-even`, and
  `biweekly-odd` at the moment.

        schedule:
            - time:       '1600'
              day:        Wednesday
              irc:        centos-devel
              frequency:  weekly

* The chair is just a one liner. The might be left empty if there is not a
  chair.

        chair:  Honza Horak

* The project description is as follows.  Use `>` for paragraphs where new
  lines are folded, or `|` for paragraphs where new lines are preserved.

        description:  >
            Discussions related to the Software Collections SIG.  The SIG will provide an upstream development area for various software collections and related tools. Developers can build on and extend existing SCLs, so they don't need to re-invent the wheel or take responsibility for packaging unnecessary dependencies. 

# Maintainer Notes

To create the output files, run yaml2ical (https://github.com/openstack-infra/yaml2ical).  A container, bexelbie/yaml2ical has been created to assist with this.  Using the container, run:

    docker run --rm=true --privileged -u `id -u`:`id -g` -v `pwd`:/workdir bexelbie/yaml2ical -y meetings -o output/irc-meetings.ical -t list.jinja -w output/index.html -f
