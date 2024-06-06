<template>
  <div class="send_message">
    <input v-model="message" type="text" placeholder="Tulis pesan anda disini...">
    <button @click="Send">Kirim</button>
  </div>
</template>

<script setup>
  import {ref} from "vue";

  const message = ref('')

  const Send = async() => {
    if (message.value === '') return

    const lsName = localStorage.getItem('name')
    if (lsName === null || lsName === '') {
      location.reload();
    }

    await fetch("http://localhost:3000/chats", {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json'
      },
      body: JSON.stringify({
        message: message.value,
        created_by: lsName
      })
    })

    message.value = ''
  }
</script>

<style scoped>
  .send_message {
    flex-grow: 0;
    /* height: 3em; */
    width: auto;
    display: flex;
    gap: .3em;
    align-items: center;
  }

  .send_message input {
    flex-grow: 1;
    border-radius: 5px;
    border: none;
    font-size: 1rem;
    padding: .6em .4em .4em;
  }

  .send_message button {
    flex-grow: 0;
    height: 2.25em;
    padding: 0 1.25em;
    border-radius: 5px;
    border: none;
    font-size: 1rem;
    background-color: rgb(255, 247, 0);
  }
</style>
