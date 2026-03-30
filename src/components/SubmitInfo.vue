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
            <strong>GitLab Merge Requests</strong>! We will review each submission accordingly before merging.
          </p>
          <ol class="steps">
            <li>
              <span class="step-num">1</span>
              <div>
                <strong>Fork the repository</strong>
                <span> on GitLab and clone it locally.</span>
              </div>
            </li>
            <li>
              <span class="step-num">2</span>
              <div>
                <strong>Edit <code>src/data/results.json</code></strong>
                <span> to add your model entry following the schema example shown.</span>
              </div>
            </li>
            <li>
              <span class="step-num">3</span>
              <div>
                <strong>Open a Merge Request</strong>
                <span> with a title like <code>[AgXQA] GPT-4o (ZSL results)</code>.</span>
              </div>
            </li>
            <li>
              <span class="step-num">4</span>
              <div>
                <strong>Link your evidence</strong>
                <span> i.e., paper DOI, arXiv URL, or public evaluation code.</span>
              </div>
            </li>
          </ol>
          <div class="submit-actions">
            <a href="https://gitlab.com/msu-ceco/awm-bench" target="_blank" rel="noopener" class="btn btn-primary">
              <svg width="14" height="14" viewBox="0 0 24 24" fill="currentColor">
                <path d="M22.65 14.39L12 22.13 1.35 14.39a.84.84 0 0 1-.3-.94l1.22-3.78 2.44-7.51A.42.42 0 0 1 4.82 2a.43.43 0 0 1 .58 0 .42.42 0 0 1 .11.18l2.44 7.49h8.1l2.44-7.51A.42.42 0 0 1 18.6 2a.43.43 0 0 1 .58 0 .42.42 0 0 1 .11.18l2.44 7.51L23 13.45a.84.84 0 0 1-.35.94z"/>
              </svg>
              Open on GitLab
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
