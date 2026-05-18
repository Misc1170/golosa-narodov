<!-- header -->

<!-- Десктопная версия (≥1280px) -->
<nav class="text-white hidden xl:block max-w-[1440px] mx-auto px-12 pt-12">
  <div class="grid grid-cols-12">
    <div
      class="col-span-5 flex justify-end items-center gap-x-16 font-neris font-semibold text-lg"
    >
      <a href="/">ГЛАВНАЯ</a>
      <!-- todo добавить hover для всех ссылок -->
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
<!-- Хедер всегда виден, меню выпадает под ним -->
<div class="relative w-full mb-12 xl:hidden">
  <!-- Внутренний контейнер с ограничением ширины и отступами -->
  <div class="max-w-[1440px] mx-auto px-6 pt-12">
    <!-- Видимая строка хедера: бургер + полоса + эмблема -->
    <div class="relative z-50 grid grid-cols-12 w-full items-center">
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

  <!-- Выпадающее меню — появляется под хедером, во всю ширину окна -->
  <div
    id="mobile-menu"
    class="hidden absolute top-full left-0 right-0 z-40 bg-[#0F212F]/95 flex-col items-center gap-y-8 py-12 text-white font-neris font-semibold text-2xl"
  >
    <a href="/" class="hover:text-[#FFB35B] transition-colors">ГЛАВНАЯ</a>
    <a href="[[~3]]" class="hover:text-[#FFB35B] transition-colors">ЯЗЫКИ</a>
    <a href="[[~10]]" class="hover:text-[#FFB35B] transition-colors">О ПРОЕКТЕ</a>
    <a href="[[~11]]" class="hover:text-[#FFB35B] transition-colors">КОМАНДА</a>
    <a href="[[~12]]" class="hover:text-[#FFB35B] transition-colors">НОВОСТИ</a>
    <a href="[[~13]]" class="hover:text-[#FFB35B] transition-colors">КОНТАКТЫ</a>
  </div>
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
    if (!burgerBtn || !mobileMenu) return;

    function setMenuOpen(open) {
      if (open) {
        burgerBtn.classList.add('is-open');
        burgerBtn.setAttribute('aria-expanded', 'true');
        mobileMenu.classList.remove('hidden');
        mobileMenu.classList.add('flex');
      } else {
        burgerBtn.classList.remove('is-open');
        burgerBtn.setAttribute('aria-expanded', 'false');
        mobileMenu.classList.add('hidden');
        mobileMenu.classList.remove('flex');
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
  })();
</script>
