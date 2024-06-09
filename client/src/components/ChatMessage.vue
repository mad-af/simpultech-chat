<template>
  <!-- <div class="message" v-chat-scroll> -->
  <div class="message" id="msg">
    <div v-for="elm in data" :key="elm.id" class="message_bubble" v-bind:class="{ 'me': elm.isMe }">
      <span class="name">{{ elm.created_by }}</span>
      <p>{{ elm.message }}</p>
      <span class="date">{{ elm.created_at }}</span>
    </div>
    <div id="end"></div>
  </div>
</template>

<script setup>
import { ref, watchEffect, watchPostEffect } from "vue";

const ws = new WebSocket("ws://localhost:3000/cable")

const data = ref([]);
let guid = "";
const lsName = localStorage.getItem('name')

ws.onopen = () => {
  guid = Math.random().toString(36).substring(2, 15)
  ws.send(
    JSON.stringify({
      command: "subscribe",
      identifier: JSON.stringify({
        id: guid,
        channel: "ChatChannel"
      })
    })
  )
}

ws.onmessage = (ev) => {
  const evdata = JSON.parse(ev.data);
  if (['ping', 'welcome', 'confirm_subscription'].includes(evdata.type)) return;
  let elm = evdata.message
  if (elm.created_by === lsName) {
      elm.isMe = true
      elm.created_by = "Anda"
    }
    elm.created_at = FormatTime(Date.now())
  data.value.push(elm)
}

watchEffect(async () => {
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

watchPostEffect(() => {
  ScrollToBottom()
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
  const observer = new MutationObserver((a, b) => {
    const h = div.scrollHeight
    div.scroll(0, h)
  })
  observer.observe(div, {attributes: true, childList: true, subtree: true})
}

</script>

<style scoped>
.message {
  /* flex-grow: 1; */
  background-color: #eee;
  overflow: auto;
  scrollbar-width: thin;
  padding: .75em;
  /* display: flex;
  flex-direction: column; */
  max-height: 100em;
  /* gap: .5em; */
}

.message_bubble {
  background-color: white;
  text-align: left;
  width: fit-content;
  padding: .2em .5em .5em;
  border-radius: 10px;
  margin-bottom: .5em;
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

/* .message * {
  overflow-anchor: none;
}

#end {
  overflow-anchor: auto;
  --webkit-overflow-anchor: auto;
  height: 1px;
} */
</style>
