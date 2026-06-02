<div class="flex flex-col">
  <div class="flex flex-col items-center text-[#FFB35B]">

    <!-- Строка 1: на xl — стрелки + ГОЛОСА; на мобильных — только ГОЛОСА -->
    <div class="flex items-center gap-x-8">
      <img class="hidden xl:block w-10 h-10" src="/assets/images/flower-right.png" alt="">
      <span class="text-[60px] xl:text-[80px] font-balkara">ГОЛОСА</span>
      <img class="hidden xl:block w-10 h-10 rotate-180" src="/assets/images/flower-right.png" alt="">
    </div>

    <!-- Строка 2 xl: НАРОДОВ РОССИИИ в одну строку -->
    <h1 class="hidden xl:block text-[80px] font-balkara">НАРОДОВ РОССИИИ</h1>

    <!-- Строка 2 мобильная: стрелки + НАРОДОВ -->
    <div class="flex items-center gap-x-0 min-[576px]:gap-x-2 xl:gap-x-8 xl:hidden">
      <img class="w-8 h-8" src="/assets/images/flower-right.png" alt="">
      <span class="text-[60px] font-balkara">НАРОДОВ</span>
      <img class="w-8 h-8 rotate-180" src="/assets/images/flower-right.png" alt="">
    </div>

    <!-- Строка 3 мобильная: РОССИИИ -->
    <span class="xl:hidden text-[60px] font-balkara">РОССИИИ</span>

    <h2 class="text-[25px] xl:text-[40px] mt-2 xl:mt-4 font-neris font-light">
      ЗВУЧАЩАЯ КАРТА
    </h2>
  </div>

  <div class="my-4 xl:my-10 w-full overflow-hidden">
    <div id="russian-map"></div>
    <div id="region-label"></div>
  </div>

  <div
    class="flex flex-col items-center text-[25px] text-white font-neris font-light"
    >
    <div class="w-1/2 text-center">
      <p>Цифровая платформа аудиосказок:</p>
      <p>"Голоса народов России"</p>
    </div>
  </div>
</div>
