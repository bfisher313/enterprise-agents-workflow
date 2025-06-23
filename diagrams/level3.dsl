workspace "Enterprise Agentic Workflow Platform" "Architectural documentation using the C4 model." {

    model {
        // --- External systems shown for context in the diagram ---
        api = softwareSystem "Orchestration API" "The secure gateway that routes requests to the agentic core." "External"
        database = softwareSystem "State & Audit Database" "Persists workflow state and provides a comprehensive audit trail." "External"
        serviceNowMCPServer = softwareSystem "ServiceNow MCP Server" "Wraps the ServiceNow API and exposes it as a standard set of tools via MCP." "External"

        // --- The System and its hierarchy ---
        enterpriseAgent = softwareSystem "Enterprise Agentic Workflow Platform" "Provides a unified conversational interface to enterprise systems." {

            agentCore = container "LangGraph Agentic Core" "The 'brain' of the platform. Acts as an MCP Host to orchestrate workflows." {

                // --- Level 3 Components defined inside the container ---
                planner = component "Planner & Orchestrator" "Decomposes user requests into a plan of tool calls." "LangChain / LangGraph"
                stateGraph = component "Stateful Workflow Graph" "Executes the plan, calling tools as needed." "LangGraph"
                mcpClient = component "MCP Client & Toolset" "A generic client that can discover and execute tools from any MCP-compliant server." "Python | MCP SDK"
            }
        }

        // --- Relationships (using simple identifiers) ---
        // These relationships will be used by the view below.
        api -> planner "Invokes the planner with user request" "REST/HTTPS"
        planner -> stateGraph "Invokes a specific workflow graph"
        planner -> database "Reads/writes high-level state" "Cosmos DB SDK"
        stateGraph -> mcpClient "Requests tool execution"
        mcpClient -> serviceNowMCPServer "Sends standard MCP requests (e.g., tools/list, tools/call)" "JSON-RPC"
    }

    views {
        // --- The View definition ---
        component agentCore "Components" "The component diagram for the LangGraph Agentic Core." {
            // CORRECTED: Explicitly including every element in the view to remove ambiguity for the renderer.
            include planner
            include stateGraph
            include mcpClient
            include api
            include database
            include serviceNowMCPServer

            autoLayout
        }

        styles {
            element "Software System" {
                background #1168bd
                color #ffffff
            }
            element "Container" {
                background #438dd5
                color #ffffff
            }
            element "Component" {
                background #85bbf0
                color #000000
            }
            element "External" {
                background #999999
                color #ffffff
            }
        }
    }
}