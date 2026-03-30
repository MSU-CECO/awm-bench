# AWM-Bench Leaderboard

A simple leaderboard for AI benchmarks in **Agricultural Water Management (AWM)**.

**Live site:** `https://dsi-lab.gitlab.io/awm-bench/`

---

## Benchmarks

| ID | Full Name | Paper | Task |
|----|-----------|-------|------|
| `agxqa` | Agricultural Extension QA | [P1 · CAEG 2024](https://doi.org/10.1016/j.compag.2024.109349) | Extractive QA |
| `dew-logiq` | DEW — Logical Reasoning | [P2 · CAEG 2026](https://doi.org/10.1016/j.compag.2026.111533) | Multiple-Choice QA (Logic) |
| `dew-mathq` | DEW — Mathematical Reasoning | P2 | Multiple-Choice QA (Math) |
| `farmpro-q2s` | FarmPro Query-to-Structure | [P3 · CAEG 2026](https://doi.org/10.1016/j.compag.2026.111533) | Semantic Parsing |
| `farmpro-qa` | FarmPro QA | P3 | Simulation-Grounded QA |

---

## Development

```bash
npm install
npm run dev        # http://localhost:5173
npm run build      # dist/
npm run preview    # preview production build
```

---

## Submitting Results

1. **Fork** this repo.
2. **Edit** `src/data/results.json` — add your model entry under the appropriate benchmark key:

```json
{
  "rank": 1,
  "model": "YourModel",
  "model_url": "https://arxiv.org/abs/...",
  "credibility": "community",
  "verified": false,
  "date": "2026",
  "notes": "Brief description of the setup.",
  "metrics": {
    "F1": 72.5,
    "EM": 48.3
  }
}
```

3. **Open a Merge Request** titled `[<benchmark>] <Model>: <brief description>`.
4. Link your paper / evaluation code. Authors will review and merge.

### Credibility levels

| Value | Meaning |
|-------|---------|
| `peer-reviewed` | Published journal or conference paper |
| `preprint` | arXiv or similar preprint |
| `report` | Technical report or workshop paper |
| `community` | Self-reported (no paper required) |

---

## Project structure

```
awm-bench/
├── src/
│   ├── data/
│   │   ├── benchmarks.json    # benchmark metadata
│   │   └── results.json       # all model scores (edit this to add results)
│   ├── components/
│   │   ├── TheHeader.vue
│   │   ├── HeroSection.vue
│   │   ├── BenchmarkTabs.vue
│   │   ├── BenchmarkInfo.vue
│   │   ├── LeaderboardTable.vue
│   │   ├── ScoreBar.vue
│   │   ├── ScoreCell.vue
│   │   ├── SubmitInfo.vue
│   │   └── TheFooter.vue
│   ├── App.vue
│   ├── main.js
│   └── style.css
├── index.html
├── vite.config.js
├── package.json
├── .gitlab-ci.yml
└── README.md
```

---

## Citation

If you use AWM-Bench benchmarks, please cite the relevant papers:

```bibtex
@article{KPODO2024109349,
  title   = {AgXQA: A benchmark for advanced Agricultural Extension question answering},
  author  = {Josué Kpodo and Parisa Kordjamshidi and A. Pouyan Nejadhashemi},
  journal = {Computers and Electronics in Agriculture},
  volume  = {225},
  year    = {2024},
  doi     = {10.1016/j.compag.2024.109349}
}

@article{KPODO2026111533,
  title   = {Evaluating the logical and mathematical reasoning capabilities of language models in agricultural water management},
  author  = {Josué Kpodo and A.Pouyan Nejadhashemi and Rasu Eeswaran},
  journal = {Computers and Electronics in Agriculture},
  volume  = {245},
  year    = {2026},
  doi     = {10.1016/j.compag.2026.111533}
}

@article{KPODO2026111655,
  title   = {Closing the gap between crop simulation and practical decision-making},
  author  = {Josué Kpodo and A.Pouyan Nejadhashemi and Parisa Kordjamshidi and Rasu Eeswaran and Younsuk Dong},
  journal = {Computers and Electronics in Agriculture},
  volume  = {247},
  year    = {2026},
  doi     = {10.1016/j.compag.2026.111655},
}
```
