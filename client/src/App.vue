<template>
  <div class="container">
    <Chat />
  </div>
  <div class="modal" v-show="lsName === null || lsName === ''">
    <div class="card">
      <h1>SimpulTech Chat</h1>
      <input v-model="name" type="text" placeholder="Masukkan Nama Anda" required>
      <button @click="LogIn">Masuk</button>
    </div>
  </div>
</template>

<script setup>
  import Chat from './components/Chat.vue'
  import {ref} from "vue";

  const lsName = ref(localStorage.getItem('name'));
  const name = ref('');
  
  const LogIn = async () => {
    localStorage.setItem('name', name.value)
    location.reload();
  }
</script>

<style scoped>

.container {
  background-color: rgb(154, 238, 165);
  height: 75vh;
  width: 70vw;
  padding: 1.5em;
  will-change: filter;
  transition: filter 300ms;
}

.hidden {
  display: none;
}

.modal {
  position: absolute;
  background-color: rgba(0, 0, 0, 0.19);
  width: 100vw;
  height: 100vh;
  top: 0;
  left: 0;
}

.card {
  background-color: white;
  display: flex;
  flex-direction: column;
  align-items: center;
  gap: .5em;
}

.card input {
  border-radius: 5px;
  width: 50vh;
  font-size: 1rem;
  padding: .6em .4em .4em;
  text-align: center;
}

.card button {
  border-radius: 5px;
  background-color: rgb(255, 247, 0);
}

</style>
