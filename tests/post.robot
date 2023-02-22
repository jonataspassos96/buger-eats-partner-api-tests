*** Settings ***
Documentation       POST /partners

Resource            ../resources/base.robot


*** Test Cases ***
Should create a new partner
    [Tags]    happy

    Purge Messages

    ${partner}    Factory New Partner

    Remove Partner By Name    ${partner}[name]

    ${response}    POST Partner    ${partner}

    Status Should Be    201

    ${result}    Find Partner by Name    ${partner}[name]

    Should Be Equal    ${response.json()}[partner_id]    ${result}[_id]

    ${message}    Get Message

    Should Contain    ${message}[payload]    ${partner}[email]

Should return duplicate company name
    ${partner}    Factory Dup Name

    Create a new Partner    ${partner}

    ${response}    POST Partner    ${partner}
    Status Should Be    409

    Should Be Equal    ${response.json()}[message]    Duplicate company name
