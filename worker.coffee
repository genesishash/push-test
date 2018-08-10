log = (x...) -> try console.log x...
log /worker.coffee/, new Date

`function urlB64ToUint8Array(base64String) {
  const padding = '='.repeat((4 - base64String.length % 4) % 4);
  const base64 = (base64String + padding)
    .replace(/\-/g, '+')
    .replace(/_/g, '/');

  const rawData = window.atob(base64);
  const outputArray = new Uint8Array(rawData.length);

  for (let i = 0; i < rawData.length; ++i) {
    outputArray[i] = rawData.charCodeAt(i);
  }
  return outputArray;
}`

PUBLIC = 'BDyigABN2B4whJezxI0SUKgeMGG5gccj-veMrqQGeSEzGEzt62ejK3rtvLrBZdujo1-i_CAfSiCC0Ml8zplnWUs'

# on msg
self.addEventListener 'push', (event) ->
  log /event/, /push/, event.data.text()

  title = 'Hello, world'

  options = {
    body: 'Nullam rhoncus neque ornare massa aliquet'
    icon: null
    badge: null
  }

  event.waitUntil(self.registration.showNotification(title,options))

# on msg click
self.addEventListener 'notificationclick', (event) ->
  log /event/, /notificationclick/, event.data.text()
  event.notification.close()

