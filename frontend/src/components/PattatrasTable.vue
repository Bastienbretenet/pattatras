<script setup>
import { onMounted, ref } from 'vue'
import PattatrasValue from './PattatrasValue.vue'

const rows = ref([])
const loading = ref(true)
const error = ref('')

onMounted(async () => {
  try {
    const response = await fetch('/api/pattatras')
    if (!response.ok) throw new Error(`HTTP ${response.status}`)
    rows.value = await response.json()
  } catch (e) {
    error.value = `Impossible de charger les données (${e.message}).`
  } finally {
    loading.value = false
  }
})
</script>

<template>
  <p v-if="loading">Chargement…</p>
  <p v-else-if="error" class="error" role="alert">{{ error }}</p>

  <ol v-else class="grid">
    <li v-for="row in rows" :key="row.number">
      <PattatrasValue :row="row" />
    </li>
  </ol>
</template>
