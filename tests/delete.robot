*** Settings ***
Documentation       DELETE /partners

Resource            ../resources/base.robot


*** Test Cases ***
Should remove a partner
    ${partner}    Factory Remove Partner
    ${partner_id}    Create a new Partner    ${partner}

    DELETE Partner    ${partner_id}
    Status Should Be    204

Should return 404 on remove partner
    ${partner}    Factory 404 Partner
    ${partner_id}    Create a new Partner    ${partner}

    Remove Partner By Name    ${partner}

    DELETE Partner    ${partner_id}
    Status Should Be    404
