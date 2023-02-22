*** Settings ***
Documentation       Helpers

Resource            base.robot


*** Keywords ***
Create a new Partner
    [Arguments]    ${partner}

    Remove Partner By Name    ${partner}[name]
    ${response}    POST Partner    ${partner}

    ${partner_id}    Set Variable    ${response.json()}[partner_id]

    RETURN    ${partner_id}
