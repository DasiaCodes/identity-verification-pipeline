# Error Log – Bio Secure DevOps Pipeline

This file tracks every failure I hit while building the Bio Secure MVP.  
Format: Date – Error, Command, Error Message, Fix.

---

## [2025-09-23] – GitHub Authentication Failed
**Command:**
```
git push origin main
```

**Error Message:**
```
remote: Invalid username or token
fatal: Authentication failed for 'https://github.com/DasiaCodes/identity-verification-pipeline.git/'
```

**Fix:**
- Generated a new fine-grained GitHub token.
- Updated the remote URL with:
```
git remote set-url origin https://<NEW_TOKEN>@github.com/DasiaCodes/identity-verification-pipeline.git
```

---

## [2025-09-23] – Merge Conflict in README.md
**Command:**
```
git pull origin main --rebase
```

**Error Message:**
```
CONFLICT (content): Merge conflict in README.md
```

**Fix:**
- Opened `README.md` in `nano`.
- Removed conflict markers (`<<<<<<<`, `=======`, `>>>>>>>`).
- Kept the correct version of the file.
- Marked it resolved:
```
git add README.md
git rebase --continue
```

---

## [2025-09-24] – Permission Denied File Error
**Command:**
```
python3 scanner.py
```

**Error Message (JSON output):**
```
{
  "file": "badfile.txt",
  "sha256": null,
  "size_bytes": null,
  "confidence": null,
  "status": "ERROR: [Errno 13] Permission denied: 'badfile.txt'"
}
```

**Fix:**
- Verified error handling worked correctly.
- Confirmed scanner logged the error in `audit.log` instead of crashing.

