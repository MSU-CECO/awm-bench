<template>
  <div class="bench-tabs" role="tablist" :aria-label="ariaLabel">
    <button
      v-for="bench in benchmarks"
      :key="bench.id"
      role="tab"
      :id="`tab-${bench.id}`"
      :aria-selected="modelValue === bench.id"
      :aria-controls="`panel-${bench.id}`"
      :class="['tab-btn', { active: modelValue === bench.id }]"
      @click="$emit('update:modelValue', bench.id)"
    >
      <span class="tab-paper-num">P{{ bench.paper.replace('P','') }}</span>
      <span class="tab-label">{{ bench.label }}</span>
      <span class="tab-task hide-small">{{ bench.task }}</span>
    </button>
  </div>
</template>

<script setup>
defineProps({
  benchmarks: { type: Array, required: true },
  modelValue:  { type: String, required: true },
  ariaLabel:   { type: String, default: 'Benchmark tabs' },
})
defineEmits(['update:modelValue'])
</script>

<style scoped>
.bench-tabs {
  display: flex; flex-wrap: wrap; gap: .4rem;
  padding: .5rem;
  background: var(--surface-alt);
  border: 1px solid var(--border);
  border-radius: var(--radius-lg);
}
.tab-btn {
  display: flex; align-items: center; gap: .45rem;
  padding: .55rem 1rem;
  background: transparent;
  border: 1.5px solid transparent;
  border-radius: var(--radius);
  cursor: pointer;
  font-family: var(--font-body);
  font-size: .875rem;
  color: var(--ink-3);
  font-weight: 500;
  transition: var(--transition);
  white-space: nowrap;
}
.tab-btn:hover { background: var(--green-pale); color: var(--green-deep); }
.tab-btn.active {
  background: var(--surface);
  border-color: var(--green-vivid);
  color: var(--green-deep);
  font-weight: 600;
  box-shadow: var(--shadow-sm);
}
.tab-paper-num {
  font-family: var(--font-mono);
  font-size: .68rem; font-weight: 700;
  color: var(--green-vivid);
  background: var(--green-tint);
  padding: .05rem .35rem;
  border-radius: var(--radius-sm);
}
.tab-btn.active .tab-paper-num { background: var(--green-pale); }
.tab-label { font-weight: inherit; }
.tab-task {
  font-size: .72rem; color: var(--ink-4);
  font-weight: 400;
  padding-left: .2rem;
  border-left: 1px solid var(--border);
  margin-left: .1rem;
  padding-left: .4rem;
}
.tab-btn.active .tab-task { color: var(--ink-3); }

@media (max-width: 700px) {
  .tab-btn { padding: .45rem .7rem; font-size: .8rem; }
}
</style>
