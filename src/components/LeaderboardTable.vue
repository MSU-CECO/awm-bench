<template>
  <div class="lb-wrapper">
    <!-- Toolbar -->
    <div class="lb-toolbar">
      <div class="lb-toolbar-left">
        <!-- Column visibility for extra metrics -->
        <div class="metric-toggles" v-if="extraMetrics.length">
          <span class="toggle-label">Show:</span>
          <label v-for="m in extraMetrics" :key="m.key" class="metric-toggle">
            <input type="checkbox" :value="m.key" v-model="visibleExtras" />
            <span>{{ m.label }}</span>
          </label>
        </div>
      </div>
      <div class="lb-toolbar-right">
        <span class="text-muted result-count">{{ rows.length }} model{{ rows.length !== 1 ? 's' : '' }}</span>
        <button class="btn btn-ghost btn-sm" @click="downloadCSV" title="Download as CSV">
          <svg width="13" height="13" viewBox="0 0 20 20" fill="currentColor"><path d="M3 17a1 1 0 011-1h12a1 1 0 110 2H4a1 1 0 01-1-1zm3.293-7.707a1 1 0 011.414 0L9 10.586V3a1 1 0 112 0v7.586l1.293-1.293a1 1 0 111.414 1.414l-3 3a1 1 0 01-1.414 0l-3-3a1 1 0 010-1.414z"/></svg>
          CSV
        </button>
      </div>
    </div>

    <!-- Table scroll wrapper -->
    <div class="table-scroll" role="region" :aria-label="`${bench.label} leaderboard`">
      <table class="lb-table" :id="`panel-${bench.id}`" role="tabpanel" :aria-labelledby="`tab-${bench.id}`">
        <thead>
          <tr>
            <th class="col-rank th-fixed" scope="col">#</th>
            <th class="col-model" scope="col">Model</th>
            <th class="col-cred hide-mobile" scope="col">Source</th>
            <!-- Primary metric always shown with bar -->
            <th
              v-for="m in primaryMetric"
              :key="m.key"
              class="col-score col-primary"
              scope="col"
              :class="{ sortable: true, sorted: sortKey === m.key }"
              @click="setSort(m.key)"
            >
              <span class="th-inner">
                {{ m.label }}
                <svg class="sort-icon" :class="{ asc: sortDir === 'asc', active: sortKey === m.key }" width="12" height="12" viewBox="0 0 20 20" fill="currentColor"><path d="M5 12l5-5 5 5H5z"/></svg>
              </span>
            </th>
            <!-- Extra metrics -->
            <th
              v-for="m in shownExtras"
              :key="m.key"
              class="col-score col-extra"
              scope="col"
              :class="{ sortable: true, sorted: sortKey === m.key }"
              @click="setSort(m.key)"
            >
              <span class="th-inner">
                {{ m.label }}
                <svg class="sort-icon" :class="{ asc: sortDir === 'asc', active: sortKey === m.key }" width="12" height="12" viewBox="0 0 20 20" fill="currentColor"><path d="M5 12l5-5 5 5H5z"/></svg>
              </span>
            </th>
            <th class="col-date hide-mobile" scope="col">Year</th>
            <th class="col-notes hide-mobile" scope="col">Notes</th>
          </tr>
        </thead>
        <tbody>
          <tr
            v-for="(row, idx) in sortedRows"
            :key="row.model"
            class="lb-row"
            :class="{ 'row-top3': row.rank <= 3 }"
          >
            <!-- Rank -->
            <td class="col-rank">
              <span :class="['rank-chip', rankClass(row.rank)]">{{ row.rank }}</span>
            </td>

            <!-- Model name + badges -->
            <td class="col-model">
              <div class="model-cell">
                <a v-if="row.model_url && row.model_url !== '#'"
                   :href="row.model_url" target="_blank" rel="noopener"
                   class="model-name" :title="row.model">
                  {{ row.model }}
                </a>
                <span v-else class="model-name model-name-plain">{{ row.model }}</span>
                <div class="model-badges">
                  <span v-if="row.verified" class="badge badge-verified" title="Results personally verified by benchmark author">
                    <svg width="8" height="8" viewBox="0 0 12 12" fill="currentColor"><path d="M10.28 2.28L4.5 8.06 1.72 5.28a1 1 0 00-1.44 1.44l3.5 3.5a1 1 0 001.44 0l6.5-6.5a1 1 0 00-1.44-1.44z"/></svg>
                    Verified
                  </span>
                </div>
              </div>
            </td>

            <!-- Credibility -->
            <td class="col-cred hide-mobile">
              <span :class="`badge badge-${row.credibility}`">{{ credLabel(row.credibility) }}</span>
            </td>

            <!-- Primary metric (with bar) -->
            <td v-for="m in primaryMetric" :key="m.key" class="col-score col-primary">
              <ScoreBar
                :value="row.metrics[m.key]"
                :max="maxForMetric(m)"
                :type="m.type"
              />
            </td>

            <!-- Extra metric columns -->
            <td v-for="m in shownExtras" :key="m.key" class="col-score col-extra">
              <ScoreCell :value="row.metrics[m.key]" :type="m.type" />
            </td>

            <!-- Date -->
            <td class="col-date hide-mobile text-muted">{{ row.date }}</td>

            <!-- Notes -->
            <td class="col-notes hide-mobile">
              <span v-if="row.notes" class="notes-text" :title="row.notes">
                {{ truncate(row.notes, 80) }}
              </span>
            </td>
          </tr>
        </tbody>
      </table>
    </div>

    <!-- Legend -->
    <div class="lb-legend">
      <div class="legend-badges">
        <span class="badge badge-peer">Peer-Reviewed</span>
        <span class="badge badge-preprint">Preprint</span>
        <span class="badge badge-report">Technical Report</span>
        <span class="badge badge-community">Community</span>
        <span class="badge badge-verified">
          <svg width="9" height="9" viewBox="0 0 12 12" fill="currentColor"><path d="M10.28 2.28L4.5 8.06 1.72 5.28a1 1 0 00-1.44 1.44l3.5 3.5a1 1 0 001.44 0l6.5-6.5a1 1 0 00-1.44-1.44z"/></svg>
          Verified
        </span>
        <span class="legend-note">= author-checked results</span>
      </div>
      <p class="legend-caption">
        Model names link to source papers or project pages.
        Click any column header to sort. <a href="#submit">Submit new results via Merge Request.</a>
      </p>
    </div>
  </div>
</template>

<script setup>
import { ref, computed } from 'vue'
import ScoreBar from './ScoreBar.vue'
import ScoreCell from './ScoreCell.vue'

const props = defineProps({
  bench: { type: Object, required: true },
  rows:  { type: Array,  required: true },
})

// ── Column management ────────────────────────────────────────────────────
const primaryMetric = computed(() =>
  props.bench.metrics.filter(m => m.key === props.bench.primary_metric)
)
const extraMetrics = computed(() =>
  props.bench.metrics.filter(m => m.key !== props.bench.primary_metric)
)
const visibleExtras = ref(
  props.bench.metrics
    .filter(m => m.key !== props.bench.primary_metric)
    .slice(0, 3)
    .map(m => m.key)
)
const shownExtras = computed(() =>
  extraMetrics.value.filter(m => visibleExtras.value.includes(m.key))
)

// ── Sorting ──────────────────────────────────────────────────────────────
const sortKey = ref(props.bench.primary_metric)
const sortDir = ref('desc')

function setSort(key) {
  if (sortKey.value === key) {
    sortDir.value = sortDir.value === 'desc' ? 'asc' : 'desc'
  } else {
    sortKey.value = key
    sortDir.value = 'desc'
  }
}

const sortedRows = computed(() => {
  const sorted = [...props.rows].sort((a, b) => {
    const va = a.metrics[sortKey.value] ?? -Infinity
    const vb = b.metrics[sortKey.value] ?? -Infinity
    return sortDir.value === 'desc' ? vb - va : va - vb
  })
  return sorted.map((r, i) => ({ ...r, rank: i + 1 }))
})

// ── Helpers ───────────────────────────────────────────────────────────────
function maxForMetric(m) {
  const vals = props.rows.map(r => r.metrics[m.key]).filter(v => v != null)
  return Math.max(...vals)
}
function rankClass(r) {
  return r === 1 ? 'rank-1' : r === 2 ? 'rank-2' : r === 3 ? 'rank-3' : 'rank-n'
}
function credLabel(c) {
  return { 'peer-reviewed':'Peer-Reviewed', peer:'Peer-Reviewed', preprint:'Preprint', report:'Technical Report', community:'Community' }[c] || c
}
function truncate(str, n) {
  return str && str.length > n ? str.slice(0, n) + '…' : str
}

// ── CSV export ─────────────────────────────────────────────────────────────
function downloadCSV() {
  const allMetrics = props.bench.metrics.map(m => m.key)
  const headers = ['rank','model','credibility','verified','date', ...allMetrics,'notes']
  const rows = sortedRows.value.map(r => [
    r.rank, `"${r.model}"`, r.credibility, r.verified ? 'yes' : 'no', r.date,
    ...allMetrics.map(k => r.metrics[k] ?? ''),
    `"${(r.notes||'').replace(/"/g,'""')}"`,
  ])
  const csv = [headers, ...rows].map(r => r.join(',')).join('\n')
  const a = document.createElement('a')
  a.href = URL.createObjectURL(new Blob([csv], { type: 'text/csv' }))
  a.download = `awm-bench-${props.bench.id}.csv`
  a.click()
}
</script>

<style scoped>
.lb-wrapper { display: flex; flex-direction: column; gap: .75rem; }

/* Toolbar */
.lb-toolbar {
  display: flex; align-items: center; justify-content: space-between;
  flex-wrap: wrap; gap: .5rem;
}
.lb-toolbar-left { display: flex; align-items: center; flex-wrap: wrap; gap: .5rem; }
.lb-toolbar-right { display: flex; align-items: center; gap: .5rem; margin-left: auto; }
.metric-toggles { display: flex; align-items: center; flex-wrap: wrap; gap: .4rem; }
.toggle-label { font-size: .78rem; color: var(--ink-3); font-weight: 500; }
.metric-toggle {
  display: inline-flex; align-items: center; gap: .3rem;
  padding: .25rem .6rem;
  border: 1px solid var(--border);
  border-radius: 999px;
  font-size: .76rem; cursor: pointer; background: var(--surface);
  transition: var(--transition); user-select: none;
}
.metric-toggle:has(input:checked) {
  background: var(--green-pale); border-color: var(--green-vivid); color: var(--green-deep);
}
.metric-toggle input { width: 0; height: 0; position: absolute; opacity: 0; }
.result-count { font-size: .8rem; }
.btn-sm { padding: .35rem .75rem; font-size: .78rem; }

/* Table */
.table-scroll { overflow-x: auto; border-radius: var(--radius-lg); border: 1px solid var(--border); }
.lb-table { width: 100%; border-collapse: collapse; font-size: .875rem; background: var(--surface); }
.lb-table thead { background: var(--surface-alt); border-bottom: 2px solid var(--border); }
.lb-table th {
  padding: .75rem 1rem;
  font-family: var(--font-body); font-size: .76rem; font-weight: 600;
  text-transform: uppercase; letter-spacing: .05em;
  color: var(--ink-3); text-align: left; white-space: nowrap;
}
.lb-table th.sortable { cursor: pointer; }
.lb-table th.sortable:hover { color: var(--green-deep); }
.lb-table th.sorted { color: var(--green-deep); }
.th-inner { display: inline-flex; align-items: center; gap: .3rem; }
.sort-icon { opacity: .3; transition: opacity .15s, transform .2s; }
.sort-icon.active { opacity: .9; }
.sort-icon.active.asc { transform: rotate(180deg); }
.lb-table td { padding: .8rem 1rem; border-bottom: 1px solid var(--border-light); vertical-align: middle; }
.lb-table tbody tr:last-child td { border-bottom: none; }
.lb-row { transition: background var(--transition); }
.lb-row:hover { background: var(--green-tint); }
.row-top3 td:first-child { border-left: 2px solid var(--green-vivid); }

/* Columns */
.col-rank { width: 52px; text-align: center; }
.col-model { min-width: 220px; }
.col-cred { width: 130px; }
.col-score { width: 160px; }
.col-primary { width: 190px; }
.col-extra { width: 130px; }
.col-date { width: 60px; text-align: center; font-family: var(--font-mono); font-size: .8rem; }
.col-notes { max-width: 250px; }

/* Model cell */
.model-cell { display: flex; flex-direction: column; gap: .2rem; }
.model-name {
  font-weight: 600; color: var(--green-deep);
  font-size: .875rem; line-height: 1.35;
  word-break: break-word;
}
.model-name-plain { color: var(--ink); }
.model-name:hover { text-decoration: underline; }
.model-badges { display: flex; flex-wrap: wrap; gap: .3rem; }
.notes-text { font-size: .775rem; color: var(--ink-3); line-height: 1.4; }

/* Legend */
.lb-legend { padding: .9rem 0 .2rem; }
.legend-badges { display: flex; align-items: center; flex-wrap: wrap; gap: .4rem; margin-bottom: .4rem; }
.legend-note { font-size: .76rem; color: var(--ink-3); }
.legend-caption { font-size: .78rem; color: var(--ink-3); line-height: 1.5; }
</style>
