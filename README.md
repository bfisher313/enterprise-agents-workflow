# Enterprise Agentic Workflow Platform - Architectural Overview

## Project Overview

This repository contains the high-level solution architecture for the **Enterprise Agentic Workflow Platform**. This platform is a proprietary, conversational AI system designed to replace the existing Moveworks platform, eliminating significant licensing costs and establishing a strategic, extensible asset for enterprise-wide workflow automation.

The solution is delivered through a chatbot in **Microsoft Teams** and is architected around a modern, decoupled technology stack:

-   **Orchestration Engine:** A central "brain" built using **LangGraph** to manage complex, stateful business processes.
-   **Integration Standard:** A "first-class" adoption of the **Model Context Protocol (MCP)** to ensure all system integrations are standardized, scalable, and interchangeable.
-   **Cloud Platform:** Hosted on **Microsoft Azure**, leveraging its robust services for compute, security, and identity.

The primary goal of the initial MVP is to replicate and replace the existing ServiceNow functionality, with a clear roadmap to integrate with other key enterprise systems like Salesforce, SAP, and on-premise SharePoint.

---

## Navigating This Repository

The primary architectural document is designed to be read as a single file, but the repository is structured for clarity.

-   [Architecture.md](Architecture.md): This is the main, comprehensive document containing the full architectural overview, from the high-level context to the detailed integration patterns. **This is the best place to start reading.**
-   **`/diagrams`**: This directory contains the source code for the C4 architectural diagrams in the **Structurizr DSL** format. These files are provided for anyone wishing to render the diagrams in high resolution. There are also PNG files for quick reference.

---