import { createApp } from 'vue'
import './style.css'
import App from './App.vue'
import VueChatScroll from 'vue-chat-scroll'

const app = createApp(App)
app.use(VueChatScroll)
app.mount('#app')