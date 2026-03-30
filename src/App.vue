<template>
  <div class="app">
    <TheHeader />
    <HeroSection />

    <!-- ── Leaderboard section ──────────────────────────────────────────── -->
    <section id="leaderboard" class="leaderboard-section">
      <div class="container">
        <div class="section-head">
          <div>
            <div class="section-eyebrow">Results</div>
            <h2>Leaderboard</h2>
            <p class="section-desc">
              All scores reported on held-out test sets. Models are sorted by the primary metric for each benchmark.
            </p>
          </div>
        </div>

        <!-- Benchmark tab selector -->
        <BenchmarkTabs
          v-model="activeBench"
          :benchmarks="benchmarks"
          aria-label="Select benchmark"
          class="bench-tabs-el"
        />

        <!-- Benchmark info card + table -->
        <template v-if="activeBenchMeta">
          <BenchmarkInfo :bench="activeBenchMeta" class="bench-info-el" />
          <LeaderboardTable
            :bench="activeBenchMeta"
            :rows="activeResults"
          />
        </template>
      </div>
    </section>

    <!-- ── Papers & Benchmarks combined section ───────────────────────── -->
    <section id="benchmarks" class="benchmarks-section">
      <div class="container">
        <div class="section-head">
          <div class="section-eyebrow">Papers &amp; Datasets</div>
          <h2>Papers &amp; Benchmarks</h2>
        </div>

        <div class="papers-list">
          <div v-for="pg in paperGroups" :key="pg.id" class="paper-group card">

            <!-- Header row -->
            <div class="pg-header">
              <div class="pg-header-left">
                <span class="pg-num">P{{ pg.num }}</span>
                <div class="pg-title-block">
                  <div class="pg-title">{{ pg.title }}</div>
                  <div class="pg-meta">
                    <span>{{ pg.venue }}</span>
                    <span class="pg-year">{{ pg.year }}</span>
                  </div>
                </div>
              </div>
              <a v-if="pg.url !== '#'" :href="pg.url" target="_blank" rel="noopener" class="pg-doi">DOI ↗</a>
              <span v-else class="pg-doi pg-doi-pending">In progress</span>
            </div>

            <!-- Associated benchmark chips -->
            <div v-if="pg.benchmarks.length" class="pg-benchmarks">
              <button
                v-for="b in pg.benchmarks"
                :key="b.id"
                class="bench-chip"
                :class="{ active: activeBench === b.id }"
                @click="jumpToBench(b.id)"
                :aria-label="`View ${b.label} leaderboard`"
              >
                <span class="bench-chip-label">{{ b.label }}</span>
                <span class="bench-chip-task">{{ b.task }}</span>
                <span class="bench-chip-size">{{ b.size }}</span>
              </button>
            </div>
            <div v-else class="pg-benchmarks pg-no-bench">
              <span class="text-muted">Benchmark in development</span>
            </div>

            <!-- BibTeX (collapsed by default, only for papers with a bibtex) -->
            <div v-if="pg.bibtex" class="pg-bibtex">
              <div class="bibtex-toolbar">
                <button
                  class="toggle-btn"
                  @click="bibtexOpen[pg.id] = !bibtexOpen[pg.id]"
                  :aria-expanded="bibtexOpen[pg.id]"
                >
                  <svg class="chevron" :class="{ open: bibtexOpen[pg.id] }"
                    width="12" height="12" viewBox="0 0 20 20" fill="currentColor">
                    <path fill-rule="evenodd" d="M5.293 7.293a1 1 0 011.414 0L10 10.586l3.293-3.293a1 1 0 111.414 1.414l-4 4a1 1 0 01-1.414 0l-4-4a1 1 0 010-1.414z" clip-rule="evenodd"/>
                  </svg>
                  <span class="bibtex-label">Cite</span>
                </button>
                <button
                  v-if="bibtexOpen[pg.id]"
                  class="copy-btn"
                  :class="{ copied: copiedId === pg.id }"
                  @click="copyBibtex(pg)"
                >
                  <svg v-if="copiedId !== pg.id" width="12" height="12" viewBox="0 0 20 20" fill="currentColor">
                    <path d="M8 3a1 1 0 011-1h2a1 1 0 110 2H9a1 1 0 01-1-1z"/>
                    <path d="M6 3a2 2 0 00-2 2v11a2 2 0 002 2h8a2 2 0 002-2V5a2 2 0 00-2-2 3 3 0 01-3 3H9a3 3 0 01-3-3z"/>
                  </svg>
                  <svg v-else width="12" height="12" viewBox="0 0 20 20" fill="currentColor">
                    <path fill-rule="evenodd" d="M16.707 5.293a1 1 0 010 1.414l-8 8a1 1 0 01-1.414 0l-4-4a1 1 0 011.414-1.414L8 12.586l7.293-7.293a1 1 0 011.414 0z" clip-rule="evenodd"/>
                  </svg>
                  {{ copiedId === pg.id ? 'Copied!' : 'Copy' }}
                </button>
              </div>
              <pre v-show="bibtexOpen[pg.id]" class="bibtex-block"><code>{{ pg.bibtex }}</code></pre>
            </div>

          </div>
        </div>
      </div>
    </section>

    <SubmitInfo />
    <TheFooter />
  </div>
</template>

<script setup>
import { ref, reactive, computed } from 'vue'
import TheHeader from './components/TheHeader.vue'
import HeroSection from './components/HeroSection.vue'
import BenchmarkTabs from './components/BenchmarkTabs.vue'
import BenchmarkInfo from './components/BenchmarkInfo.vue'
import LeaderboardTable from './components/LeaderboardTable.vue'
import SubmitInfo from './components/SubmitInfo.vue'
import TheFooter from './components/TheFooter.vue'

import benchmarksData from './data/benchmarks.json'
import resultsData from './data/results.json'

const benchmarks = benchmarksData
const activeBench = ref(benchmarks[0].id)

const activeBenchMeta = computed(() => benchmarks.find(b => b.id === activeBench.value))
const activeResults   = computed(() => resultsData[activeBench.value] || [])

function jumpToBench(id) {
  activeBench.value = id
  document.getElementById('leaderboard')?.scrollIntoView({ behavior: 'smooth', block: 'start' })
}

// BibTeX collapse state — all closed by default
const bibtexOpen = reactive({ p1: false, p2: false, p3: false })
const copiedId = ref(null)

async function copyBibtex(pg) {
  try {
    await navigator.clipboard.writeText(pg.bibtex)
  } catch {
    const el = document.createElement('textarea')
    el.value = pg.bibtex
    document.body.appendChild(el)
    el.select()
    document.execCommand('copy')
    document.body.removeChild(el)
  }
  copiedId.value = pg.id
  setTimeout(() => { copiedId.value = null }, 2000)
}

const paperGroups = [
  {
    id: 'p1', num: 1,
    title: 'AgXQA: A benchmark for advanced Agricultural Extension question answering',
    venue: 'Computers and Electronics in Agriculture, vol. 225, p. 109349',
    year: 2024,
    url: 'https://doi.org/10.1016/j.compag.2024.109349',
    benchmarks: benchmarks.filter(b => b.paper === 'P1'),
    bibtex: `@article{kpodo2024agxqa,
  title   = {{AgXQA}: A benchmark for advanced {Agricultural Extension} question answering},
  author  = {Kpodo, Josu{\\'{e}} and Kordjamshidi, Parisa and Nejadhashemi, A. Pouyan},
  journal = {Computers and Electronics in Agriculture},
  volume  = {225},
  pages   = {109349},
  year    = {2024},
  issn    = {0168-1699},
  doi     = {10.1016/j.compag.2024.109349}
}`,
  },
  {
    id: 'p2', num: 2,
    title: 'Evaluating the logical and mathematical reasoning capabilities of language models in agricultural water management',
    venue: 'Computers and Electronics in Agriculture, vol. 245, p. 111533',
    year: 2026,
    url: 'https://doi.org/10.1016/j.compag.2026.111533',
    benchmarks: benchmarks.filter(b => b.paper === 'P2'),
    bibtex: `@article{kpodo2026dew,
  title   = {Evaluating the logical and mathematical reasoning capabilities of language models in agricultural water management},
  author  = {Kpodo, Josu{\\'{e}} and Nejadhashemi, A. Pouyan and Eeswaran, Rasu},
  journal = {Computers and Electronics in Agriculture},
  volume  = {245},
  pages   = {111533},
  year    = {2026},
  issn    = {0168-1699},
  doi     = {10.1016/j.compag.2026.111533}
}`,
  },
  {
    id: 'p3', num: 3,
    title: 'Closing the gap between crop simulation and practical decision-making',
    venue: 'Computers and Electronics in Agriculture, vol. 247, p. 111655',
    year: 2026,
    url: 'https://doi.org/10.1016/j.compag.2026.111655',
    benchmarks: benchmarks.filter(b => b.paper === 'P3'),
    bibtex: `@article{kpodo2026farmpro,
  title   = {Closing the gap between crop simulation and practical decision-making},
  author  = {Kpodo, Josu{\\'{e}} and Nejadhashemi, A. Pouyan and Kordjamshidi, Parisa and Eeswaran, Rasu and Dong, Younsuk},
  journal = {Computers and Electronics in Agriculture},
  volume  = {247},
  pages   = {111655},
  year    = {2026},
  issn    = {0168-1699},
  doi     = {10.1016/j.compag.2026.111655}
}`,
  },

]
</script>

<style scoped>
.app { min-height: 100vh; display: flex; flex-direction: column; }

/* ── Shared section chrome ────────────────────────────────────────────── */
.section-eyebrow {
  font-size: .76rem; font-weight: 600; text-transform: uppercase;
  letter-spacing: .08em; color: var(--green-vivid); margin-bottom: .4rem;
}
.section-head { margin-bottom: 1.75rem; }
.section-head h2 { margin-bottom: .4rem; }
.section-desc { color: var(--ink-3); max-width: 520px; font-size: .9rem; }

/* ── Leaderboard section ─────────────────────────────────────────────── */
.leaderboard-section { padding: 4rem 0; flex: 1; }
.bench-tabs-el { margin-bottom: 1.5rem; }
.bench-info-el { margin-bottom: 1.25rem; }

/* ── Papers & Benchmarks combined section ────────────────────────────── */
.benchmarks-section {
  padding: 4rem 0;
  background: var(--surface-alt);
  border-top: 1px solid var(--border);
}
.papers-list { display: flex; flex-direction: column; gap: 1rem; }

.paper-group { overflow: hidden; border: 1px solid var(--border); }

.pg-header {
  display: flex; align-items: flex-start; justify-content: space-between;
  gap: 1rem; padding: 1.1rem 1.25rem;
  border-bottom: 1px solid var(--border-light);
}
.pg-header-left { display: flex; align-items: flex-start; gap: .85rem; flex: 1; min-width: 0; }
.pg-num {
  font-family: var(--font-mono); font-size: .72rem; font-weight: 700;
  color: var(--green-vivid); letter-spacing: .06em;
  background: var(--green-tint); border: 1px solid var(--green-pale);
  padding: .2rem .5rem; border-radius: var(--radius-sm);
  flex-shrink: 0; margin-top: .1rem;
}
.pg-title-block { min-width: 0; }
.pg-title { font-size: .9rem; font-weight: 600; color: var(--ink); line-height: 1.45; margin-bottom: .2rem; }
.pg-meta { display: flex; gap: .75rem; font-size: .75rem; color: var(--ink-3); flex-wrap: wrap; }
.pg-year { font-family: var(--font-mono); }
.pg-doi {
  font-size: .78rem; font-weight: 600; color: var(--green-mid);
  white-space: nowrap; flex-shrink: 0; padding-top: .1rem; text-decoration: none;
}
.pg-doi:hover { color: var(--green-deep); text-decoration: underline; }
.pg-doi-pending { color: var(--ink-4); font-weight: 400; font-style: italic; }

.pg-benchmarks {
  display: flex; flex-wrap: wrap; gap: .65rem;
  padding: .9rem 1.25rem; background: var(--surface);
}
.pg-no-bench { align-items: center; }

.bench-chip {
  display: flex; flex-direction: column; gap: .15rem;
  padding: .6rem .9rem;
  background: var(--surface-alt); border: 1.5px solid var(--border);
  border-radius: var(--radius); cursor: pointer; text-align: left;
  transition: border-color var(--transition), background var(--transition), box-shadow var(--transition);
  font-family: var(--font-body);
}
.bench-chip:hover { border-color: var(--green-vivid); background: var(--green-tint); box-shadow: var(--shadow-sm); }
.bench-chip.active { border-color: var(--green-vivid); border-left-width: 3px; background: var(--green-pale); }
.bench-chip-label { font-family: var(--font-mono); font-size: .8rem; font-weight: 700; color: var(--green-deep); }
.bench-chip-task { font-size: .76rem; color: var(--ink-2); font-weight: 500; }
.bench-chip-size { font-size: .72rem; color: var(--ink-4); }

/* BibTeX */
.pg-bibtex { border-top: 1px solid var(--border-light); }
.bibtex-toolbar {
  display: flex; align-items: center; justify-content: space-between;
  padding: .45rem 1.25rem; background: var(--surface-alt);
}
.toggle-btn {
  display: inline-flex; align-items: center; gap: .35rem;
  background: none; border: none; cursor: pointer; padding: .15rem 0;
}
.toggle-btn:hover .bibtex-label { color: var(--green-deep); }
.chevron {
  color: var(--ink-4); transition: transform .2s ease; flex-shrink: 0;
}
.chevron.open { transform: rotate(180deg); }
.bibtex-label {
  font-family: var(--font-mono); font-size: .7rem; font-weight: 600;
  color: var(--ink-4); letter-spacing: .06em; text-transform: uppercase;
}
.copy-btn {
  display: inline-flex; align-items: center; gap: .3rem;
  padding: .25rem .65rem; font-family: var(--font-body); font-size: .76rem; font-weight: 500;
  border: 1.5px solid var(--border); border-radius: var(--radius);
  background: var(--surface); color: var(--ink-2); cursor: pointer; transition: var(--transition);
}
.copy-btn:hover { border-color: var(--green-vivid); color: var(--green-deep); background: var(--green-tint); }
.copy-btn.copied { border-color: var(--green-vivid); color: var(--green-vivid); background: var(--green-tint); }
.bibtex-block {
  margin: 0; padding: .9rem 1.25rem;
  font-family: var(--font-mono); font-size: .78rem; line-height: 1.75;
  color: var(--ink-2); overflow-x: auto; background: var(--surface);
}
.bibtex-block code { background: none; padding: 0; font-size: inherit; color: inherit; }

@media (max-width: 600px) {
  .pg-header { flex-direction: column; gap: .5rem; }
  .pg-doi { align-self: flex-start; }
}
</style>
