<script setup>
import { ref } from 'vue'
import PattatrasRandom from './components/PattatrasRandom.vue'
import PattatrasTable from './components/PattatrasTable.vue'
import { MAX, MIN } from './pattatras.js'

const TABS = [
  { id: 'aleatoire', label: 'Nombre aléatoire' },
  { id: 'tableau', label: 'Tableau Pattatras' },
]

const activeTab = ref('aleatoire')
</script>

<template>
  <main>
    <h1>Pattatras</h1>
    <p class="rules">
      Nombres de {{ MIN }} à {{ MAX }}. Multiple de 3 : <strong class="patte">Patte</strong>,
      de 5 : <strong class="tatras">Tatras</strong>,
      de 3 et 5 : <strong class="pattatras">Pattatras</strong>.
    </p>

    <div class="tabs" role="tablist">
      <button
        v-for="tab in TABS"
        :key="tab.id"
        type="button"
        role="tab"
        :aria-selected="activeTab === tab.id"
        :class="{ active: activeTab === tab.id }"
        @click="activeTab = tab.id"
      >
        {{ tab.label }}
      </button>
    </div>

    <!-- v-show : pas de nouvel appel API à chaque changement d'onglet -->
    <section v-show="activeTab === 'aleatoire'" role="tabpanel">
      <PattatrasRandom />
    </section>
    <section v-show="activeTab === 'tableau'" role="tabpanel">
      <PattatrasTable />
    </section>
  </main>
</template>
