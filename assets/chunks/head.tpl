  <title>[[*pagetitle]][[++site_name]]</title>

  <link rel="icon" type="image/png" href="/assets/images/favicon.png">

  <base href="[[!++site_url]]" />
  
  <meta charset="[[++modx_charset]]" />
  <meta http-equiv="X-UA-Compatible" content="IE=edge" />
  <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1"/>

 [[++is_dev:eq=`1`:then=`
  <script type="module" src="http://localhost:5173/@vite/client"></script>
  <link rel="stylesheet" href="http://localhost:5173/assets/css/main.css">
`:else=`
  <link rel="stylesheet" href="/assets/css/main.min.css">
`]]

  <!-- Yandex.Metrika counter -->
  <script type="text/javascript">
    (function(m,e,t,r,i,k,a){
        m[i]=m[i]||function(){(m[i].a=m[i].a||[]).push(arguments)};
        m[i].l=1*new Date();
        for (var j = 0; j < document.scripts.length; j++) {if (document.scripts[j].src === r) { return; }}
        k=e.createElement(t),a=e.getElementsByTagName(t)[0],k.async=1,k.src=r,a.parentNode.insertBefore(k,a)
    })(window, document,'script','https://mc.yandex.ru/metrika/tag.js?id=110044907', 'ym');

    ym(110044907, 'init', {ssr:true, webvisor:true, clickmap:true, ecommerce:"dataLayer", referrer: document.referrer, url: location.href, accurateTrackBounce:true, trackLinks:true});
  </script>
  <noscript><div><img src="https://mc.yandex.ru/watch/110044907" style="position:absolute; left:-9999px;" alt="" /></div></noscript>
  <!-- /Yandex.Metrika counter -->