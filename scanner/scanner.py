import os
import hashlib
import json
import datetime

def scan_file(filepath):
    """Return SHA-256 hash and fake confidence score for a file"""
    with open(filepath, "rb") as f:
        file_bytes = f.read()
        sha256 = hashlib.sha256(file_bytes).hexdigest()
        return {
            "file": filepath,
            "sha256": sha256,
            "confidence": "0.95"  # placeholder score for now
        }

if __name__ == "__main__":
    results = []
    files = os.listdir(".")

    for f in files:
        if os.path.isfile(f) and f != "scanner.py":
            results.append(scan_file(f))

    # Print results as JSON
    print(json.dumps(results, indent=2))

    # Append results to audit log
    with open("../logs/audit.log", "a") as log:
        for r in results:
            log.write(
                f"{datetime.datetime.now()} | {r['file']} | {r['sha256']} | confidence={r['confidence']}\n"
            )
