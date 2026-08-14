const CACHE_VERSION = "excel-master-yasin-v14";
const BASE = "/Yasin-Ron-/";
const APP_SHELL = [BASE, BASE+"index.html", BASE+"manifest.json", BASE+"icon-192.png", BASE+"icon-512.png", BASE+"icon.svg"];
self.addEventListener("install", e => e.waitUntil(caches.open(CACHE_VERSION).then(c=>c.addAll(APP_SHELL)).then(()=>self.skipWaiting())));
self.addEventListener("activate", e => e.waitUntil(caches.keys().then(keys=>Promise.all(keys.filter(k=>k!==CACHE_VERSION).map(k=>caches.delete(k)))).then(()=>self.clients.claim())));
self.addEventListener("fetch", e => {
  if(e.request.method!=="GET") return;
  const u=new URL(e.request.url);
  if(u.origin!==location.origin) return;
  e.respondWith(fetch(e.request).then(r=>{const c=r.clone(); caches.open(CACHE_VERSION).then(x=>x.put(e.request,c)).catch(()=>{}); return r;}).catch(()=>caches.match(e.request).then(r=>r||caches.match(BASE+"index.html"))));
});
