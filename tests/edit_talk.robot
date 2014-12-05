*** Settings ***
Documentation    Suite description
Library  fixtures
Library  Selenium2Library
Library  server
Resource  keywords.robot
Variables  pages.py
Variables  events.py
Suite Setup  suite setup
Suite teardown  suite teardown
Test Setup  test edit setup
Test teardown  test teardown

*** Test Cases ***

Scenario: initialise with correct data
    go to ${edit_talk_page('${event1_slug}')}
    page should contain text "Edit"
    page should contain text "${event1_title}"
    # should appear because some of them
    # are AJAX calls to fetch labels
    page should appear text "Banbury Road"
    page should appear text "James Bond"
    page should appear text "7-19 Banbury Road"
    page should appear text "A maths conference"
    page should appear text "Biodiversity"
    page should appear text "Aquatic biodiversity"
    page should appear text "contrib.user@users.com"

Scenario: change location
    go to ${edit_talk_page('${event2_slug}')}
    page should contain text "Banbury"
    click on ${remove item('event-location')}
    page should not contain text "Banbury"
    click on ${button done}
    page should not contain text "Banbury"

Scenario: remove speaker
    go to ${edit_talk_page('${event1_slug}')}
    page should appear text "James Bond"
    click on ${remove item('event-speakers')}
    page should not contain text "James Bond"
    click on ${button done}
    current page should be ${show_talk_page('${event1_slug}')}
    page should not contain text "James Bond"

Scenario: remove topic
    go to ${edit_talk_page('${event1_slug}')}
    page should appear text "Biodiversity"
    page should appear text "Aquatic biodiversity"
    click on ${remove item('event-topics')}
    #assuming 'click on' clicks on the first element found by the locator, so do it again
    click on ${remove item('event-topics')}
    page should not contain text "Biodiversity"
    page should not contain text "Aquatic biodiversity"
    click on ${button done}
    page should not contain text "Biodiversity"
    page should not contain text "Aquatic biodiversity"
