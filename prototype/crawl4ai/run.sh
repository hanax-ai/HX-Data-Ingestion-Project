#!/bin/bash
# Launcher script for Crawl4AI prototype
# Sets PYTHONPATH and runs commands with proper module resolution

# Set PYTHONPATH to include the prototype directory
export PYTHONPATH="$(pwd):$PYTHONPATH"

# Check if any arguments were provided
if [ $# -eq 0 ]; then
    echo "Usage: ./run.sh <command>"
    echo ""
    echo "Examples:"
    echo "  ./run.sh python src/doc_ingest.py --help"
    echo "  ./run.sh python src/rag_agent.py --help"
    echo "  ./run.sh streamlit run app/streamlit_app.py"
    echo ""
    echo "Or run commands directly with PYTHONPATH:"
    echo "  PYTHONPATH=. python src/doc_ingest.py --help"
    echo "  PYTHONPATH=. python src/rag_agent.py --help"
    echo "  PYTHONPATH=. streamlit run app/streamlit_app.py"
    exit 1
fi

# Execute the command with the proper PYTHONPATH
exec "$@"
