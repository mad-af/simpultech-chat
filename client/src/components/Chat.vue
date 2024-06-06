<template>
  <div class="chat">
    <ChatMessage />
    <ChatSendMessage />
  </div>
</template>

<script setup>
  import ChatSendMessage from './ChatSendMessage.vue'
  import ChatMessage from './ChatMessage.vue'
  import { ref } from 'vue'

  defineProps({
    msg: String,
  })

  const count = ref(0)
</script>

<style scoped>
  .chat {
    height: 100%;
    display: flex;
    flex-direction: column;
    /* outline: 2px solid #213547; */
    /* outline-offset: 4px; */
    gap: .3em;
  }
</style>
