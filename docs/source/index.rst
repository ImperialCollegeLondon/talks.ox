.. talks.ox documentation master file, created by
   sphinx-quickstart on Tue Jul  8 11:43:21 2014.
   You can adapt this file completely to your liking, but it should at least
   contain the root `toctree` directive.

############
Oxford Talks
############

.. Note:: Some new features have just been released!

.. toctree::
   :maxdepth: 1
   :caption: User Guide

   Explore Oxford Talks (new) <user/talk-users/explore-talks>
   Collect talks you are interested in (new) <user/talk-users/make-a-list>
   Copy talks to your own calendar (new) <user/talk-users/add-to-your-calendar>
   Get an up-to-date feed in your calendar (new) <user/talk-users/feed-in-your-calendar>
   Set up email reminders (new) <user/talk-users/email-reminders>

.. toctree::
    :maxdepth: 1
    :caption: General Information

    user/general/contact
    user/general/log-in
    user/general/terms
    user/general/organisers
    user/general/differences

.. toctree::
    :maxdepth: 1
    :caption: Talks Editor's Guide

    user/talk-editors/sign-up
    user/talk-editors/responsibilities
    user/talk-editors/create-a-talk
    user/talk-editors/create-a-series
    user/talk-editors/editing
    user/talk-editors/formatting-the-abstract
    user/talk-editors/publicizing-your-talk
    user/talk-editors/last-minute-changes
    user/talk-editors/share-editing
    user/talk-editors/people-details



****************************
Web Managers and Integrators
****************************

An example widget to get you started with embedding talks in your own webpages can be found here:

`https://github.com/ox-it/talks.ox-js-widget <https://github.com/ox-it/talks.ox-js-widget>`_

The widget uses JavaScript to write a table, list or calendar view of selected talks to an HTML page. You can specify the criteria to select the talks you want.

* :ref:`Widget Documentation Overview <widget:widget-index>`
* :ref:`Parameters Reference <widget:parameters>`


***********************
Developer Documentation
***********************

.. toctree::
   :maxdepth: 1
   :caption: HTTP-API

   http_api/summary
   http_api/endpoints/talks
   http_api/endpoints/series
   http_api/endpoints/collections
   http_api/endpoints/search
