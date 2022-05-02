*** Settings ***
Library           scenario.framework.main.Keyword
Resource          Production_Keywords.robot
Resource          Fixed Assets_Keywords.robot
Resource          Trade Agreement_Keywords.robot
Resource          Procurement_Keywords.robot
Resource          Cash and Bank Management_Keywords.robot
Resource          Purchasing_Keywords.robot
Resource          Commands_Keywords.robot
Resource          ExFlow_Keywords.robot
Resource          Credit and Collections_Keywords.robot
Resource          Project_Keywords.robot
Resource          Request For Quotation_Keywords.robot
Resource          Components_Keywords.robot
Resource          Sales_Keywords.robot
Resource          Budgeting_Keywords.robot
Resource          GST_Keywords.robot
Resource          Finance_Keywords.robot
Resource          Customer_Keywords.robot
Resource          Accounts Payable_Keywords.robot
Resource          Organization_Keywords.robot
Resource          Generic_Keywords.robot
Resource          Handheld_Keywords.robot
Resource          Intercompany_Keywords.robot
Resource          Accounts Receivable_Keywords.robot
Resource          Variables/${VariableSet}/General_Variables.robot
Resource          Variables/${VariableSet}/General_Variables.robot
Resource          Variables/${VariableSet}/General_Variables.robot
Resource          Inventory_Keywords.robot
Resource          Import_Keywords.robot
Resource          Shipment_Keywords.robot
Resource          System Admin_Keywords.robot
Resource          Tax_Keywords.robot
Resource          Foreign_Currency_Keywords.robot
Resource          Customer_Created_Keywords.robot
Resource          Vendor_Keywords.robot
Resource          General Ledger_Keywords.robot
Resource          ../../../Commands_Keywords.robot
Resource          ../../../Variables/${VariableSet}/General_Variables.robot
Resource          ../../../Variables/${VariableSet}/General_Variables.robot
Resource          ../../../../Base_Keywords.robot
Resource          ../../../../Commands_Keywords.robot
Resource          ../../../../Variables/${VariableSet}/General_Variables.robot
Resource          ../../../../Customer_Created_Keywords.robot
Library           Dialogs
Library           String
Library           Collections

*** Test Cases ***
Citta81-UAT - Create purchase order EUR Furniture Maintain charge
    [Tags]    Edited:true
    Initialize Test    Finops
    Open Browser
    Set Configuration Value    URL    ${Citta81 UAT Server}
    Set Configuration Value    Company    ${Default Company}
    Set Configuration Value    Username    ${Default Username}
    Set Configuration Value    Password    ${Default Password}
    Login To Finops
    Set Configuration Value    Page    PurchTableListPage
    Go To Finops Page
    Set Configuration Actions    PO Header    Vendor account = VIT001    Enter Values    Warehouse = AAP
    Purchasing - Create Purchase Order
    Get Date    ${Default Date Format}
    Set Configuration Actions    Header details    Delivery date = 7/12/2022    Due date = 15/12/2022    Enter Values    Ship date = 26/12/2022    Enter Values    Customer reference = ${Citta81-UAT AX version} EUR Furniture VMOULD
    Purchasing - Add Header details
    Set Configuration Actions    Activity Details    Activity template = PO-IMPORT1
    Purchasing - Copy Activity Template
    Set Row Variable    Item number row = VIT4402011001    Enter Values    Quantity row = 100
    Set Row Variable    Enter Values    Item number row = VIT4402011004    Enter Values    Quantity row = 150
    Set Row Variable    Enter Values    Item number row = VIT4402011023    Enter Values    Quantity row = 100
    Set Row Variable    Enter Values    Item number row = VIT4402011031    Enter Values    Quantity row = 150
    Purchasing - Create Purchase Lines
    Filter by Finops Column    Unit Price Header    1    greater than or equal
    Website Interaction    Press    Unit Price row[1]    Press    Unit Price row[2]    Press    Unit Price row[3]    Press    Unit Price row[4]
    Set Row Variable    Enter Values    Charges code row = VMOULD    Charges value row = 100
    Purchasing - Maintain Charges
    Purchasing - Allocate Charges
    Purchasing - Confirm Purchase Order
    Generic - Save and Close
    Close Browser

Citta81-UAT - Post vendor deposit payment EUR
    Initialize Test    Finops
    Open Browser
    Set Configuration Value    URL    ${Citta81 UAT Server}
    Set Configuration Value    Company    ${Default Company}
    Set Configuration Value    Username    ${Default Username}
    Set Configuration Value    Password    ${Default Password}
    Login To Finops
    Set Configuration Value    Page    LedgerJournalTable5
    Go To Finops Page
    Set Row Variable    Enter Values    Name row = APPayEUR
    Finance - Create Journal Header Line
    Set Row Variable    Enter Values    Account row = VIT001    Enter Values    Description row = ${Citta81-UAT AX version} ${Current Purchase Order}    Enter Values    Payment reference row = ${Current Purchase Order}    Enter Values    Debit row = 70
    Finance - Add Journal Lines
    Generic - Post and Close
    Close Browser

Citta81-UAT - Create voyage FCL full qty
    [Tags]    Edited:true
    Initialize Test    Finops
    Open Browser
    Set Configuration Value    URL    ${Citta81 UAT Server}
    Set Configuration Value    Company    ${Default Company}
    Set Configuration Value    Username    ${Default Username}
    Set Configuration Value    Password    ${Default Password}
    Login To Finops
    Set Configuration Value    Page    PurchTableListPage
    Go To Finops Page
    Filter by Finops Column    Purchase order header    ${Current Purchase Order}    begins with
    Website Interaction    Press    Purchase order row
    Set Configuration Actions    Voyage Options    Enter Values    Description = ${Citta81-UAT AX version} ${Current Purchase Order}    Enter Values    Vessel = ${Citta81-UAT AX version} ${Current Purchase Order}    Enter Values    Journey template = CNSHA-NZAKL(S-COS)    Enter Values    Shipping company = MON001
    Purchasing - Voyage Creator
    Website Interaction    Enter Values    Days forward = 1000    Enter Values    Days back = 1000    Press    Refresh    Press    Select row
    Set Configuration Actions    Container    Enter Values    Shipping container = ${Citta81-UAT AX version} ${Current Purchase Order}Current Purchase Order}    Enter Values    Shipping container type = 40FT GP-COSCO
    Purchasing - Add To Shipping Container
    Generic - Close
    Generic - Close
    Close Browser


Citta81-UAT - Invoice Voyage
    Initialize Test    Finops
    Open Browser
    Set Configuration Value    URL    ${Citta81 UAT Server}
    Set Configuration Value    Company    ${Default Company}
    Set Configuration Value    Username    ${Default Username}
    Set Configuration Value    Password    ${Default Password}
    Login To Finops
    Set Configuration Value    Page    ITMTableListPage
    Go To Finops Page
    Filter by Finops Column    Voyage header    ${Current Voyage}    begins with
    Website Interaction    Press    Voyage row
    Set Configuration Actions    Invoice Details    Number = ${Current Purchase Order}INV    Enter Values    Invoice description = ${Current Purchase Order}INV    Enter Values    Invoice date = t
    Shipment - Tax Invoice
    Generic - Post and Close
    Close Browser

Citta81-UAT - Tracking 10-Load
    Initialize Test    Finops
    Open Browser
    Set Configuration Value    URL    ${Citta81 UAT Server}
    Set Configuration Value    Company    ${Default Company}
    Set Configuration Value    Username    ${Default Username}
    Set Configuration Value    Password    ${Default Password}
    Login To Finops
    Set Configuration Value    Page    ITMTableListPage
    Go To Finops Page
    Filter by Finops Column    Voyage header    ${Current Voyage}    begins with
    Website Interaction    Press    Voyage row
    Set Configuration Actions    Tracking Details    Enter Values    Start date row = t    Enter Values    Actual end date = t
    Shipment - Tracking
    Generic - Save and Close
    Close Browser



Citta81-UAT - Create item arrival journal full qty
    Initialize Test    Finops
    Open Browser
    Set Configuration Value    URL    ${Citta81 UAT Server}
    Set Configuration Value    Company    ${Default Company}
    Set Configuration Value    Username    ${Default Username}
    Set Configuration Value    Password    ${Default Password}
    Login To Finops
    Set Configuration Value    Page    ITMTableListPage
    Go To Finops Page
    Filter by Finops Column    Voyage header    ${Current Voyage}    begins with
    Website Interaction    Press    Voyage row
    Set Configuration Actions    Arrival Details    Enter Values    Initialise quantity radio = Yes    Enter Values    Create from goods in transit radio = Yes    Enter Values    Create from order lines radio = Yes
    Shipment - Create Arrival Journal
    Website Interaction    Enter Values    Description = ${Citta81-UAT AX version} ${Current Voyage}    Enter Values    Location row[1] = 01-A-03    Press    CW quantity row[1]    Enter Values    Location row[2] = 01-A-03    Press    CW quantity row[2]    Enter Values    Location row[3] = 01-A-03    Press    CW quantity row[3]    Enter Values    Location row[4] = 01-A-03    Press    CW quantity row[4]
    Generic - Save and Close
    Close Browser


Citta81-UAT - Post item arrival journal
    Initialize Test    Finops
    Open Browser
    Set Configuration Value    URL    ${Citta81 UAT Server}
    Set Configuration Value    Company    ${Default Company}
    Set Configuration Value    Username    ${Default Username}
    Set Configuration Value    Password    ${Default Password}
    Login To Finops
    Set Configuration Value    Page    WMSJournalReception
    Go To Finops Page
    Filter by Finops Column    Journal header    ${Current Arrival Journal}    begins with
    Website Interaction    Press    Journal row
    Website Interaction    Press    Validate menu    Press    Ok    Press    Post menu    Press    OK
    Check for warning messages
    Close Browser

Citta81-UAT - Tracking 20-Ship
    Initialize Test    Finops
    Open Browser
    Set Configuration Value    URL    ${Citta81 UAT Server}
    Set Configuration Value    Company    ${Default Company}
    Set Configuration Value    Username    ${Default Username}
    Set Configuration Value    Password    ${Default Password}
    Login To Finops
    Set Configuration Value    Page    ITMTableListPage
    Go To Finops Page
    Filter by Finops Column    Voyage header    ${Current Voyage}    begins with
    Website Interaction    Press    Voyage row
    Set Configuration Actions    Tracking Details    Enter Values    Start date row[2] = t    Enter Values    Actual end date[2] = t
    Shipment - Tracking
    Generic - Save and Close
    Close Browser


Citta81-UAT - Tracking 30-Customs
    [Tags]    Edited:true
    Initialize Test    Finops
    Open Browser
    Set Configuration Value    URL    ${Citta81 UAT Server}
    Set Configuration Value    Company    ${Default Company}
    Set Configuration Value    Username    ${Default Username}
    Set Configuration Value    Password    ${Default Password}
    Login To Finops
    Set Configuration Value    Page    ITMTableListPage
    Go To Finops Page
    Filter by Finops Column    Voyage header    ${Current Voyage}    begins with
    Website Interaction    Press    Voyage row
    Set Configuration Actions    Tracking Details    Enter Values    Start date row[3] = 30/11/2022    Enter Values    Actual end date row[3] = 30/11/2022
    Shipment - Tracking
    Generic - Save and Close
    Close Browser


Citta81-UAT - Tracking 50-Container return
    [Tags]    Edited:true
    Initialize Test    Finops
    Open Browser
    Set Configuration Value    URL    ${Citta81 UAT Server}
    Set Configuration Value    Company    ${Default Company}
    Set Configuration Value    Username    ${Default Username}
    Set Configuration Value    Password    ${Default Password}
    Login To Finops
    Set Configuration Value    Page    ITMTableListPage
    Go To Finops Page
    Filter by Finops Column    Voyage header    ${Current Voyage}    begins with
    Website Interaction    Press    Voyage row
    Set Configuration Actions    Tracking Details    Enter Values    Start date row[4] = 27/12/2022    Enter Values    Actual end date row[4] = 27/12/2022
    Shipment - Tracking
    Generic - Save and Close
    Close Browser

*** Keywords ***
Citta81-UAT - Create purchase order EUR Furniture Maintain charge
    [Tags]    Edited:true
    Initialize Test    Finops
    Open Browser
    Set Configuration Value    URL    ${Citta81 UAT Server}
    Set Configuration Value    Company    ${Default Company}
    Set Configuration Value    Username    ${Default Username}
    Set Configuration Value    Password    ${Default Password}
    Login To Finops
    Set Configuration Value    Page    PurchTableListPage
    Go To Finops Page
    Set Configuration Actions    PO Header    Vendor account = VIT001    Enter Values    Warehouse = AAP
    Purchasing - Create Purchase Order
    Get Date    ${Default Date Format}
    Set Configuration Actions    Header details    Delivery date = 7/12/2022    Due date = 15/12/2022    Enter Values    Ship date = 26/12/2022    Enter Values    Customer reference = ${Citta81-UAT AX version} EUR Furniture VMOULD
    Purchasing - Add Header details
    Set Configuration Actions    Activity Details    Activity template = PO-IMPORT1
    Purchasing - Copy Activity Template
    Set Row Variable    Item number row = VIT4402011001    Enter Values    Quantity row = 100
    Set Row Variable    Enter Values    Item number row = VIT4402011004    Enter Values    Quantity row = 150
    Set Row Variable    Enter Values    Item number row = VIT4402011023    Enter Values    Quantity row = 100
    Set Row Variable    Enter Values    Item number row = VIT4402011031    Enter Values    Quantity row = 150
    Purchasing - Create Purchase Lines
    Filter by Finops Column    Unit Price Header    1    greater than or equal
    Website Interaction    Press    Unit Price row[1]    Press    Unit Price row[2]    Press    Unit Price row[3]    Press    Unit Price row[4]
    Set Row Variable    Enter Values    Charges code row = VMOULD    Charges value row = 100
    Purchasing - Maintain Charges
    Purchasing - Allocate Charges
    Purchasing - Confirm Purchase Order
    Generic - Save and Close
    Close Browser

Citta81-UAT - Post vendor deposit payment EUR
    Initialize Test    Finops
    Open Browser
    Set Configuration Value    URL    ${Citta81 UAT Server}
    Set Configuration Value    Company    ${Default Company}
    Set Configuration Value    Username    ${Default Username}
    Set Configuration Value    Password    ${Default Password}
    Login To Finops
    Set Configuration Value    Page    LedgerJournalTable5
    Go To Finops Page
    Set Row Variable    Enter Values    Name row = APPayEUR
    Finance - Create Journal Header Line
    Set Row Variable    Enter Values    Account row = VIT001    Enter Values    Description row = ${Citta81-UAT AX version} ${Current Purchase Order}    Enter Values    Payment reference row = ${Current Purchase Order}    Enter Values    Debit row = 70
    Finance - Add Journal Lines
    Generic - Post and Close
    Close Browser

Citta81-UAT - Create voyage FCL full qty
    [Tags]    Edited:true
    Initialize Test    Finops
    Open Browser
    Set Configuration Value    URL    ${Citta81 UAT Server}
    Set Configuration Value    Company    ${Default Company}
    Set Configuration Value    Username    ${Default Username}
    Set Configuration Value    Password    ${Default Password}
    Login To Finops
    Set Configuration Value    Page    PurchTableListPage
    Go To Finops Page
    Filter by Finops Column    Purchase order header    ${Current Purchase Order}    begins with
    Website Interaction    Press    Purchase order row
    Set Configuration Actions    Voyage Options    Enter Values    Description = ${Citta81-UAT AX version} ${Current Purchase Order}    Enter Values    Vessel = ${Citta81-UAT AX version} ${Current Purchase Order}    Enter Values    Journey template = CNSHA-NZAKL(S-COS)    Enter Values    Shipping company = MON001
    Purchasing - Voyage Creator
    Website Interaction    Enter Values    Days forward = 1000    Enter Values    Days back = 1000    Press    Refresh    Press    Select row
    Set Configuration Actions    Container    Enter Values    Shipping container = ${Citta81-UAT AX version} ${Current Purchase Order}Current Purchase Order}    Enter Values    Shipping container type = 40FT GP-COSCO
    Purchasing - Add To Shipping Container
    Generic - Close
    Generic - Close
    Close Browser


Citta81-UAT - Invoice Voyage
    Initialize Test    Finops
    Open Browser
    Set Configuration Value    URL    ${Citta81 UAT Server}
    Set Configuration Value    Company    ${Default Company}
    Set Configuration Value    Username    ${Default Username}
    Set Configuration Value    Password    ${Default Password}
    Login To Finops
    Set Configuration Value    Page    ITMTableListPage
    Go To Finops Page
    Filter by Finops Column    Voyage header    ${Current Voyage}    begins with
    Website Interaction    Press    Voyage row
    Set Configuration Actions    Invoice Details    Number = ${Current Purchase Order}INV    Enter Values    Invoice description = ${Current Purchase Order}INV    Enter Values    Invoice date = t
    Shipment - Tax Invoice
    Generic - Post and Close
    Close Browser

Citta81-UAT - Tracking 10-Load
    Initialize Test    Finops
    Open Browser
    Set Configuration Value    URL    ${Citta81 UAT Server}
    Set Configuration Value    Company    ${Default Company}
    Set Configuration Value    Username    ${Default Username}
    Set Configuration Value    Password    ${Default Password}
    Login To Finops
    Set Configuration Value    Page    ITMTableListPage
    Go To Finops Page
    Filter by Finops Column    Voyage header    ${Current Voyage}    begins with
    Website Interaction    Press    Voyage row
    Set Configuration Actions    Tracking Details    Enter Values    Start date row = t    Enter Values    Actual end date = t
    Shipment - Tracking
    Generic - Save and Close
    Close Browser



Citta81-UAT - Create item arrival journal full qty
    Initialize Test    Finops
    Open Browser
    Set Configuration Value    URL    ${Citta81 UAT Server}
    Set Configuration Value    Company    ${Default Company}
    Set Configuration Value    Username    ${Default Username}
    Set Configuration Value    Password    ${Default Password}
    Login To Finops
    Set Configuration Value    Page    ITMTableListPage
    Go To Finops Page
    Filter by Finops Column    Voyage header    ${Current Voyage}    begins with
    Website Interaction    Press    Voyage row
    Set Configuration Actions    Arrival Details    Enter Values    Initialise quantity radio = Yes    Enter Values    Create from goods in transit radio = Yes    Enter Values    Create from order lines radio = Yes
    Shipment - Create Arrival Journal
    Website Interaction    Enter Values    Description = ${Citta81-UAT AX version} ${Current Voyage}    Enter Values    Location row[1] = 01-A-03    Press    CW quantity row[1]    Enter Values    Location row[2] = 01-A-03    Press    CW quantity row[2]    Enter Values    Location row[3] = 01-A-03    Press    CW quantity row[3]    Enter Values    Location row[4] = 01-A-03    Press    CW quantity row[4]
    Generic - Save and Close
    Close Browser


Citta81-UAT - Post item arrival journal
    Initialize Test    Finops
    Open Browser
    Set Configuration Value    URL    ${Citta81 UAT Server}
    Set Configuration Value    Company    ${Default Company}
    Set Configuration Value    Username    ${Default Username}
    Set Configuration Value    Password    ${Default Password}
    Login To Finops
    Set Configuration Value    Page    WMSJournalReception
    Go To Finops Page
    Filter by Finops Column    Journal header    ${Current Arrival Journal}    begins with
    Website Interaction    Press    Journal row
    Website Interaction    Press    Validate menu    Press    Ok    Press    Post menu    Press    OK
    Check for warning messages
    Close Browser

Citta81-UAT - Tracking 20-Ship
    Initialize Test    Finops
    Open Browser
    Set Configuration Value    URL    ${Citta81 UAT Server}
    Set Configuration Value    Company    ${Default Company}
    Set Configuration Value    Username    ${Default Username}
    Set Configuration Value    Password    ${Default Password}
    Login To Finops
    Set Configuration Value    Page    ITMTableListPage
    Go To Finops Page
    Filter by Finops Column    Voyage header    ${Current Voyage}    begins with
    Website Interaction    Press    Voyage row
    Set Configuration Actions    Tracking Details    Enter Values    Start date row[2] = t    Enter Values    Actual end date[2] = t
    Shipment - Tracking
    Generic - Save and Close
    Close Browser


Citta81-UAT - Tracking 30-Customs
    [Tags]    Edited:true
    Initialize Test    Finops
    Open Browser
    Set Configuration Value    URL    ${Citta81 UAT Server}
    Set Configuration Value    Company    ${Default Company}
    Set Configuration Value    Username    ${Default Username}
    Set Configuration Value    Password    ${Default Password}
    Login To Finops
    Set Configuration Value    Page    ITMTableListPage
    Go To Finops Page
    Filter by Finops Column    Voyage header    ${Current Voyage}    begins with
    Website Interaction    Press    Voyage row
    Set Configuration Actions    Tracking Details    Enter Values    Start date row[3] = 30/11/2022    Enter Values    Actual end date row[3] = 30/11/2022
    Shipment - Tracking
    Generic - Save and Close
    Close Browser


Citta81-UAT - Tracking 50-Container return
    [Tags]    Edited:true
    Initialize Test    Finops
    Open Browser
    Set Configuration Value    URL    ${Citta81 UAT Server}
    Set Configuration Value    Company    ${Default Company}
    Set Configuration Value    Username    ${Default Username}
    Set Configuration Value    Password    ${Default Password}
    Login To Finops
    Set Configuration Value    Page    ITMTableListPage
    Go To Finops Page
    Filter by Finops Column    Voyage header    ${Current Voyage}    begins with
    Website Interaction    Press    Voyage row
    Set Configuration Actions    Tracking Details    Enter Values    Start date row[4] = 27/12/2022    Enter Values    Actual end date row[4] = 27/12/2022
    Shipment - Tracking
    Generic - Save and Close
    Close Browser
