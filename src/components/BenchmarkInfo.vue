<template>
  <div class="bench-info card card-padded fade-in-up">
    <div class="bi-top">
      <div class="bi-title-row">
        <span class="bi-label">{{ bench.label }}</span>
        <span :class="`badge badge-${bench.credibility}`">{{ credLabel }}</span>
        <span v-if="bench.credibility === 'peer'" class="badge badge-verified">
          <svg width="10" height="10" viewBox="0 0 12 12" fill="currentColor"><path d="M10.28 2.28L4.5 8.06 1.72 5.28a1 1 0 00-1.44 1.44l3.5 3.5a1 1 0 001.44 0l6.5-6.5a1 1 0 00-1.44-1.44z"/></svg>
          Results Verified
        </span>
      </div>
      <h2 class="bi-fullname">{{ bench.full_name }}</h2>
    </div>

    <div class="bi-body">
      <p class="bi-desc">{{ bench.description }}</p>

      <div class="bi-pills">
        <span class="pill">
          <svg width="12" height="12" viewBox="0 0 20 20" fill="currentColor"><path d="M9 4.804A7.968 7.968 0 005.5 4c-1.255 0-2.443.29-3.5.804v10A7.969 7.969 0 015.5 14c1.396 0 2.7.402 3.8 1.093A7.95 7.95 0 0114.5 14c1.255 0 2.443.29 3.5.804v-10A7.968 7.968 0 0014.5 4c-1.255 0-2.443.29-3.5.804V12a1 1 0 11-2 0V4.804z"/></svg>
          Task: {{ bench.task }}
        </span>
        <span class="pill">
          <svg width="12" height="12" viewBox="0 0 20 20" fill="currentColor"><path d="M7 3a1 1 0 000 2h6a1 1 0 100-2H7zM4 7a1 1 0 011-1h10a1 1 0 110 2H5a1 1 0 01-1-1zM2 11a2 2 0 012-2h12a2 2 0 012 2v4a2 2 0 01-2 2H4a2 2 0 01-2-2v-4z"/></svg>
          {{ bench.size }}
        </span>
        <span class="pill">
          <svg width="12" height="12" viewBox="0 0 20 20" fill="currentColor"><path d="M2 11a1 1 0 011-1h2a1 1 0 011 1v5a1 1 0 01-1 1H3a1 1 0 01-1-1v-5zm6-4a1 1 0 011-1h2a1 1 0 011 1v9a1 1 0 01-1 1H9a1 1 0 01-1-1V7zm6-3a1 1 0 011-1h2a1 1 0 011 1v12a1 1 0 01-1 1h-2a1 1 0 01-1-1V4z"/></svg>
          Primary metric: <strong>{{ bench.primary_metric }}</strong>
        </span>
        <span class="pill">
          <svg width="12" height="12" viewBox="0 0 20 20" fill="currentColor"><path d="M10 9a3 3 0 100-6 3 3 0 000 6zm-7 9a7 7 0 1114 0H3z"/></svg>
          {{ bench.split }}
        </span>
      </div>
    </div>

    <div class="bi-links">
      <a :href="bench.paper_url" target="_blank" rel="noopener" class="btn btn-outline btn-sm">
        <svg width="13" height="13" viewBox="0 0 20 20" fill="currentColor"><path d="M9 4.804A7.968 7.968 0 005.5 4c-1.255 0-2.443.29-3.5.804v10A7.969 7.969 0 015.5 14c1.396 0 2.7.402 3.8 1.093A7.95 7.95 0 0114.5 14c1.255 0 2.443.29 3.5.804v-10A7.968 7.968 0 0014.5 4c-1.255 0-2.443.29-3.5.804V12a1 1 0 11-2 0V4.804z"/></svg>
        Paper
      </a>
      <a v-if="bench.hf_dataset" :href="bench.hf_dataset" target="_blank" rel="noopener" class="btn btn-ghost btn-sm">
        🤗 Dataset
      </a>
      <a href="#submit" class="btn btn-ghost btn-sm">
        + Submit Results
      </a>
      <span class="bi-venue text-muted hide-mobile">
        {{ bench.venue }} · {{ bench.year }}
      </span>
    </div>
  </div>
</template>

<script setup>
import { computed } from 'vue'
const props = defineProps({ bench: { type: Object, required: true } })
const credLabel = computed(() => ({
  'peer-reviewed': 'Peer-Reviewed',
  'peer': 'Peer-Reviewed',
  preprint: 'Preprint',
  report: 'Technical Report',
  community: 'Community',
}[props.bench.credibility] || props.bench.credibility))
</script>

<style scoped>
.bench-info { border-left: 3px solid var(--green-vivid); }
.bi-top { margin-bottom: .85rem; }
.bi-title-row { display: flex; align-items: center; flex-wrap: wrap; gap: .45rem; margin-bottom: .45rem; }
.bi-label {
  font-family: var(--font-mono); font-size: .78rem; font-weight: 700;
  color: var(--green-vivid); letter-spacing: .06em;
}
.bi-fullname { font-size: 1.2rem; margin: 0; }
.bi-body { margin-bottom: 1.1rem; }
.bi-desc { color: var(--ink-2); line-height: 1.65; margin-bottom: .85rem; font-size: .9rem; }
.bi-pills { display: flex; flex-wrap: wrap; gap: .45rem; }
.pill {
  display: inline-flex; align-items: center; gap: .35rem;
  padding: .3rem .7rem;
  background: var(--surface-alt); border: 1px solid var(--border);
  border-radius: 999px; font-size: .78rem; color: var(--ink-2);
}
.pill strong { color: var(--green-deep); }
.bi-links { display: flex; align-items: center; flex-wrap: wrap; gap: .55rem; }
.bi-venue { margin-left: auto; font-size: .78rem; }
.btn-sm { padding: .38rem .85rem; font-size: .8rem; }
</style>
