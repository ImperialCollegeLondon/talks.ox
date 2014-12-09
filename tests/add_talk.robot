*** Settings ***
Library  fixtures
Library  Selenium2Library
Library  server
Resource  keywords.robot
Variables  pages.py
Suite Setup  suite setup
Suite teardown  suite teardown
Test Setup  test setup
Test teardown  test teardown

*** Test Cases ***
Scenario: Add the simplest talk
    go to ${add_talk_page}
    type "something" into ${title field}
    type "something else" into ${abstract field}
    click on ${start field}
    ${datetimepicker[0]} should appear
    Select current date and time for ${datetimepicker[0]}
    ${datetimepicker[0]} should disappear
    click on ${end field}
    ${datetimepicker[1]} should appear
    Select current date and time for ${datetimepicker[1]}
    ${datetimepicker[1]} should disappear
    click on ${button done}
    current page should be ${talk page}
    ${success message} should be displayed
    ${success message} should contain text "New event has been created"
    page should contain text "something"
    page should contain text "something else"

Scenario: Add talk to existing group of talks
    create  event group  title=foo

    go to ${add_talk_page}
    type "something" into ${title field}
    ${group field} should not be displayed
    click on ${checkbox in group section}
    ${group field} should be displayed
    ${create group button} should be displayed
    Select from list  ${group field.locator}  foo
    click on ${start field}
    ${datetimepicker[0]} should appear
    Select current date and time for ${datetimepicker[0]}
    ${datetimepicker[0]} should disappear
    click on ${end field}
    ${datetimepicker[1]} should appear
    Select current date and time for ${datetimepicker[1]}
    ${datetimepicker[1]} should disappear
    click on ${button done}
    ${success message} should appear
    ${success message} should contain text "New event has been created"
    page should contain text "something"
    page should contain text "Part of: foo" 

Scenario: Title not announced
    go to ${add talk page}
    click on ${button done}
    current page should be ${add talk page}
    ${error message} should appear
    ${error message[0]} should be displayed
    ${error message[1]} should be displayed
    ${error message[0]} should contain text "Please correct errors below"
    ${error message[1]} should contain text "Either provide title or mark it as not announced"

Scenario: Create new group on the go
    go to ${add_talk_page}
    type "something" into ${field('Title')}
    ${group field} should not be displayed
    click on ${checkbox in group section}
    ${group field} should be displayed
    ${group field} selected item should be "-- select a group --"
    ${create group button} should be displayed
    click on ${create group button}
    ${modal dialog} should appear
    ${modal dialog title} should contain text "Add a new event group"
    type "new group" into ${modal dialog field('Title')}
    type "group description" into ${modal dialog field('Description')}
    click on ${modal dialog submit button}
    ${modal dialog} should disappear
    ${group field} selected item should be "new group"

Scenario: Lookup venue
    go to ${add_talk_page}
    type "oucs" into ${field('Venue')}
    ${suggestion popup} should appear
    ${suggestion popup} should contain text "7-19 Banbury Road"
    click on ${suggestion popup item('Banbury Road')}
    ${list group item("7-19 Banbury Road")} should be displayed
    
Scenario: Lookup department
    go to ${add_talk_page}
    type "biol" into ${field('Organising department')}
    ${suggestion popup} should appear
    ${suggestion popup} should contain text "Chemical Biology"
    click on ${suggestion popup item('Chemical Biology')}
    ${list group item("Chemical Biology")} should be displayed
    
Scenario: Lookup topic
    go to ${add_talk_page}
    type "biodiv" into ${field('Topics')}
    ${suggestion popup} should appear
    ${suggestion popup} should contain text "Biodiversity"
    click on ${suggestion popup item('Biodiversity')}
    ${list group item("Biodiversity")} should be displayed
    type "biodiv" into ${field('Topics')}
    ${suggestion popup} should appear
    ${suggestion popup} should contain text "Animal diversity"
    click on ${suggestion popup item('Animal diversity')}
    ${list group item("Animal diversity")} should be displayed

Scenario: Lookup speaker
    create  person  name=James Bond
    create  person  name=Napoleon Solo

    go to ${add_talk_page}
    type "bon" into ${field('Speakers')}
    ${suggestion popup} should appear
    ${suggestion popup} should contain text "James Bond"
    click on ${suggestion popup item('James Bond')}
    ${list group item("James Bond")} should be displayed
    type "apo" into ${field('Speakers')}
    ${suggestion popup} should appear
    ${suggestion popup} should contain text "Napoleon Solo"
    click on ${suggestion popup item('Napoleon Solo')}
    ${list group item("Napoleon Solo")} should be displayed

Scenario: Properly display typeahead fields in newly created event
    create  person  name=James Bond
    create  person  name=Napoleon Solo      bio=IT Services

    go to ${add_talk_page}
    fill in required fields
    type "oucs" into ${field('Venue')}
    ${suggestion popup} should appear
    ${suggestion popup} should contain text "7-19 Banbury Road"
    click on ${suggestion popup item('Banbury Road')}
    type "biol" into ${field('Organising department')}
    ${suggestion popup} should appear
    ${suggestion popup} should contain text "Chemical Biology"
    click on ${suggestion popup item('Chemical Biology')}
    type "biodiv" into ${field('Topics')}
    ${suggestion popup} should appear
    ${suggestion popup} should contain text "Biodiversity"
    click on ${suggestion popup item('Biodiversity')}
    type "biodiv" into ${field('Topics')}
    ${suggestion popup} should appear
    ${suggestion popup} should contain text "Animal diversity"
    click on ${suggestion popup item('Animal diversity')}
    type "bon" into ${field('Speakers')}
    ${suggestion popup} should appear
    ${suggestion popup} should contain text "James Bond"
    click on ${suggestion popup item('James Bond')}
    type "apo" into ${field('Speakers')}
    ${suggestion popup} should appear
    ${suggestion popup} should contain text "Napoleon Solo"
    click on ${suggestion popup item('Napoleon Solo')}
    click on ${button done}
    current page should be ${talk page}
    ${success message} should be displayed
    ${success message} should contain text "New event has been created"
    page should contain text "Venue: 7-19 Banbury Road"
    page should contain text "Organising department: Chemical Biology"
    page should contain text "Topics: Biodiversity"
    page should contain text "James Bond"
    page should contain text "Napoleon Solo (IT Services)"

Scenario: Create speaker on the go
    go to ${add talk page}
    Fill in required fields
    click on ${reveal create speaker link}
    ${speaker name field} should appear
    type "Albert Einstein" into ${speaker name field}
    type "Theoretical Physicist" into ${speaker bio field}
    click on ${add speaker button}
    page should appear text "Albert Einstein, Theoretical Physicist"
    click on ${button done}
    current page should be ${talk page}
    page should contain text "Albert Einstein"
    page should contain text "Theoretical Physicist"

Scenario: Save and add another
    go to ${add talk page}
    type "something" into ${title field}
    click on ${start field}
    ${datetimepicker[0]} should appear
    Select current date and time for ${datetimepicker[0]}
    ${datetimepicker[0]} should disappear
    click on ${end field}
    ${datetimepicker[1]} should appear
    Select current date and time for ${datetimepicker[1]}
    ${datetimepicker[1]} should disappear
    click on ${button save add another}
    current page should be ${add talk page}
    ${success message} should be displayed
    ${success message} should contain text "New event has been created"


Scenario: Preserve form data after validation
    create  person  name=James Bond
    create  person  name=Napoleon Solo

    go to ${add_talk_page}
    type "oucs" into ${field('Venue')}
    ${suggestion popup} should appear
    ${suggestion popup} should contain text "7-19 Banbury Road"
    click on ${suggestion popup item('Banbury Road')}
    type "biol" into ${field('Organising department')}
    ${suggestion popup} should appear
    ${suggestion popup} should contain text "Chemical Biology"
    click on ${suggestion popup item('Chemical Biology')}
    type "biodiv" into ${field('Topics')}
    ${suggestion popup} should appear
    ${suggestion popup} should contain text "Biodiversity"
    click on ${suggestion popup item('Biodiversity')}
    type "biodiv" into ${field('Topics')}
    ${suggestion popup} should appear
    ${suggestion popup} should contain text "Animal diversity"
    click on ${suggestion popup item('Animal diversity')}
    type "bon" into ${field('Speakers')}
    ${suggestion popup} should appear
    ${suggestion popup} should contain text "James Bond"
    click on ${suggestion popup item('James Bond')}
    type "apo" into ${field('Speakers')}
    ${suggestion popup} should appear
    ${suggestion popup} should contain text "Napoleon Solo"
    click on ${suggestion popup item('Napoleon Solo')}
    click on ${button done}
    current page should be ${add talk page}
    ${error message} should appear
    ${error message} should contain text "Please correct errors below"
    ${list group item("7-19 Banbury Road")} should be displayed
    ${list group item("Chemical Biology")} should be displayed
    ${list group item("Biodiversity")} should be displayed
    ${list group item("Animal diversity")} should be displayed
    ${list group item("James Bond")} should be displayed
    ${list group item("Napoleon Solo")} should be displayed


*** Keywords ***
Fill in required fields
    type "${TEST_NAME}" into ${field('Title')}
    click on ${start field}
    ${datetimepicker[0]} should appear
    Select current date and time for ${datetimepicker[0]}
    click on ${end field}
    ${datetimepicker[1]} should appear
    Select current date and time for ${datetimepicker[1]}
