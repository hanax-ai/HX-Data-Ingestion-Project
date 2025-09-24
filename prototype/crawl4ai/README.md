# Crawl4AI Prototype - Documentation Crawler & RAG Agent

An intelligent documentation crawler and retrieval-augmented generation (RAG) system, powered by Crawl4AI and Pydantic AI. This project enables you to crawl, chunk, and vectorize documentation from any website, `.txt`/Markdown pages (llms.txt), or sitemap, and interact with the knowledge base using a Streamlit interface.

---

## Features

- **Flexible documentation crawling:** Handles regular websites, `.txt`/Markdown pages (llms.txt), and sitemaps.
- **Parallel and recursive crawling:** Efficiently gathers large doc sites with memory-adaptive batching.
- **Smart chunking:** Hierarchical Markdown chunking by headers, ensuring chunks are optimal for vector search.
- **Vector database integration:** Stores chunks and metadata in ChromaDB for fast semantic retrieval.
- **Streamlit RAG interface:** Query your documentation with LLM-powered semantic search.
- **Extensible examples:** Modular scripts for various crawling and RAG workflows.

---

## Directory Structure

```
prototype/crawl4ai/
├── src/                        # Core source modules
│   ├── __init__.py            # Package initialization
│   ├── doc_ingest.py          # Document ingestion and processing
│   ├── rag_agent.py           # RAG agent implementation
│   └── utils.py               # Utility functions
├── app/                       # Application interfaces
│   └── streamlit_app.py       # Streamlit web interface
├── examples/                  # Example scripts and demos
│   ├── 1-crawl_single_page.py
│   ├── 2-crawl_docs_sequential.py
│   ├── 3-crawl_sitemap_in_parallel.py
│   ├── 4-crawl_llms_txt.py
│   └── 5-crawl_site_recursively.py
├── requirements.txt           # Python dependencies
├── .env.example              # Environment variables template
├── run.sh                    # Launcher script with PYTHONPATH
└── README.md                 # This file
```

---

## Prerequisites

- Python 3.11+
- OpenAI API key (for embeddings and LLM-powered search)
- Crawl4AI/Playwright and other dependencies in `requirements.txt`
- (Optional) Streamlit for the web interface

---

## Installation

1. **Navigate to the prototype directory:**
   ```bash
   cd prototype/crawl4ai
   ```

2. **Install dependencies:**
   ```bash
   python -m venv venv
   source venv/bin/activate  # On Windows: venv\Scripts\activate
   pip install -r requirements.txt
   playwright install
   ```

3. **Set up environment variables:**
   - Copy `.env.example` to `.env`
   - Edit `.env` with your API keys and preferences:
     ```env
     OPENAI_API_KEY=your_openai_api_key  # REQUIRED
     MODEL_CHOICE=gpt-4o-mini            # OPTIONAL
     ```

---

## Usage

### Running from Repository Root

All commands should be run from the **repository root directory** (not from `prototype/crawl4ai/`):

#### Document Ingestion
```bash
# Get help for document ingestion
PYTHONPATH=prototype/crawl4ai python prototype/crawl4ai/src/doc_ingest.py --help

# Crawl and ingest documentation
PYTHONPATH=prototype/crawl4ai python prototype/crawl4ai/src/doc_ingest.py https://ai.pydantic.dev/

# Crawl a .txt file (like llms.txt)
PYTHONPATH=prototype/crawl4ai python prototype/crawl4ai/src/doc_ingest.py https://ai.pydantic.dev/llms-full.txt

# Crawl from sitemap
PYTHONPATH=prototype/crawl4ai python prototype/crawl4ai/src/doc_ingest.py https://ai.pydantic.dev/sitemap.xml
```

#### RAG Agent
```bash
# Get help for RAG agent
PYTHONPATH=prototype/crawl4ai python prototype/crawl4ai/src/rag_agent.py --help

# Ask a question using the RAG agent
PYTHONPATH=prototype/crawl4ai python prototype/crawl4ai/src/rag_agent.py --question "How do I create a Pydantic AI agent?"
```

#### Streamlit Interface
```bash
# Launch the Streamlit web interface
PYTHONPATH=prototype/crawl4ai streamlit run prototype/crawl4ai/app/streamlit_app.py
```

### Alternative: Using the Launcher Script

From within the `prototype/crawl4ai/` directory, you can use the provided launcher script:

```bash
cd prototype/crawl4ai

# Document ingestion
./run.sh python src/doc_ingest.py --help
./run.sh python src/doc_ingest.py https://ai.pydantic.dev/

# RAG agent
./run.sh python src/rag_agent.py --help
./run.sh python src/rag_agent.py --question "How do I create a Pydantic AI agent?"

# Streamlit interface
./run.sh streamlit run app/streamlit_app.py
```

---

## Required Environment Variables

Reference `.env.example` for all configuration options:

- **`OPENAI_API_KEY`** - **REQUIRED** - Your OpenAI API key for embeddings and LLM
- **`MODEL_CHOICE`** - **OPTIONAL** - OpenAI model to use (defaults to gpt-4.1-mini)
- **`CHROMA_DB_DIR`** - **OPTIONAL** - ChromaDB storage directory (defaults to ./chroma_db)
- **`COLLECTION_NAME`** - **OPTIONAL** - Default collection name (defaults to 'docs')
- **`EMBEDDING_MODEL`** - **OPTIONAL** - Embedding model name (defaults to all-MiniLM-L6-v2)

---

## Document Ingestion (`src/doc_ingest.py`)

The main entry point for crawling and vectorizing documentation:

### Supported URL Types

- **Regular documentation sites:** Recursively crawls all internal links, deduplicates by URL (ignoring fragments).
- **Markdown or .txt pages (such as llms.txt):** Fetches and chunks Markdown content.
- **Sitemaps (`sitemap.xml`):** Batch-crawls all URLs listed in the sitemap.

### Command Line Arguments

```bash
PYTHONPATH=prototype/crawl4ai python prototype/crawl4ai/src/doc_ingest.py <URL> [OPTIONS]
```

**Arguments:**
- `URL`: The root URL, .txt file, or sitemap to crawl.
- `--collection`: ChromaDB collection name (default: `docs`)
- `--db-dir`: Directory for ChromaDB data (default: `./chroma_db`)
- `--embedding-model`: Embedding model for vector storage (default: `all-MiniLM-L6-v2`)
- `--chunk-size`: Maximum characters per chunk (default: `1000`)
- `--max-depth`: Recursion depth for regular URLs (default: `3`)
- `--max-concurrent`: Max parallel browser sessions (default: `10`)
- `--batch-size`: Batch size for ChromaDB insertion (default: `100`)

### Chunking Strategy

- Splits content first by `#`, then by `##`, then by `###` headers.
- If a chunk is still too large, splits by character count.
- All chunks are less than the specified `--chunk-size` (default: 1000 characters).

### Metadata

Each chunk is stored with:
- Source URL
- Chunk index
- Extracted headers
- Character and word counts

---

## RAG Agent (`src/rag_agent.py`)

Interactive question-answering using the ingested documentation:

```bash
PYTHONPATH=prototype/crawl4ai python prototype/crawl4ai/src/rag_agent.py [OPTIONS]
```

**Arguments:**
- `--question`: The question to answer about the documentation
- `--collection`: ChromaDB collection name (default: `docs`)
- `--db-dir`: Directory for ChromaDB data (default: `./chroma_db`)
- `--embedding-model`: Embedding model name (default: `all-MiniLM-L6-v2`)
- `--n-results`: Number of results to return from retrieval (default: `5`)

---

## Streamlit Interface (`app/streamlit_app.py`)

After crawling and inserting docs, launch the Streamlit app for semantic search and question answering:

```bash
PYTHONPATH=prototype/crawl4ai streamlit run prototype/crawl4ai/app/streamlit_app.py
```

- The interface will be available at [http://localhost:8501](http://localhost:8501)
- Query your documentation using natural language and get context-rich answers.

---

## Example Scripts (`examples/`)

The `examples/` folder contains modular scripts illustrating different crawling and chunking strategies:

- **`1-crawl_single_page.py`:** Basic single page crawling
- **`2-crawl_docs_sequential.py`:** Sequential documentation crawling
- **`3-crawl_sitemap_in_parallel.py`:** Batch-crawls URLs from a sitemap in parallel with memory tracking
- **`4-crawl_llms_txt.py`:** Crawls a Markdown or `.txt` file, splits by headers, and prints chunks
- **`5-crawl_site_recursively.py`:** Recursively crawls all internal links from a root URL

Run examples with proper PYTHONPATH:
```bash
PYTHONPATH=prototype/crawl4ai python prototype/crawl4ai/examples/1-crawl_single_page.py
```

---

## Troubleshooting

### Import Errors

If you encounter import errors, ensure you're using the correct PYTHONPATH:

```bash
# From repository root
export PYTHONPATH=prototype/crawl4ai
python prototype/crawl4ai/src/doc_ingest.py --help

# Or use the launcher script from prototype/crawl4ai/
cd prototype/crawl4ai
./run.sh python src/doc_ingest.py --help
```

### Common Issues

- **Missing environment variables:** Ensure `.env` file is created with required `OPENAI_API_KEY`
- **Dependencies:** Run `pip install -r requirements.txt` and `playwright install`
- **Large sites:** Increase memory or decrease `--max-concurrent` for large documentation sites
- **Crawling issues:** Try running individual example scripts for isolated debugging

### Validation

- Ensure no import errors: `python -c "from src import doc_ingest, rag_agent, utils"`
- Test Streamlit app starts: `PYTHONPATH=prototype/crawl4ai streamlit run prototype/crawl4ai/app/streamlit_app.py`
- Verify help commands work: `PYTHONPATH=prototype/crawl4ai python prototype/crawl4ai/src/doc_ingest.py --help`

---

## Advanced Usage & Customization

- **Chunking:** Tune `--chunk-size` for your retrieval use case
- **Embeddings:** Swap out the embedding model with `--embedding-model`
- **Crawling:** Adjust `--max-depth` and `--max-concurrent` for large sites
- **Vector DB:** Use your own ChromaDB directory or collection for multiple projects
