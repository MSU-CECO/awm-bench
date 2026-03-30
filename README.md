# AWM-Bench Leaderboard

A leaderboard for AI benchmarks in **Agricultural Water Management (AWM)**.

**Live site:** https://dsiweb.cse.msu.edu/awm-bench/  
**Repository:** https://gitlab.msu.edu/MSU-CECO/awm-bench

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

## Development
```bash
npm install
npm run dev        # http://localhost:5173
npm run build      # dist/
```

---

## Deployment (IIS on Windows Server)

The site is served as a virtual directory under the `dsiweb` IIS application at MSU.

**Server path:** `C:\inetpub\wwwroot\dsiweb\paper_demos\awm-bench\dist`  
**IIS virtual directory alias:** `awm-bench`

### To deploy an update

RDP into the server, then run:
```powershell
.\deploy.ps1
```

This pulls the latest code, installs dependencies, builds with the correct base path, and copies `web.config` into `dist/`.

### Manual steps (already replicated in deploy.ps1)
```cmd
git pull
cmd /C "set VITE_BASE_PATH=/awm-bench/ && npm run build"
copy web.config dist\web.config
```

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

---

## Project structure
```
awm-bench/
├── src/
│   ├── data/
│   │   ├── benchmarks.json    # benchmark metadata
│   │   └── results.json       # all model scores
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
├── web.config          # IIS MIME type config
├── deploy.ps1          # one-click deploy script
├── package.json
└── README.md
```