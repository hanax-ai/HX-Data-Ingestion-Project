# HX Data Ingestion Project

**A Spec-Driven Development project for building robust data ingestion workflows**

## Project Status

🚧 **Specification Phase** - Currently defining requirements and architecture using Spec-Driven Development methodology.

## Methodology

This project follows **Spec-Driven Development (SDD)** using the GitHub Spec Kit, where specifications become executable and drive implementation rather than just guiding it.

### Enhanced Workflow

1. **`/constitution`** - Establish project principles and guidelines
2. **`/specify`** - Define requirements and user stories (WHAT and WHY)
3. **`/clarify`** - Resolve ambiguities and under-specifications
4. **`/plan`** - Create technical implementation plan (HOW)
5. **`/tasks`** - Break down into actionable tasks
6. **`/analyze`** - Cross-check consistency before implementation
7. **`/implement`** - Execute the implementation

## Repository Structure

```
HX-Data-Ingestion-Project/
├── spec kit/                    # Spec-Driven Development workspace
│   ├── .specify/               # Spec Kit templates and scripts
│   │   ├── templates/          # Command templates for AI agents
│   │   └── scripts/            # Automation scripts (bash/powershell)
│   ├── memory/                 # Project constitution and principles
│   ├── specs/                  # Feature specifications (created per feature)
│   ├── docs/                   # Additional documentation
│   └── README.md               # Spec Kit workspace overview
├── src/                        # Source code (created during implementation)
├── tests/                      # Test files (created during implementation)
└── README.md                   # This file
```

## Environment Variables

The project has access to the following environment variables for future use:
- `HX_DIP_VAR` - Project-specific variable
- `HX_DIP_SECRET` - Project-specific secret

## Getting Started

### Prerequisites

- **AI Coding Agent**: Cursor (configured for this project)
- **Python 3.11+**
- **Git**
- **uv** for package management

### Development Workflow

Navigate to the `spec kit/` directory to begin specification work:

```bash
cd "spec kit"
```

Then follow the SDD workflow:

1. **Initialize Feature**: Use `/specify` to define what you want to build
2. **Clarify Requirements**: Use `/clarify` to resolve any ambiguities
3. **Plan Implementation**: Use `/plan` to define technical approach
4. **Analyze Consistency**: Use `/analyze` to validate alignment
5. **Execute**: Use `/implement` to build the feature

## Core Principles

- **Intent-Driven Development**: Focus on WHAT and WHY before HOW
- **Executable Specifications**: Specs generate working implementations
- **Continuous Refinement**: Iterative improvement through AI-powered validation
- **Constitutional Compliance**: All development aligns with project principles

## Documentation

- **[Spec Kit Workspace](./spec%20kit/)** - Complete SDD workspace with templates and specifications
- **[Spec-Driven Methodology](./spec-driven-methodology.md)** - Complete SDD methodology
- **[Spec Kit Knowledge](./SPEC_KIT_KNOWLEDGE.md)** - GitHub Spec Kit overview
- **[Latest Updates](./NEW_SPEC_KIT_UPDATES_ANALYSIS.md)** - Recent enhancements including `/clarify` and `/analyze`

## Contributing

This project uses Spec-Driven Development. All contributions should follow the established workflow:

1. Navigate to `spec kit/` directory
2. Create feature specifications using `/specify`
3. Clarify requirements using `/clarify`
4. Plan implementation using `/plan`
5. Validate with `/analyze`
6. Implement using `/implement`

## License

This project is licensed under the MIT License.

---

**Ready to begin specification and development using the enhanced Spec Kit methodology.**
