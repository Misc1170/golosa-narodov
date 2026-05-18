<div class="flex items-center gap-x-8 text-[#FFB35B]">
    <img class="w-[115px] h-[15px]" src="/assets/images/bubles.png" alt="">
    <h1 class="text-[50px] font-balkara">Новости</h1>
    <img class="w-[115px] h-[15px]" src="/assets/images/bubles.png" alt="">
</div>

<div class="w-full mx-10 my-20" id="news-page">
    <!-- Список новостей: все карточки в DOM, JS показывает по 3 на страницу -->
    <div id="news-list" class="flex flex-col gap-y-8">
        [[getImageList?
            &tvname=`news_list`
            &tpl=`newsItem`
        ]]
    </div>

    <!-- Пагинация: стрелки + до 10 страниц одновременно -->
    <div
      id="news-pagination"
      class="flex justify-center items-center gap-x-2 mt-12 font-neris"
    ></div>
</div>

<script>
(function () {
  const PAGE_SIZE = 3;       // максимум новостей на странице
  const VISIBLE_PAGES = 10;  // одновременно отображаемых страниц в пагинации

  /* =========================================================
   * Инициализация каждой карточки: галерея + раскрытие текста
   * =======================================================*/
  function initCard(card) {
    /* --- Галерея --- */
    const gallery = card.querySelector('[data-gallery]');
    if (gallery) {
      const images = gallery.querySelectorAll('.news-gallery-img');
      const prev = gallery.querySelector('[data-gallery-prev]');
      const next = gallery.querySelector('[data-gallery-next]');

      if (images.length === 0) {
        // Нет картинок — скрываем галерею, текст займёт всю ширину
        gallery.style.display = 'none';
      } else {
        let current = 0;
        images[0].classList.remove('hidden');

        if (images.length <= 1) {
          if (prev) prev.style.display = 'none';
          if (next) next.style.display = 'none';
        } else {
          const show = (i) => {
            images[current].classList.add('hidden');
            current = ((i % images.length) + images.length) % images.length;
            images[current].classList.remove('hidden');
          };
          if (prev) prev.addEventListener('click', () => show(current - 1));
          if (next) next.addEventListener('click', () => show(current + 1));
        }
      }
    }

    /* --- Раскрытие/сворачивание текста --- */
    const toggle = card.querySelector('[data-toggle-news]');
    const fade = card.querySelector('[data-fade]');
    const labelC = card.querySelector('[data-toggle-collapsed]');
    const labelE = card.querySelector('[data-toggle-expanded]');

    // Если содержимое вмещается в 344px — кнопка и затухание не нужны
    const overflows = card.scrollHeight > 344;
    if (!overflows) {
      if (toggle) toggle.style.display = 'none';
      if (fade) fade.style.display = 'none';
      return;
    }

    if (!toggle) return;
    toggle.addEventListener('click', () => {
      const expanded = card.classList.toggle('is-expanded');
      if (expanded) {
        card.style.maxHeight = card.scrollHeight + 'px';
        if (fade) fade.style.display = 'none';
        if (labelC) labelC.classList.add('hidden');
        if (labelE) labelE.classList.remove('hidden');
      } else {
        card.style.maxHeight = '344px';
        if (fade) fade.style.display = '';
        if (labelC) labelC.classList.remove('hidden');
        if (labelE) labelE.classList.add('hidden');
      }
    });
  }

  document.querySelectorAll('[data-news-card]').forEach(initCard);

  /* =========================================================
   * Пагинация
   * =======================================================*/
  const listEl = document.getElementById('news-list');
  const pagEl = document.getElementById('news-pagination');
  if (!listEl || !pagEl) return;

  const items = Array.from(listEl.children);
  if (items.length === 0) {
    pagEl.style.display = 'none';
    return;
  }

  const totalPages = Math.max(1, Math.ceil(items.length / PAGE_SIZE));

  if (totalPages <= 1) {
    // Если всего одна страница, пагинацию не показываем
    pagEl.style.display = 'none';
    items.forEach((el) => (el.style.display = ''));
    return;
  }

  let currentPage = 1;
  let windowStart = 1;

  const clampWindow = () => {
    if (currentPage < windowStart) windowStart = currentPage;
    if (currentPage > windowStart + VISIBLE_PAGES - 1) {
      windowStart = currentPage - VISIBLE_PAGES + 1;
    }
    if (windowStart < 1) windowStart = 1;
    const maxStart = Math.max(1, totalPages - VISIBLE_PAGES + 1);
    if (windowStart > maxStart) windowStart = maxStart;
  };

  const makeBtn = (html, onclick, opts) => {
    opts = opts || {};
    const b = document.createElement('button');
    b.type = 'button';
    b.innerHTML = html;
    b.className =
      'min-w-[36px] h-9 px-2 flex items-center justify-center transition-colors text-base cursor-pointer ' +
      (opts.cls || '');
    if (opts.disabled) {
      b.disabled = true;
      b.classList.add('opacity-30', 'cursor-not-allowed');
    } else if (onclick) {
      b.addEventListener('click', onclick);
    }
    return b;
  };

  const renderPag = () => {
    pagEl.innerHTML = '';
    // Стрелка влево
    pagEl.appendChild(
      makeBtn('&larr;', () => showPage(currentPage - 1), {
        cls: 'text-white hover:text-[#FFB35B] text-xl',
        disabled: currentPage <= 1,
      })
    );

    const endPage = Math.min(totalPages, windowStart + VISIBLE_PAGES - 1);
    for (let p = windowStart; p <= endPage; p++) {
      const active = p === currentPage;
      pagEl.appendChild(
        makeBtn(String(p), () => showPage(p), {
          cls: active
            ? 'text-[#FFB35B] font-bold border-b-2 border-[#FFB35B]'
            : 'text-white hover:text-[#FFB35B]',
        })
      );
    }

    // Стрелка вправо
    pagEl.appendChild(
      makeBtn('&rarr;', () => showPage(currentPage + 1), {
        cls: 'text-white hover:text-[#FFB35B] text-xl',
        disabled: currentPage >= totalPages,
      })
    );
  };

  const showPage = (p) => {
    if (p < 1 || p > totalPages) return;
    currentPage = p;
    clampWindow();
    items.forEach((el, i) => {
      const itemPage = Math.floor(i / PAGE_SIZE) + 1;
      el.style.display = itemPage === p ? '' : 'none';
    });
    renderPag();
  };

  showPage(1);
})();
</script>
