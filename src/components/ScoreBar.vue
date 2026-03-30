<template>
  <div v-if="value != null" class="score-bar-wrap">
    <div class="score-bar-track">
      <div class="score-bar-fill" :style="{ width: `${pct}%` }" />
    </div>
    <span class="score-val">{{ formatted }}</span>
  </div>
  <span v-else class="score-na">—</span>
</template>

<script setup>
import { computed } from 'vue'
const props = defineProps({
  value: { type: Number, default: null },
  max:   { type: Number, default: 100 },
  type:  { type: String, default: 'percent' }, // 'percent' | 'decimal'
})

const pct = computed(() => {
  if (props.value == null || props.max == null || props.max === 0) return 0
  return Math.min(100, (props.value / props.max) * 100)
})
const formatted = computed(() => {
  if (props.value == null) return '—'
  return props.type === 'decimal'
    ? props.value.toFixed(2)
    : props.value.toFixed(1) + '%'
})
</script>

<style scoped>
.score-bar-wrap { display: flex; align-items: center; gap: .55rem; }
.score-bar-track {
  flex: 1; height: 7px; min-width: 60px;
  background: var(--green-pale);
  border-radius: 99px; overflow: hidden;
}
.score-bar-fill {
  height: 100%; border-radius: 99px;
  background: linear-gradient(90deg, var(--green-vivid), var(--green-mid));
  transition: width .65s cubic-bezier(.4,0,.2,1);
}
.score-val {
  font-family: var(--font-mono); font-size: .82rem; font-weight: 700;
  color: var(--green-deep); min-width: 46px; text-align: right;
}
.score-na { color: var(--ink-4); font-size: .82rem; }
</style>
