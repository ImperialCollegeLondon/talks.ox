# talks.ox
[![Build Status](https://travis-ci.org/ox-it/talks.ox.svg?branch=master)](https://travis-ci.org/ox-it/talks.ox)
[![Documentation Status](https://readthedocs.org/projects/talksox/badge/?version=latest)](https://readthedocs.org/projects/talksox/?badge=latest)

New version of Oxford Talks

## Start a local instance quickly on OS X

### Initial setup

Assuming that [VirtualBox](https://www.virtualbox.org) and [HomeBrew](http://brew.sh) are installed.

Make sure that you have the latest version of formulas in homebrew:

    brew update

Install docker:

    brew install docker boot2docker fig

Initialise the virtual machine:

    boot2docker init

You will eventually be asked to stick some environments variables in your bash profile.

### Starting the virtual machine when required

Start the virtual machine:

    boot2docker up

### Starting the virtual machine automatically

If you want to have the virtual machine starting automatically when you start your computer:

    cp /usr/local/Cellar/boot2docker/1.4.1/homebrew.mxcl.boot2docker.plist ~/Library/LaunchAgents/
    launchctl load ~/Library/LaunchAgents/homebrew.mxcl.boot2docker.plist
    
The path `/usr/local/Cellar/boot2docker/1.4.1` might change if you are using a newer version of `boot2docker`.

### Starting the project instance when required

This requires the virtual machine to be up (either manually started or when your computer starts).

Type the following command in a terminal:

    boot2docker ip
    
This will give you the IP address of the virtual machine (e.g. `192.168.59.103`), you will need
this information later.

Go at the root of your project directory (probably `talks.ox`):

    fig up
    
After a few seconds (minutes if it is building the instance for the first time), you should be able to visit
in your web browser: `http://<IP ADDRESS>:8000` and visualise Oxford Talks.

Any modification done in the python code/CSS/templates should immediately be visible when you refresh
the page in the web browser.
    
### Creating the database

Type the following command at the root of your project directory:

    fig run web python manage.py migrate --settings=talks.settings_docker

### Creating a user account

Type the following command at the root of your project directory:

    fig run web python manage.py createsuperuser --username=myusername --email=my@email.com --settings=talks.settings_docker

You will interactively be asked for a password.

## Developers

If you do not want to use the docker setup, make sure that you have the following dependencies available:

 * python 2.7
 * virtualenv (recommended)
 * sqlite (recommended, or alternatively PostgreSQL)
 * phantomjs (mandatory to run functional tests)
 * [Apache Solr](http://lucene.apache.org/solr/) (search server)

Install python dependencies:

    pip install -r requirements.txt
    pip install -r requirements_dev.txt

Create the database:

    python manage.py migrate --settings=talks.settings_dev

Load fixtures (test events):

    python manage.py loaddata talks/events/fixtures/dev_data.yaml --settings=talks.settings_dev

Run development web server:

    make local

Run all tests:

    make test

## Using Solr

See `solr/README.md`
