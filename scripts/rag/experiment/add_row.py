"""Append one JSON object, read from stdin, to the given .rag/eval file, with a key check."""
import json, sys
KEYS = {
    'screen.jsonl': ['rank', 'file', 'decision', 'incidents', 'note'],
    'eval.jsonl': ['id', 'kind', 'catch', 'precatch_commit', 'precatch_source', 'precatch_text', 'query', 'target', 'note'],
}
name = sys.argv[1]
rows = json.loads(sys.stdin.read())
for row in rows if isinstance(rows, list) else [rows]:
    assert list(row) == KEYS[name], (list(row), KEYS[name])
    with open(f'.rag/eval/{name}', 'a') as f:
        f.write(json.dumps(row, ensure_ascii=False) + '\n')
print('ok', name, len(rows) if isinstance(rows, list) else 1)
