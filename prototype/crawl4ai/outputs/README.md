# Outputs Directory

This directory stores run artifacts grouped by script, then by run-id (timestamp).

## Structure

```
outputs/
├── single_page/           # 1-crawl_single_page.py runs
│   └── 2025-09-24T163015Z/    # run-id (timestamp)
│       ├── index.json         # per-run manifest
│       ├── logs.jsonl         # structured logs (one JSON per line)
│       └── ai-pydantic-dev.md # extracted markdown per URL
├── sitemap_sequential/    # 2-crawl_docs_sequential.py runs
├── sitemap_parallel/      # 3-crawl_sitemap_in_parallel.py runs
└── llms_chunked/          # 4-crawl_llms_txt.py runs
```

## Per-Run Manifest (index.json)

Each run writes an `index.json` manifest:

```json
{
  "script": "1-crawl_single_page.py",
  "run_id": "2025-09-24T163015Z",
  "started_at": "2025-09-24T16:30:15Z",
  "ended_at": "2025-09-24T16:30:18Z",
  "items": [
    {
      "url": "https://ai.pydantic.dev/",
      "success": true,
      "out_file": "ai-pydantic-dev.md",
      "duration_ms": 2471,
      "error": null
    }
  ],
  "summary": { "total": 1, "success": 1, "failed": 0 }
}
```

## Files

- **`index.json`** - Manifest of the run with metadata and results
- **`logs.jsonl`** - Structured logs (one JSON object per line)
- **`*.md`** - Extracted markdown content per URL

## Git Handling

- **Structure preserved** - Directory structure is tracked in git
- **Artifacts excluded** - Actual run outputs are gitignored to avoid bloat
- **Documentation included** - This README and .gitkeep are tracked
