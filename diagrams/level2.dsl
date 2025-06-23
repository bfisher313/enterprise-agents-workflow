workspace "Enterprise Agentic Workflow Platform" "Architectural documentation using the C4 model." {

    model {
        # Actors
        employee = person "Employee" "A user of the enterprise systems." "Person"

        # External Systems
        teams = softwareSystem "Microsoft Teams" "Collaboration and chat platform." "External"
        entraId = softwareSystem "Microsoft Entra ID" "Identity and Access Management." "External"
        serviceNowSys = softwareSystem "ServiceNow" "IT Service Management Platform." "External"
        salesforceSys = softwareSystem "Salesforce" "Customer Relationship Management Platform." "External"
        sapSys = softwareSystem "SAP S/4HANA" "Enterprise Resource Planning Platform." "External"
        sharepointSys = softwareSystem "SharePoint (On-Premise)" "Petabyte-scale document management and storage." "External"

        # The System
        enterpriseAgent = softwareSystem "Enterprise Agentic Workflow Platform" "Provides a unified conversational interface to enterprise systems." {
            # Level 2 Containers
            teamsBot = container "Teams Bot Front-End" "Handles user interaction within Microsoft Teams." "Azure App Service | Bot Framework" "Container"
            api = container "Orchestration API" "Securely routes requests from the bot to the agentic core." "Azure Functions" "Container"
            agentCore = container "LangGraph Agentic Core" "The MCP Host. Reasons, plans, and executes workflows by calling MCP Servers." "Azure Container Apps | LangGraph" "Container"

            # MCP Servers
            serviceNowServer = container "ServiceNow MCP Server" "Exposes ServiceNow actions (create ticket, get status) as a standard MCP service." "Azure Container Apps" "Container"
            salesforceServer = container "Salesforce MCP Server" "Exposes Salesforce actions as a standard MCP service. (Future)" "Azure Container Apps" "Container"
            sapServer = container "SAP MCP Server" "Exposes SAP actions as a standard MCP service. (Future)" "Azure Container Apps" "Container"
            sharepointServer = container "SharePoint MCP Server" "Exposes SharePoint Search as a standard MCP service via the Hybrid Connection. (Future)" "Azure Container Apps" "Container"

            # Supporting Containers
            keyVault = container "Secure Credential Store" "Stores all secrets, API keys, and credentials." "Azure Key Vault" "Container"
            database = container "State & Audit Database" "Persists workflow state and provides a comprehensive audit trail." "Azure Cosmos DB" "Container"
            hybridConnection = container "Hybrid Connection" "Provides secure network tunnel to on-premise systems." "Azure VPN Gateway or Hybrid Connection" "Container"
        }

        # Relationships
        employee -> teams "Interacts via chat"
        teams -> teamsBot "Sends user messages and events" "Bot Framework Protocol"

        teamsBot -> api "Forwards authenticated user requests" "REST/HTTPS"
        api -> agentCore "Invokes agent workflows" "REST/HTTPS"
        api -> entraId "Authenticates user via SSO" "OAuth 2.0"

        agentCore -> serviceNowServer "Discovers and calls tools" "JSON-RPC (MCP)"
        agentCore -> salesforceServer "Discovers and calls tools" "JSON-RPC (MCP)"
        agentCore -> sapServer "Discovers and calls tools" "JSON-RPC (MCP)"
        agentCore -> sharepointServer "Discovers and calls tools" "JSON-RPC (MCP)"

        agentCore -> database "Reads/writes workflow state and audit logs" "Cosmos DB SDK"

        serviceNowServer -> serviceNowSys "Calls API" "REST/HTTPS"
        serviceNowServer -> keyVault "Gets credentials"

        salesforceServer -> salesforceSys "Calls API" "REST/HTTPS"
        salesforceServer -> keyVault "Gets credentials"

        sapServer -> sapSys "Calls API" "OData/HTTPS"
        sapServer -> keyVault "Gets credentials"

        sharepointServer -> hybridConnection "Routes traffic" "TCP"
        sharepointServer -> keyVault "Gets credentials"
        hybridConnection -> sharepointSys "Calls on-prem API" "REST/HTTPS"
    }

    views {
        container enterpriseAgent "Containers" "The container diagram for the Enterprise Agentic Workflow Platform." {
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
            element "Container" {
                background #438dd5
                color #ffffff
            }
            element "External" {
                background #999999
                color #ffffff
            }
        }
    }
}
