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
    [Documentation]  Note: depends on external API. Should be changed to use fixtures.
    go to ${add_talk_page}
    fill in required fields
    type "oucs" into ${field('Venue')}
    ${suggestion popup} should appear
    ${suggestion popup} should contain text "7-19 Banbury Road"
    click on ${suggestion popup item('Banbury Road')}
    click on ${button done}
    current page should be ${talk page}
    ${success message} should be displayed
    ${success message} should contain text "New event has been created"
    page should contain text "Venue: 7-19 Banbury Road"
    

Scenario: Lookup department
    [Documentation]  Note: depends on external API. Should be changed to use fixtures.
    go to ${add_talk_page}
    fill in required fields
    type "biol" into ${field('Department')}
    ${suggestion popup} should appear
    ${suggestion popup} should contain text "Chemical Biology"
    click on ${suggestion popup item('Chemical Biology')}
    click on ${button done}
    current page should be ${talk page}
    ${success message} should be displayed
    ${success message} should contain text "New event has been created"
    page should contain text "Organiser: Chemical Biology"
    
Scenario: Lookup topic
    [Documentation]  Note: depends on external API. Should be changed to use fixtures.
    go to ${add_talk_page}
    fill in required fields
    type "biodiv" into ${field('Topic')}
    ${suggestion list} should appear
    ${suggestion list} should contain text "Biodiversity"
    click on ${suggested item('Biodiversity')}
    click on ${button done}
    current page should be ${talk page}
    ${success message} should be displayed
    ${success message} should contain text "New event has been created"
    page should contain text "Topics: Biodiversity"

Scenario: Lookup speaker
    create  person  name=James Bond
    go to ${add_talk_page}
    fill in required fields
    type "bon" into ${speaker field}
    ${suggestion list} should appear
    ${suggestion list} should contain text "James Bond"
    click on ${suggested item('James Bond')}
    click on ${button done}
    current page should be ${talk page}
    ${success message} should be displayed
    ${success message} should contain text "New event has been created"
    page should contain text "Speaker: James Bond"

Scenario: Create speaker on the go
    [Tags]  todo
Scenario: Save and add another
    [Tags]  todo
Scenario: Preserve form data after validation
    [Tags]  todo

*** Keywords ***
Fill in required fields
    type "${TEST_NAME}" into ${field('Title')}
