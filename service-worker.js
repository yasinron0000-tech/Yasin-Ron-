const CACHE_VERSION = "excel-master-yasin-v20";
const BASE = new URL("./", self.location).pathname;
const APP_SHELL = [BASE, BASE + "index.html", BASE + "manifest.json", BASE + "manifest.webmanifest", BASE + "icon-192.png", BASE + "icon-512.png", BASE + "icon.svg"];
self.addEventListener("install", event => event.waitUntil(caches.open(CACHE_VERSION).then(c=>c.addAll(APP_SHELL)).then(()=>self.skipWaiting())));
self.addEventListener("activate", event => event.waitUntil(caches.keys().then(keys=>Promise.all(keys.filter(k=>k!==CACHE_VERSION).map(k=>caches.delete(k)))).then(()=>self.clients.claim())));
self.addEventListener("fetch", event => {
 if(event.request.method!=="GET") return;
 const url=new URL(event.request.url); if(url.origin!==self.location.origin) return;
 event.respondWith(fetch(event.request).then(r=>{const c=r.clone(); caches.open(CACHE_VERSION).then(x=>x.put(event.request,c)).catch(()=>{}); return r;}).catch(()=>caches.match(event.request).then(r=>r||caches.match(BASE+"index.html"))));
});
