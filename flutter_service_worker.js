'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';

const RESOURCES = {"assets/AssetManifest.json": "f56d6746b0172ba4d7d9f30f5f237628",
"assets/AssetManifest.bin": "2131935a3e8940cce00238ccf31ba9ea",
"assets/assets/audio/bgm_2.aac": "228f0dbed87ceb6d6485c157815b4339",
"assets/assets/audio/bgm_1.aac": "4e26559ee557c94f1a619d562b35a91a",
"assets/assets/audio/tap.mp3": "8a5a0c59decec744d49db5e9a217132e",
"assets/assets/audio/explode.mp3": "d6bd39de1cdd56df82d092b2b4ad5956",
"assets/assets/audio/combust.mp3": "683298d413bfe1f62722e42d480ccffa",
"assets/assets/audio/bgm_3.aac": "052345ac61088a4dd3091c06ec1e780f",
"assets/assets/audio/rocket_launch.mp3": "7944d5f7f188870b5bce28283aac1240",
"assets/assets/audio/collect.mp3": "57914c333b0790e6db84f1e16dbcd3f5",
"assets/assets/audio/bgm_4.aac": "6ec24e0b6fe89639d88bf0e59cffa9cb",
"assets/assets/audio/solar_appear.mp3": "e5e0e8e7e0e93e27d1e0ed1777b32d2a",
"assets/assets/fonts/montjuic.ttf": "be9b71e686a5f563db64c904e170f31d",
"assets/assets/fonts/lana_pixel.ttf": "20cef6e2d33a6ed1400be23326ca92c7",
"assets/assets/fonts/at01.ttf": "6e86f983076f98bbb189a74caa6a7485",
"assets/assets/shaders/dry_planet.frag": "dbe0ddc14784ccd1f5be3a31f47b8dfe",
"assets/assets/shaders/gas_planet.frag": "9734941ff08833bc83e6ba8793baedaa",
"assets/assets/shaders/solar.frag": "b98b1b4c076ba592da388093b214b7a5",
"assets/assets/shaders/nebulae_gas.frag": "36b3618dc09205191be4d1cd9b0d4e75",
"assets/assets/shaders/gravity_bubble.frag": "40394cee5754f7165071674c00757765",
"assets/assets/images/linkedin.png": "5db7b468af756a37682e34b6a5056e62",
"assets/assets/images/stars.png": "4577f3a7d0cd863ca013e957f8899779",
"assets/assets/images/hand.png": "1181ca4b4a42583f37a3f2c8edd399ad",
"assets/assets/images/explosion.png": "95f0ab7153b698b17b81058fd366ebe2",
"assets/assets/images/github.png": "177f1a7948fee4438b95a0953ca8f962",
"assets/assets/images/headphone.png": "dd1dcad3e4ebe0c517e2c7640c43cf40",
"assets/assets/images/exhaust.png": "1c9df9d863280afc5633607423606944",
"assets/assets/images/asteroids.png": "9a18d2b6b31f6be84985e66f684f835f",
"assets/assets/images/big_stars.png": "de8d9ef51a7545fdb001f80da34d41bb",
"assets/assets/images/finish.jpg": "d1f2c40e293aa497fd2483ce5393e795",
"assets/assets/images/instagram.png": "565cbbeb727e274ae89918a48c1e80d4",
"assets/assets/images/rocket.png": "0e537e148e1f2aaa4f7ac3b7bfbb2f6e",
"assets/assets/images/back.png": "1ec64db5e119a3bfbd08d786a3e0de4b",
"assets/assets/images/pause.png": "550bdcfd3c9ac16e3c2dccd333dab380",
"assets/assets/images/twitter.png": "5e8fed4117651c0fe903d25a369df5c9",
"assets/FontManifest.json": "11c1555429b00f0560fff1882128c68e",
"assets/fonts/MaterialIcons-Regular.otf": "c0ad29d56cfe3890223c02da3c6e0448",
"assets/AssetManifest.bin.json": "519d1c4bb5a1032d40d5b4e76d83086e",
"assets/shaders/ink_sparkle.frag": "ecc85a2e95f5e9f53123dcaf8cb9b6ce",
"assets/NOTICES": "abba16bc3fc61d35294f4755e432ebe9",
"assets/packages/flutter_soloud/web/worker.dart.js": "2fddc14058b5cc9ad8ba3a15749f9aef",
"assets/packages/flutter_soloud/web/libflutter_soloud_plugin.js": "ecbc8742074492588867ff9b5e0300cf",
"assets/packages/flutter_soloud/web/libflutter_soloud_plugin.wasm": "c94045b7a06ac6756baf642b57ddbf38",
"assets/packages/flutter_soloud/web/init_module.dart.js": "ea0b343660fd4dace81cfdc2910d14e6",
"assets/packages/text_gradiate/assets/images/samp1.jpg": "26e7fa6e2138b3802d6cd66106d607ed",
"assets/packages/text_gradiate/assets/images/samp2.jpg": "7aeb160623684419591737479fcb64bc",
"assets/packages/text_gradiate/assets/images/samp3.jpg": "1e71c58ff56111ce54869dcafc1eac33",
"assets/packages/cupertino_icons/assets/CupertinoIcons.ttf": "33b7d9392238c04c131b6ce224e13711",
"manifest.json": "82a70f17692e0afbf657b00cdaa36ba2",
"version.json": "c57a11647e2cf77e6fdd656f9a402f1f",
"flutter.js": "76f08d47ff9f5715220992f993002504",
"canvaskit/chromium/canvaskit.js": "34beda9f39eb7d992d46125ca868dc61",
"canvaskit/chromium/canvaskit.wasm": "64a386c87532ae52ae041d18a32a3635",
"canvaskit/chromium/canvaskit.js.symbols": "5a23598a2a8efd18ec3b60de5d28af8f",
"canvaskit/skwasm.js": "f2ad9363618c5f62e813740099a80e63",
"canvaskit/skwasm.wasm": "f0dfd99007f989368db17c9abeed5a49",
"canvaskit/canvaskit.js": "86e461cf471c1640fd2b461ece4589df",
"canvaskit/skwasm_st.wasm": "56c3973560dfcbf28ce47cebe40f3206",
"canvaskit/canvaskit.wasm": "efeeba7dcc952dae57870d4df3111fad",
"canvaskit/skwasm.js.symbols": "80806576fa1056b43dd6d0b445b4b6f7",
"canvaskit/skwasm_st.js": "d1326ceef381ad382ab492ba5d96f04d",
"canvaskit/canvaskit.js.symbols": "68eb703b9a609baef8ee0e413b442f33",
"canvaskit/skwasm_st.js.symbols": "c7e7aac7cd8b612defd62b43e3050bdd",
"index.html": "cc8c8809fbf0cd9ce05d954e166d6233",
"/": "cc8c8809fbf0cd9ce05d954e166d6233",
"flutter_bootstrap.js": "aa39f20298df1170667a72d30a753145",
"icons/Icon-192.png": "ac9a721a12bbc803b44f645561ecb1e1",
"icons/Icon-maskable-192.png": "c457ef57daa1d16f64b27b786ec2ea3c",
"icons/Icon-maskable-512.png": "301a7604d45b3e739efc881eb04896ea",
"icons/Icon-512.png": "96e752610906ba2a93c65f8abe1645f1",
"favicon.png": "5dcef449791fa27946b3d35ad8803796",
"main.dart.js": "97d0d9a20b4056a62b9af0ce4538d4ee"};
// The application shell files that are downloaded before a service worker can
// start.
const CORE = ["main.dart.js",
"index.html",
"flutter_bootstrap.js",
"assets/AssetManifest.bin.json",
"assets/FontManifest.json"];

// During install, the TEMP cache is populated with the application shell files.
self.addEventListener("install", (event) => {
  self.skipWaiting();
  return event.waitUntil(
    caches.open(TEMP).then((cache) => {
      return cache.addAll(
        CORE.map((value) => new Request(value, {'cache': 'reload'})));
    })
  );
});
// During activate, the cache is populated with the temp files downloaded in
// install. If this service worker is upgrading from one with a saved
// MANIFEST, then use this to retain unchanged resource files.
self.addEventListener("activate", function(event) {
  return event.waitUntil(async function() {
    try {
      var contentCache = await caches.open(CACHE_NAME);
      var tempCache = await caches.open(TEMP);
      var manifestCache = await caches.open(MANIFEST);
      var manifest = await manifestCache.match('manifest');
      // When there is no prior manifest, clear the entire cache.
      if (!manifest) {
        await caches.delete(CACHE_NAME);
        contentCache = await caches.open(CACHE_NAME);
        for (var request of await tempCache.keys()) {
          var response = await tempCache.match(request);
          await contentCache.put(request, response);
        }
        await caches.delete(TEMP);
        // Save the manifest to make future upgrades efficient.
        await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
        // Claim client to enable caching on first launch
        self.clients.claim();
        return;
      }
      var oldManifest = await manifest.json();
      var origin = self.location.origin;
      for (var request of await contentCache.keys()) {
        var key = request.url.substring(origin.length + 1);
        if (key == "") {
          key = "/";
        }
        // If a resource from the old manifest is not in the new cache, or if
        // the MD5 sum has changed, delete it. Otherwise the resource is left
        // in the cache and can be reused by the new service worker.
        if (!RESOURCES[key] || RESOURCES[key] != oldManifest[key]) {
          await contentCache.delete(request);
        }
      }
      // Populate the cache with the app shell TEMP files, potentially overwriting
      // cache files preserved above.
      for (var request of await tempCache.keys()) {
        var response = await tempCache.match(request);
        await contentCache.put(request, response);
      }
      await caches.delete(TEMP);
      // Save the manifest to make future upgrades efficient.
      await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
      // Claim client to enable caching on first launch
      self.clients.claim();
      return;
    } catch (err) {
      // On an unhandled exception the state of the cache cannot be guaranteed.
      console.error('Failed to upgrade service worker: ' + err);
      await caches.delete(CACHE_NAME);
      await caches.delete(TEMP);
      await caches.delete(MANIFEST);
    }
  }());
});
// The fetch handler redirects requests for RESOURCE files to the service
// worker cache.
self.addEventListener("fetch", (event) => {
  if (event.request.method !== 'GET') {
    return;
  }
  var origin = self.location.origin;
  var key = event.request.url.substring(origin.length + 1);
  // Redirect URLs to the index.html
  if (key.indexOf('?v=') != -1) {
    key = key.split('?v=')[0];
  }
  if (event.request.url == origin || event.request.url.startsWith(origin + '/#') || key == '') {
    key = '/';
  }
  // If the URL is not the RESOURCE list then return to signal that the
  // browser should take over.
  if (!RESOURCES[key]) {
    return;
  }
  // If the URL is the index.html, perform an online-first request.
  if (key == '/') {
    return onlineFirst(event);
  }
  event.respondWith(caches.open(CACHE_NAME)
    .then((cache) =>  {
      return cache.match(event.request).then((response) => {
        // Either respond with the cached resource, or perform a fetch and
        // lazily populate the cache only if the resource was successfully fetched.
        return response || fetch(event.request).then((response) => {
          if (response && Boolean(response.ok)) {
            cache.put(event.request, response.clone());
          }
          return response;
        });
      })
    })
  );
});
self.addEventListener('message', (event) => {
  // SkipWaiting can be used to immediately activate a waiting service worker.
  // This will also require a page refresh triggered by the main worker.
  if (event.data === 'skipWaiting') {
    self.skipWaiting();
    return;
  }
  if (event.data === 'downloadOffline') {
    downloadOffline();
    return;
  }
});
// Download offline will check the RESOURCES for all files not in the cache
// and populate them.
async function downloadOffline() {
  var resources = [];
  var contentCache = await caches.open(CACHE_NAME);
  var currentContent = {};
  for (var request of await contentCache.keys()) {
    var key = request.url.substring(origin.length + 1);
    if (key == "") {
      key = "/";
    }
    currentContent[key] = true;
  }
  for (var resourceKey of Object.keys(RESOURCES)) {
    if (!currentContent[resourceKey]) {
      resources.push(resourceKey);
    }
  }
  return contentCache.addAll(resources);
}
// Attempt to download the resource online before falling back to
// the offline cache.
function onlineFirst(event) {
  return event.respondWith(
    fetch(event.request).then((response) => {
      return caches.open(CACHE_NAME).then((cache) => {
        cache.put(event.request, response.clone());
        return response;
      });
    }).catch((error) => {
      return caches.open(CACHE_NAME).then((cache) => {
        return cache.match(event.request).then((response) => {
          if (response != null) {
            return response;
          }
          throw error;
        });
      });
    })
  );
}
