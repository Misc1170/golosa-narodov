<article
  class="news-card relative bg-[#CDC3B3] rounded-xl p-3 xl:p-4 overflow-hidden transition-[max-height] duration-300 ease-in-out mx-3 xl:mx-0 flex flex-col"
  data-news-card
  style="max-height: 780px;"
>
  <!-- Контентная область -->
  <div class="flex-1 min-h-0 overflow-hidden rounded-b-3xl" data-card-content>
    <div class="flex flex-col xl:flex-row gap-y-3 xl:gap-y-0 gap-x-0 xl:gap-x-6 items-center xl:items-start xl:pr-[56px]">

      <!-- Картинка-галерея -->
      <div
        class="relative shrink-0 w-[320px] h-[320px] rounded-3xl overflow-hidden bg-black/20"
        data-gallery
      >
        [[getImageList?
          &value=`[[+images]]`
          &tpl=`newsGalleryItem`
        ]]
        <button
          type="button"
          data-gallery-prev
          aria-label="Предыдущая картинка"
          class="absolute left-2 top-1/2 -translate-y-1/2 z-20 w-9 h-9 rounded-full bg-[#0F212F]/70 hover:bg-[#0F212F] flex items-center justify-center text-white text-lg cursor-pointer transition-colors"
        >&larr;</button>
        <button
          type="button"
          data-gallery-next
          aria-label="Следующая картинка"
          class="absolute right-2 top-1/2 -translate-y-1/2 z-20 w-9 h-9 rounded-full bg-[#0F212F]/70 hover:bg-[#0F212F] flex items-center justify-center text-white text-lg cursor-pointer transition-colors"
        >&rarr;</button>
      </div>

      <!-- Заголовок, текст и кнопка (xl) -->
      <div class="flex-1 flex flex-col min-w-0 text-[#0F212F]">
        <h2 class="text-xl font-bold mb-4 break-words">[[+title]]</h2>
        <div
          class="news-content max-w-full text-base text-[20px] font-semibold break-words text-[#0F212F] [&_*]:max-w-full [&_img]:h-auto [&_p]:mb-2 xl:h-[230px] xl:overflow-hidden"
          data-news-text
        >[[+content]]</div>

        <!-- Кнопка xl: в потоке после текста, внутри текстовой колонки -->
        <button
          type="button"
          data-toggle-news
          class="hidden xl:block xl:self-start hover:underline font-light cursor-pointer text-xl"
        >
          <span data-toggle-collapsed class="italic">Читать полностью</span>
          <span data-toggle-expanded class="hidden italic">Скрыть</span>
        </button>
      </div>
    </div>
  </div>

  <!-- Кнопка mobile: flex-sibling, всегда видна внизу карточки -->
  <button
    type="button"
    data-toggle-news
    class="xl:hidden shrink-0 self-start mt-2 hover:underline font-light cursor-pointer text-xl"
  >
    <span data-toggle-collapsed class="italic">Читать полностью</span>
    <span data-toggle-expanded class="hidden italic">Скрыть</span>
  </button>

  <!-- Декоративные треугольники справа -->
  <img
    src="/assets/images/news/triangles.png"
    alt=""
    aria-hidden="true"
    class="hidden xl:block absolute right-0 top-0 h-[352px] w-auto pointer-events-none select-none"
  >
</article>
