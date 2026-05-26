
<!-- Десктопная версия (≥1280px) -->
<nav class="text-white hidden xl:block max-w-[1440px] mx-auto px-12 pt-12">
  <div class="grid grid-cols-12">
    <div
      class="col-span-5 flex justify-end items-center gap-x-16 font-neris font-semibold text-lg"
    >
      <a href="/">ГЛАВНАЯ</a>
      <a href="[[~3]]">ЯЗЫКИ</a>
      <a href="[[~10]]">О ПРОЕКТЕ</a>
    </div>

    <div class="col-span-2 flex justify-center items-center"></div>

    <div
      class="col-span-5 flex justify-start items-center gap-x-16 font-neris font-semibold text-lg"
    >
      <a href="[[~11]]">КОМАНДА</a>
      <a href="[[~12]]">НОВОСТИ</a>
      <a href="[[~13]]">КОНТАКТЫ</a>
    </div>
  </div>
</nav>

<!-- Полоса и голотип по середине (десктоп) -->
<div class="hidden xl:grid grid-cols-12 w-full max-w-[1440px] mx-auto px-12 mb-12">
  <div class="col-span-5 flex items-center">
    <span class="h-0.5 w-full bg-white"></span>
  </div>

  <div class="col-span-2 flex justify-center items-center">
    <a href="/">
      <img class="w-[85px] h-[85px]" src="/assets/images/main-emblem.png" alt="">
    </a>
  </div>

  <div class="col-span-5 flex items-center">
    <span class="h-0.5 w-full bg-white"></span>
  </div>
</div>

<!-- Мобильная/планшетная версия (<1280px) -->
<!-- Хедер всегда виден, меню разворачивается под ним и не перекрывает крестик/полосу/эмблему -->
<div class="relative w-full mb-12 xl:hidden">
  <!-- Внутренний контейнер с ограничением ширины и отступами -->
  <div class="max-w-[1440px] mx-auto px-6 pt-12">
    <!-- Видимая строка хедера: бургер + полоса + эмблема -->
    <div id="mobile-header-bar" class="relative z-50 grid grid-cols-12 w-full items-center">
      <!-- Бургер слева -->
      <div class="col-span-3 flex justify-start items-center">
        <button
          id="burger-btn"
          type="button"
          class="flex flex-col justify-center items-center gap-1.5 cursor-pointer p-2 w-12 h-12"
          aria-label="Меню"
          aria-controls="mobile-menu"
          aria-expanded="false"
        >
          <span class="burger-line block w-8 h-0.5 bg-white"></span>
          <span class="burger-line block w-8 h-0.5 bg-white"></span>
          <span class="burger-line block w-8 h-0.5 bg-white"></span>
        </button>
      </div>

      <!-- Полоса по центру -->
      <div class="col-span-6 flex items-center px-4">
        <span class="h-0.5 w-full bg-white"></span>
      </div>

      <!-- Эмблема справа -->
      <div class="col-span-3 flex justify-end items-center">
        <a href="/">
          <img class="xl:w-[85px] xl:h-[85px] w-[70px] h-[70px]" src="/assets/images/main-emblem.png" alt="">
        </a>
      </div>
    </div>
  </div>
</div>

<!-- Меню — закрывает всё что ниже строки хедера. JS подставляет inline top = нижняя граница хедер-бара -->
<div
  id="mobile-menu"
  class="hidden xl:hidden fixed left-0 right-0 bottom-0 z-40 bg-[#CDC3B3] flex-col items-start text-black font-neris font-semibold text-2xl"
  style="top: 0;"
>
  <a href="[[~3]]" class="p-6 w-full hover:bg-[#FFB35B]"><span>ЯЗЫКИ</span></a>
  <a href="[[~10]]" class="p-6 w-full hover:bg-[#FFB35B]"><span>О ПРОЕКТЕ</span></a>
  <a href="[[~11]]" class="p-6 w-full hover:bg-[#FFB35B]"><span>КОМАНДА</span></a>
  <a href="[[~12]]" class="p-6 w-full hover:bg-[#FFB35B]"><span>НОВОСТИ</span></a>
  <a href="[[~13]]" class="p-6 w-full hover:bg-[#FFB35B]"><span>КОНТАКТЫ</span></a>
</div>

<style>
  /* Анимация бургер → крестик */
  #burger-btn .burger-line {
    transition: transform 0.3s ease, opacity 0.2s ease;
    transform-origin: center;
  }
  #burger-btn.is-open .burger-line:nth-child(1) {
    transform: translateY(8px) rotate(45deg);
  }
  #burger-btn.is-open .burger-line:nth-child(2) {
    opacity: 0;
  }
  #burger-btn.is-open .burger-line:nth-child(3) {
    transform: translateY(-8px) rotate(-45deg);
  }
</style>

<script>
  (function () {
    var burgerBtn = document.getElementById('burger-btn');
    var mobileMenu = document.getElementById('mobile-menu');
    var headerBar = document.getElementById('mobile-header-bar');
    if (!burgerBtn || !mobileMenu) return;

    // Позиционирует верх меню сразу под нижней границей строки хедера
    function positionMenu() {
      if (!headerBar) return;
      var rect = headerBar.getBoundingClientRect();
      mobileMenu.style.top = rect.bottom + 'px';
    }

    function setMenuOpen(open) {
      if (open) {
        positionMenu();
        burgerBtn.classList.add('is-open');
        burgerBtn.setAttribute('aria-expanded', 'true');
        mobileMenu.classList.remove('hidden');
        mobileMenu.classList.add('flex');
        document.body.style.overflow = 'hidden';
      } else {
        burgerBtn.classList.remove('is-open');
        burgerBtn.setAttribute('aria-expanded', 'false');
        mobileMenu.classList.add('hidden');
        mobileMenu.classList.remove('flex');
        document.body.style.overflow = '';
      }
    }

    burgerBtn.addEventListener('click', function () {
      setMenuOpen(!burgerBtn.classList.contains('is-open'));
    });

    // Клик по ссылке закрывает меню
    mobileMenu.querySelectorAll('a').forEach(function (link) {
      link.addEventListener('click', function () { setMenuOpen(false); });
    });

    // Закрытие по Escape
    document.addEventListener('keydown', function (e) {
      if (e.key === 'Escape') setMenuOpen(false);
    });

    // При ресайзе окна (если меню открыто) пересчитываем верх
    window.addEventListener('resize', function () {
      if (!mobileMenu.classList.contains('hidden')) positionMenu();
    });
  })();
</script>
