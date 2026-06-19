<div class="flex flex-col">
  <div class="flex flex-col items-center text-[#FFB35B]">

    <!-- Строка 1: на xl — стрелки + ГОЛОСА; на мобильных — только ГОЛОСА -->
    <div class="flex items-center gap-x-8">
      <img class="hidden xl:block w-10 h-10" src="/assets/images/flower-right.png" alt="">
      <span class="text-[30px] xl:text-[80px] font-balkara">ГОЛОСА</span>
      <img class="hidden xl:block w-10 h-10 rotate-180" src="/assets/images/flower-right.png" alt="">
    </div>

    <!-- Строка 2 xl: НАРОДОВ РОССИИИ в одну строку -->
    <h1 class="hidden xl:block text-[80px] font-balkara">НАРОДОВ РОССИИИ</h1>

    <!-- Строка 2 мобильная: стрелки + НАРОДОВ -->
    <div class="flex items-center gap-x-2 xl:gap-x-8 xl:hidden">
      <img class="w-5 h-5" src="/assets/images/flower-right.png" alt="">
      <span class="text-[30px] font-balkara">НАРОДОВ</span>
      <img class="w-5 h-5 rotate-180" src="/assets/images/flower-right.png" alt="">
    </div>

    <!-- Строка 3 мобильная: РОССИИИ -->
    <span class="text-[30px] xl:hidden font-balkara">РОССИИИ</span>

    <h2 class="text-[15px] xl:text-[40px] mt-2 xl:mt-4 font-neris font-light">
      ЗВУЧАЩАЯ КАРТА
    </h2>
  </div>

  <div class="my-4 xl:my-10 w-full overflow-hidden">
    <div id="russian-map"></div>
    <div id="region-label"></div>
  </div>

  <div
    class="flex flex-col items-center text-[15px] xl:text-[25px] text-white font-neris font-light"
    >
    <div class="w-2/3 xl:w-1/2 text-center">
      <p>Цифровая платформа аудиосказок:</p>
      <p>«Голоса народов России»</p>
    </div>
  </div>
</div>
