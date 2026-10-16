*** Settings ***
Library    SerialLibrary    loop://    encoding=ascii    timeout=3
Library    String

*** Test Cases ***
Asennuksen tarkistus
    [Documentation]    Tarkistaa sarjaporttikirjaston toiminnan ilman laitetta.
    [Teardown]    Close Port
    Open Port
    Port Should Be Open
    Write Data    ASENNUS_OK\n
    ${vastaus}=    Read Until    terminator=\n
    ${vastaus}=    Strip String    ${vastaus}
    Should Be Equal As Strings    ${vastaus}    ASENNUS_OK