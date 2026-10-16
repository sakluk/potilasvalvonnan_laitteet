*** Settings ***
Library    SerialLibrary    ${PORTTI}    encoding=ascii    baudrate=115200    timeout=3    rtscts=True
Library    String

*** Variables ***
# (Macbook Portti)
${PORTTI}    /dev/cu.usbserial-14110 

*** Test Cases ***
Test Serial Connection
    [Documentation]    Testaa ProSim 8 -sarjayhteyden.
    [Teardown]    Close Port

    Open Port
    Port Should Be Open

    # Siirry etäohjaukseen
    Write Data    REMOTE\n
    ${response}=    Read Until    terminator=\n
    ${response}=    Strip String    ${response}
    Log    Vastaanotettu: ${response}
    Should Be Equal As Strings    ${response}    RMAIN

    # Tarkista käyttötila
    Write Data    QMODE\n
    ${response}=    Read Until    terminator=\n
    ${response}=    Strip String    ${response}
    Log    Vastaanotettu: ${response}
    Should Be Equal As Strings    ${response}    RMAIN

    # Palauta paikallisohjaukseen
    Write Data    LOCAL\n
    ${response}=    Read Until    terminator=\n
    ${response}=    Strip String    ${response}
    Log    Vastaanotettu: ${response}
    Should Be Equal As Strings    ${response}    LOCAL