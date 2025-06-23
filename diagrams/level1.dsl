workspace "Enterprise Agentic Workflow Platform" "Architectural documentation using the C4 model." {

    model {
        # Actors
        employee = person "Employee" "A user of the enterprise systems." "Person"

        # External Systems
        teams = softwareSystem "Microsoft Teams" "Collaboration and chat platform." "External"
        entraId = softwareSystem "Microsoft Entra ID" "Identity and Access Management." "External"
        serviceNow = softwareSystem "ServiceNow" "IT Service Management Platform." "External"
        salesforce = softwareSystem "Salesforce" "Customer Relationship Management Platform." "External"
        sap = softwareSystem "SAP S/4HANA" "Enterprise Resource Planning Platform." "External"
        sharepoint = softwareSystem "SharePoint (On-Premise)" "Petabyte-scale document management and storage." "External"

        # The System
        enterpriseAgent = softwareSystem "Enterprise Agentic Workflow Platform" "Provides a unified conversational interface to enterprise systems." {
            // Level 2 Containers will be defined in the next diagram
        }

        # Level 1 Relationships
        employee -> teams "Interacts via chat"
        teams -> enterpriseAgent "Sends user requests and renders UI responses" "REST/HTTPS"

        enterpriseAgent -> entraId "Authenticates user via SSO" "OAuth 2.0"
        enterpriseAgent -> serviceNow "Manages ITSM tickets (MVP)" "REST/HTTPS"
        enterpriseAgent -> salesforce "Manages CRM data (Future)" "REST/HTTPS"
        enterpriseAgent -> sap "Manages ERP data (Future)" "OData/HTTPS"
        enterpriseAgent -> sharepoint "Accesses documents via Hybrid Connection" "REST/HTTPS"
    }

    views {
        systemContext enterpriseAgent "SystemContext" "A high-level view of the Enterprise Agentic Workflow Platform and its interactions." {
            include *
            autoLayout
        }

        styles {
            element "Person" {
                shape Person
                background #08427b
                color #ffffff
            }
            element "Software System" {
                background #1168bd
                color #ffffff
            }
            element "External" {
                background #999999
                color #ffffff
            }
        }
    }
}