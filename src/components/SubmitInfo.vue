<template>
  <section id="submit" class="submit-section">
    <div class="container">
      <div class="submit-grid">
        <!-- Left: info -->
        <div class="submit-copy">
          <div class="section-eyebrow">Community Contributions</div>
          <h2>Submit Your Results</h2>
          <p>
            If you have your own LLMs' results on AWM-Bench, we'd love to have you submit them via
            a <strong>GitHub Issue</strong>. We will review each submission before adding it to the leaderboard.
          </p>
          <ol class="steps">
            <li>
              <span class="step-num">1</span>
              <div>
                <strong>Open a GitHub Issue</strong>
                <span> using the "Submit Results" issue template.</span>
              </div>
            </li>
            <li>
              <span class="step-num">2</span>
              <div>
                <strong>Fill in your scores</strong>
                <span> following the schema example shown, for the benchmark(s) you evaluated on.</span>
              </div>
            </li>
            <li>
              <span class="step-num">3</span>
              <div>
                <strong>Link your evidence</strong>
                <span> i.e., paper DOI, arXiv URL, or public evaluation code.</span>
              </div>
            </li>
            <li>
              <span class="step-num">4</span>
              <div>
                <strong>We'll add it</strong>
                <span> to the leaderboard after review.</span>
              </div>
            </li>
          </ol>
          <div class="submit-actions">
            <a href="https://github.com/MSU-CECO/awm-bench/issues/new?template=submit_results.md" target="_blank" rel="noopener" class="btn btn-primary">
              <svg width="14" height="14" viewBox="0 0 16 16" fill="currentColor">
                <path d="M8 0C3.58 0 0 3.58 0 8c0 3.54 2.29 6.53 5.47 7.59.4.07.55-.17.55-.38 0-.19-.01-.82-.01-1.49-2.01.37-2.53-.49-2.69-.94-.09-.23-.48-.94-.82-1.13-.28-.15-.68-.52-.01-.53.63-.01 1.08.58 1.23.82.72 1.21 1.87.87 2.33.66.07-.52.28-.87.51-1.07-1.78-.2-3.64-.89-3.64-3.95 0-.87.31-1.59.82-2.15-.08-.2-.36-1.02.08-2.12 0 0 .67-.21 2.2.82.64-.18 1.32-.27 2-.27.68 0 1.36.09 2 .27 1.53-1.04 2.2-.82 2.2-.82.44 1.1.16 1.92.08 2.12.51.56.82 1.27.82 2.15 0 3.07-1.87 3.75-3.65 3.95.29.25.54.73.54 1.48 0 1.07-.01 1.93-.01 2.2 0 .21.15.46.55.38A8.013 8.013 0 0016 8c0-4.42-3.58-8-8-8z"/>
              </svg>
              Submit via GitHub Issue
            </a>
          </div>
        </div>

        <!-- Right: JSON schema snippet -->
        <div class="schema-card card">
          <div class="schema-header">
            <span class="schema-filename">entry schema: src/data/results.json</span>
            <span class="badge badge-community">Example</span>
          </div>
          <pre class="schema-code"><code>{
  "rank": 1,
  "model": "YourModel-Name",
  "model_url": "https://arxiv.org/abs/...",
  "credibility": "community",
  <span class="c-key">"verified"</span>: false,
  "date": "2026",
  "notes": "Zero-shot, GPT-4o backbone...",
  "metrics": {
    <span class="c-key">"F1"</span>: 72.5,
    <span class="c-key">"EM"</span>: 48.3
  }
}</code></pre>

          <div class="schema-rules">
            <div class="rule">
              <span class="rule-dot peer"/>
              <span><strong>published</strong>: published journal or conference paper</span>
            </div>
            <div class="rule">
              <span class="rule-dot preprint"/>
              <span><strong>preprint</strong>: arXiv or similar public preprint</span>
            </div>
            <div class="rule">
              <span class="rule-dot report"/>
              <span><strong>report</strong>: technical report, workshop paper</span>
            </div>
            <div class="rule">
              <span class="rule-dot community"/>
              <span><strong>community</strong>: self-reported, no paper required</span>
            </div>
          </div>
        </div>
      </div>
    </div>
  </section>
</template>

<style scoped>
.submit-section {
  background: var(--surface-alt);
  border-top: 1px solid var(--border);
  padding: 4.5rem 0;
}
.section-eyebrow {
  font-size: .76rem; font-weight: 600; text-transform: uppercase;
  letter-spacing: .08em; color: var(--green-vivid); margin-bottom: .6rem;
}
.submit-grid {
  display: grid; grid-template-columns: 1fr 1fr;
  gap: 3.5rem; align-items: start;
}
h2 { margin-bottom: .85rem; }
p { margin-bottom: 1.5rem; line-height: 1.7; }
.steps { list-style: none; display: flex; flex-direction: column; gap: .85rem; margin-bottom: 1.75rem; }
.steps li { display: flex; align-items: flex-start; gap: .85rem; }
.step-num {
  display: flex; align-items: center; justify-content: center;
  width: 26px; height: 26px; border-radius: 50%; flex-shrink: 0;
  background: var(--green-deep); color: #fff;
  font-family: var(--font-mono); font-size: .75rem; font-weight: 700;
  margin-top: .1rem;
}
.steps li div { font-size: .9rem; line-height: 1.5; color: var(--ink-2); }
.steps li strong { color: var(--ink); }
.submit-actions { display: flex; flex-wrap: wrap; gap: .75rem; }

/* Schema card */
.schema-card { overflow: hidden; }
.schema-header {
  display: flex; align-items: center; justify-content: space-between;
  padding: .65rem 1rem;
  background: var(--surface-alt); border-bottom: 1px solid var(--border);
}
.schema-filename { font-family: var(--font-mono); font-size: .75rem; color: var(--ink-3); }
.schema-code {
  margin: 0; padding: 1.1rem 1.25rem;
  font-family: var(--font-mono); font-size: .8rem; line-height: 1.75;
  background: var(--ink); color: #e8f5e9;
  overflow-x: auto;
}
.schema-code code { background: none; padding: 0; font-size: inherit; }
.c-key { color: #74c69d; }
.schema-rules {
  display: flex; flex-direction: column; gap: .55rem;
  padding: 1rem 1.25rem; border-top: 1px solid var(--border);
}
.rule { display: flex; align-items: center; gap: .6rem; font-size: .8rem; color: var(--ink-2); }
.rule-dot {
  width: 10px; height: 10px; border-radius: 50%; flex-shrink: 0;
}
.rule-dot.peer      { background: var(--badge-peer); }
.rule-dot.preprint  { background: var(--badge-preprint); }
.rule-dot.report    { background: var(--badge-report); }
.rule-dot.community { background: var(--badge-community); }

@media (max-width: 860px) {
  .submit-grid { grid-template-columns: 1fr; gap: 2rem; }
}
</style>
