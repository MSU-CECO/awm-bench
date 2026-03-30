<template>
  <span v-if="value != null" class="score-cell">{{ formatted }}</span>
  <span v-else class="score-na">—</span>
</template>

<script setup>
import { computed } from 'vue'
const props = defineProps({
  value: { type: Number, default: null },
  type:  { type: String, default: 'percent' },
})
const formatted = computed(() => {
  if (props.value == null) return '—'
  return props.type === 'decimal'
    ? props.value.toFixed(2)
    : props.value.toFixed(1) + '%'
})
</script>

<style scoped>
.score-cell {
  font-family: var(--font-mono); font-size: .82rem; font-weight: 500;
  color: var(--ink-2);
}
.score-na { color: var(--ink-4); font-size: .82rem; }
</style>
