<template>
  <section class="hero">
    <div class="container hero-inner">
      <div class="hero-copy fade-in-up">
        <h1>Benchmarking AI in<br><em class="green-em">Agricultural Water Management</em></h1>
        <p class="hero-desc">
          AWM-Bench currenty tracks AI model performance on five domain-specific benchmarks covering
          extractive QA, logical &amp; mathematical reasoning, semantic parsing, and
          simulation-grounded question answering in agricultural water management.
        </p>
        <div class="hero-actions">
          <a href="#leaderboard" class="btn btn-primary">
            <svg width="15" height="15" viewBox="0 0 20 20" fill="currentColor"><path d="M3 3a1 1 0 000 2h11.586l-3.293 3.293a1 1 0 101.414 1.414l5-5a1 1 0 000-1.414l-5-5a1 1 0 10-1.414 1.414L14.586 3H3z"/></svg>
            View Leaderboard
          </a>
          <a href="#benchmarks" class="btn btn-outline">Papers &amp; Benchmarks</a>
        </div>

        <!-- Stats row -->
        <div class="hero-stats">
          <div class="stat">
            <span class="stat-num">5</span>
            <span class="stat-label">Benchmarks</span>
          </div>
          <div class="stat-sep" aria-hidden="true"/>
          <div class="stat">
            <span class="stat-num">2,186+</span>
            <span class="stat-label">AgXQA QA Pairs</span>
          </div>
          <div class="stat-sep" aria-hidden="true"/>
          <div class="stat">
            <span class="stat-num">419</span>
            <span class="stat-label">DEW Questions</span>
          </div>
          <div class="stat-sep" aria-hidden="true"/>
          <div class="stat">
            <span class="stat-num">2,400</span>
            <span class="stat-label">FarmPro Samples</span>
          </div>
        </div>
      </div>
    </div>
  </section>
</template>

<script setup>
// no data needed since hero is purely presentational
</script>

<style scoped>
.hero {
  padding: 4rem 0 3rem;
  background: linear-gradient(160deg, var(--green-tint) 0%, var(--bg) 55%);
  border-bottom: 1px solid var(--border-light);
}
.hero-inner { max-width: 680px; }
h1 { margin-bottom: 1rem; }
.green-em { color: var(--green-vivid); font-style: italic; }
.hero-desc { margin-bottom: 1.75rem; line-height: 1.7; }
.hero-actions { display: flex; flex-wrap: wrap; gap: .75rem; margin-bottom: 2rem; }
.hero-stats {
  display: flex; flex-wrap: wrap; align-items: center; gap: .5rem;
  padding: 1rem 1.25rem;
  background: var(--surface); border: 1px solid var(--border);
  border-radius: var(--radius-lg);
  box-shadow: var(--shadow-sm);
  max-width: fit-content;
}
.stat { display: flex; flex-direction: column; align-items: center; min-width: 70px; }
.stat-num {
  font-family: var(--font-mono); font-size: 1.2rem; font-weight: 700;
  color: var(--green-deep);
}
.stat-label { font-size: .7rem; color: var(--ink-3); text-transform: uppercase; letter-spacing: .04em; text-align: center; }
.stat-sep { width: 1px; height: 32px; background: var(--border); flex-shrink: 0; }

@media (max-width: 560px) {
  .hero { padding: 2.5rem 0 2rem; }
}
</style>
