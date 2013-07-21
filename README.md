# The Wayward Traveller

This is my personal site including my blog.

I hope you find it useful.

## Local Setup

Get the Code:

    $ git clone https://github.com/jrmyward/blog.git
    $ cd blog

Setup the Application

    $ bundle install
    $ cp config/application.yml.example config/application.yml

You'll want to generate a new APP_SECRET_TOKEN to place in <code>config/application.yml</code>.

    $ rake secret
