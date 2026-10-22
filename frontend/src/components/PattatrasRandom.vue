<script setup>
import { ref } from 'vue'
import { MAX, MIN } from '../pattatras.js'
import PattatrasValue from './PattatrasValue.vue'

const result = ref(null)
const loading = ref(false)
const error = ref('')

const randomNumber = () => Math.floor(Math.random() * (MAX - MIN + 1)) + MIN

async function roll() {
  loading.value = true
  error.value = ''

  try {
    const response = await fetch(`/api/pattatras/${randomNumber()}`)
    if (!response.ok) throw new Error(`HTTP ${response.status}`)
    result.value = await response.json()
  } catch (e) {
    error.value = `Impossible de convertir le nombre (${e.message}).`
  } finally {
    loading.value = false
  }
}
</script>

<template>
  <div class="random">
    <button type="button" class="roll" :disabled="loading" @click="roll">Lancer un nombre</button>

    <p v-if="error" class="error" role="alert">{{ error }}</p>

    <div v-else-if="result" class="result" aria-live="polite">
      <PattatrasValue :row="result" />
    </div>
  </div>
</template>
