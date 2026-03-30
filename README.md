# AWM-Bench Leaderboard

A leaderboard for AI benchmarks in **Agricultural Water Management (AWM)**.

**[Live site](https://dsiweb.cse.msu.edu/awm-bench/)** | **[Public Repository](https://github.com/MSU-CECO/awm-bench)** 

---

## Benchmarks

| ID | Full Name | Paper | Task |
|----|-----------|-------|------|
| `agxqa` | Agricultural Extension QA | [P1 · CAEG 2024](https://doi.org/10.1016/j.compag.2024.109349) | Extractive QA |
| `dew-logiq` | DEW — Logical Reasoning | [P2 · CAEG 2026](https://doi.org/10.1016/j.compag.2026.111533) | Multiple-Choice QA (Logic) |
| `dew-mathq` | DEW — Mathematical Reasoning | P2 | Multiple-Choice QA (Math) |
| `farmpro-q2s` | FarmPro Query-to-Structure | [P3 · CAEG 2026](https://doi.org/10.1016/j.compag.2026.111655) | Semantic Parsing |
| `farmpro-qa` | FarmPro QA | P3 | Simulation-Grounded QA |

---

## Submitting Results

1. **Fork** this repo on GitLab
2. **Edit** `src/data/results.json` to add your model entry under the appropriate benchmark key
3. **Open a Merge Request** e.g., titled `[<benchmark>] <Model>: <brief description>`
4. Link your paper or evaluation code for us to review before merging

### Entry schema
```json
{
  "rank": 1,
  "model": "YourModel",
  "model_url": "https://arxiv.org/abs/...",
  "credibility": "community",
  "verified": false,
  "date": "2026",
  "notes": "Brief description of the experimental setup.",
  "metrics": {
    "F1": 72.5,
    "EM": 48.3
  }
}
```

### Credibility levels

| Value | Meaning |
|-------|---------|
| `peer-reviewed` | Published journal or conference paper |
| `preprint` | arXiv or similar preprint |
| `report` | Technical report or workshop paper |
| `community` | Self-reported, no paper required |

---

## Citation

If you use AWM-Bench benchmarks, please cite the relevant papers. See how at this [link](https://dsiweb.cse.msu.edu/awm-bench/#benchmarks).
