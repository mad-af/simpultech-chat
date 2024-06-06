<template>
  <div class="message" id="msg">
    <!-- <div class="message_bubble">
      <span class="name">Aufa</span>
      <p>
        hello Myname Aufa ini adalah salah satua konten saya haha
      </p>
      <span class="date">11:24 | 2 Jan 2024</span>
    </div> -->
    <div v-for="elm in data" :key="elm.id" class="message_bubble" v-bind:class="{ 'me': elm.isMe }">
      <span class="name">{{ elm.created_by }}</span>
      <p>{{ elm.message }}</p>
      <span class="date">{{ elm.created_at }}</span>
    </div>
  </div>
</template>

<script setup>
import { onMounted, ref } from "vue";

const data = ref([]);

onMounted(async () => {
  const lsName = localStorage.getItem('name')
  if (lsName === null || lsName === '') {
    location.reload();
  }
  const res = await fetch("http://localhost:3000/chats")
  data.value = await res.json()

  data.value = data.value.map(elm => {
    if (elm.created_by === lsName) {
      elm.isMe = true
      elm.created_by = "Anda"
    }
    elm.created_at = FormatTime(elm.created_at)
    return elm
  })
})

function FormatTime(date) {
  date = new Date(date)
  const timeOptions = { hour: '2-digit', minute: '2-digit' };
  const dateOptions = { day: 'numeric', month: 'short', year: 'numeric' };
  let time = date.toLocaleTimeString('id-ID', timeOptions);
  let formattedDate = date.toLocaleDateString('id-ID', dateOptions);
  return time + ' | ' + formattedDate;
}

function ScrollToBottom() {
  var div = document.getElementById('msg');
  div.scrollTop = div.scrollHeight;
  console.log("HALLO", div.scrollHeight, div.scrollTop)
}

</script>

<style scoped>
.message {
  flex-grow: 1;
  background-color: #eee;
  overflow: auto;
  scrollbar-width: thin;
  padding: .75em;
  display: flex;
  flex-direction: column;
  gap: .5em;
}

.message_bubble {
  background-color: white;
  text-align: left;
  width: fit-content;
  padding: .2em .5em .5em;
  border-radius: 10px;
}

.message_bubble .name {
  font-size: small;
  font-weight: bold;
  color: rgb(220, 12, 186);
}

.message_bubble p {
  margin-bottom: .5em;
}

.message_bubble .date {
  font-size: small;
  font-weight: lighter;
  color: rgb(125, 125, 125);
  display: block;
  text-align: right;
}

.me {
  margin-left: auto;
  margin-right: 0;
}
</style>
