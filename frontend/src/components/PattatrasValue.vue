<script setup>
defineProps({
  row: { type: Object, required: true },
})
</script>

<template>
  <span class="pattatras-value" :class="row.type">
    {{ row.value }}
    <small v-if="row.type !== 'nombre'">{{ row.number }}</small>
  </span>
</template>
