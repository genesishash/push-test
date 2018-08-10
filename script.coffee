log = (x...) -> try console.log x...
log /script.coffee/, new Date

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
SW_REG = null
SW_SUB = null

navigator.serviceWorker.register('/worker.coffee').then (reg) ->
  log /worker registered/
  SW_REG = reg

  SW_REG.pushManager.getSubscription().then (sub) ->
    return SW_SUB = sub if sub

    SW_REG.pushManager.subscribe({
      userVisibleOnly: true,
      applicationServerKey: urlB64ToUint8Array(PUBLIC)
    }).then (sub) -> SW_SUB = sub

##
$('#store').click (e) ->
  e.preventDefault()
  $.post '/store', {subscription:JSON.stringify(SW_SUB)}, -> 1

