<div class="flex items-center justify-center gap-x-4 xl:gap-x-8 text-[#FFB35B]">
    <img class="w-[76px] h-[10px] xl:w-[115px] xl:h-[15px]" src="/assets/images/bubles.png" alt="">
    <h1 class="text-[30px] xl:text-[50px] font-balkara">Новости</h1>
    <img class="w-[76px] h-[10px] xl:w-[115px] xl:h-[15px]" src="/assets/images/bubles.png" alt="">
</div>

<div class="w-full xl:mx-10 my-8 xl:mt-20" id="news-page">
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
      class="flex justify-start items-center gap-x-2 mt-12 font-neris"
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
    const isXl = window.innerWidth >= 1280;
    const COLLAPSED_H = isXl ? 352 : 780;
    card.style.maxHeight = COLLAPSED_H + 'px';

    /* --- Галерея --- */
    const gallery = card.querySelector('[data-gallery]');
    if (gallery) {
      const images = gallery.querySelectorAll('.news-gallery-img');
      const prev = gallery.querySelector('[data-gallery-prev]');
      const next = gallery.querySelector('[data-gallery-next]');

      if (images.length === 0) {
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
    const contentDiv = card.querySelector('[data-card-content]');
    const textEl     = card.querySelector('[data-news-text]');
    const allToggles = Array.from(card.querySelectorAll('[data-toggle-news]'));
    const allLabelC  = Array.from(card.querySelectorAll('[data-toggle-collapsed]'));
    const allLabelE  = Array.from(card.querySelectorAll('[data-toggle-expanded]'));

    // Элемент, по которому определяем переполнение:
    // xl → textEl (обрезается фиксированной высотой xl:h-[196px])
    // mobile → contentDiv (flex-1 overflow-hidden)
    const overflowEl = isXl ? textEl : contentDiv;
    if (!overflowEl) return;

    const overflows = overflowEl.scrollHeight > overflowEl.clientHeight + 1;

    if (!overflows) {
      allToggles.forEach(t => t.style.display = 'none');
      // На mobile сжимаем карточку до реального размера контента
      if (!isXl && contentDiv) {
        card.style.maxHeight = (card.offsetHeight - contentDiv.clientHeight + contentDiv.scrollHeight) + 'px';
      }
      return;
    }
    if (allToggles.length === 0) return;

    // Измеряем полную высоту без изменения max-height.
    // scrollHeight дочернего overflow:hidden элемента всегда отражает полный контент,
    // поэтому формула card.offsetHeight - contentDiv.clientHeight + contentDiv.scrollHeight
    // даёт реальную высоту развёрнутой карточки.
    // На xl textEl дополнительно ограничен xl:h-[196px] — временно снимаем это ограничение,
    // чтобы contentDiv.scrollHeight учёл полный текст.
    if (isXl && textEl) { textEl.style.height = 'auto'; textEl.style.overflow = 'visible'; }
    void card.offsetHeight; // reflow перед чтением scrollHeight
    const expandedHeight = card.offsetHeight - contentDiv.clientHeight + contentDiv.scrollHeight;
    if (isXl && textEl) { textEl.style.height = ''; textEl.style.overflow = ''; }

    /* --- Затухание --- */
    const applyFade = () => {
      if (!textEl) return;
      let clipPoint;
      if (isXl) {
        // На xl textEl сам обрезает контент через xl:h-[196px]
        clipPoint = textEl.clientHeight;
      } else {
        // На mobile обрезает contentDiv; вычисляем точку в координатах textEl
        const cdRect = contentDiv.getBoundingClientRect();
        const txRect = textEl.getBoundingClientRect();
        clipPoint = contentDiv.clientHeight - (txRect.top - cdRect.top);
      }
      if (clipPoint <= 0 || clipPoint >= textEl.scrollHeight) return;
      const clipPct = Math.min(100, (clipPoint / textEl.scrollHeight) * 100);
      const fadePct = Math.max(0, clipPct - 12);
      const mask = `linear-gradient(to bottom, black 50%, transparent 100%)`;
      // const mask = `linear-gradient(to bottom, black ${fadePct.toFixed(1)}%, transparent ${clipPct.toFixed(1)}%)`;
      textEl.style.webkitMaskImage = mask;
      textEl.style.maskImage = mask;
    };
    const removeFade = () => {
      if (!textEl) return;
      textEl.style.webkitMaskImage = 'none';
      textEl.style.maskImage = 'none';
    };
    applyFade();

    /* --- Обработчик кнопки --- */
    const handleToggle = () => {
      const expanded = card.classList.toggle('is-expanded');
      if (expanded) {
        removeFade();
        if (isXl && textEl) { textEl.style.height = 'auto'; textEl.style.overflow = 'visible'; }
        card.style.maxHeight = expandedHeight + 'px';
        allLabelC.forEach(el => el.classList.add('hidden'));
        allLabelE.forEach(el => el.classList.remove('hidden'));
      } else {
        if (isXl && textEl) { textEl.style.height = ''; textEl.style.overflow = ''; }
        card.style.maxHeight = COLLAPSED_H + 'px';
        allLabelC.forEach(el => el.classList.remove('hidden'));
        allLabelE.forEach(el => el.classList.add('hidden'));
        // Затухание после завершения перехода (clientHeight уже свёрнутый)
        card.addEventListener('transitionend', function onEnd(e) {
          if (e.propertyName !== 'max-height') return;
          card.removeEventListener('transitionend', onEnd);
          applyFade();
        });
      }
    };

    allToggles.forEach(t => t.addEventListener('click', handleToggle));
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
      'w-8 h-8 px-2 flex items-center justify-center transition-colors text-base cursor-pointer ' +
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
    pagEl.appendChild(
      makeBtn('<svg width="10" height="16" viewBox="0 0 10 16" fill="currentColor"><polygon points="10,0 0,8 10,16"/></svg>', () => showPage(currentPage - 1), {
        cls: 'text-white font-light bg-[#D9D9D9]/20 rounded-md',
        disabled: currentPage <= 1,
      })
    );

    const endPage = Math.min(totalPages, windowStart + VISIBLE_PAGES - 1);
    for (let p = windowStart; p <= endPage; p++) {
      const active = p === currentPage;
      pagEl.appendChild(
        makeBtn(String(p), () => showPage(p), {
          cls: active
            ? 'text-white font-light bg-[#FFB35B]/50 rounded-md'
            : 'text-white font-light bg-[#D9D9D9]/20 rounded-md',
        })
      );
    }

    pagEl.appendChild(
      makeBtn('<svg width="10" height="16" viewBox="0 0 10 16" fill="currentColor"><polygon points="0,0 10,8 0,16"/></svg>', () => showPage(currentPage + 1), {
        cls: 'text-white font-light bg-[#D9D9D9]/20 rounded-md',
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
