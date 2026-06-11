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