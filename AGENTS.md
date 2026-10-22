# AGENTS.md — auth-gateway

Public kit repo: auth gateway (Dex + OAuth2 Proxy) on Docker Compose. Read `README.md` first.
Full standard: https://github.com/devsiam-com/.github/blob/main/docs/github-standard.md

## Git
- Never push directly to `main`. Every change goes through a PR. Squash merge only; Post merges.
- Branch: `<type>/<monday-id>-<slug>` (types: feat, fix, infra, docs, chore, hotfix).
- Commits: Conventional Commits, `type(scope): summary`.
- Releases: SemVer tags `vX.Y.Z` only.
- CI must be green before merge. Run `pre-commit run --all-files` before pushing.

## Secrets
- This repo is public. Never commit secrets, `.env`, `dex-config.yaml`, `emails.txt`, OAuth client IDs/secrets, keys, client data or IP addresses.
- Commit only the `*.example` files, with placeholders.

## Docker
- Validate with `docker compose config --quiet`; the Dex image must pass the Trivy scan in CI (CRITICAL/HIGH).
- Pin image, package and action versions; never use `latest`. Do not pull packages from Alpine `edge`.
