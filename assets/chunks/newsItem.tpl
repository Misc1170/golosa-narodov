<article
  class="news-card relative bg-[#CDC3B3] rounded-xl p-6 overflow-hidden transition-[max-height] duration-300 ease-in-out"
  data-news-card
  style="max-height: 344px;"
>
  <div class="flex gap-x-6 items-start pr-[56px]">
    <!-- Первая часть: картинка-галерея -->
    <div
      class="relative shrink-0 w-[280px] h-[280px] rounded-3xl overflow-hidden bg-black/20"
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
      >
        &larr;
      </button>
      <button
        type="button"
        data-gallery-next
        aria-label="Следующая картинка"
        class="absolute right-2 top-1/2 -translate-y-1/2 z-20 w-9 h-9 rounded-full bg-[#0F212F]/70 hover:bg-[#0F212F] flex items-center justify-center text-white text-lg cursor-pointer transition-colors"
      >
        &rarr;
      </button>
    </div>

    <!-- Вторая часть: заголовок, текст и кнопка -->
    <div class="flex-1 flex flex-col min-w-0 text-[#0F212F]">
      <h2 class="text-xl font-bold mb-4 break-words">[[+title]]</h2>
      <!-- Текст: фиксированная высота, затухание снизу через JS-маску -->
      <div
        class="news-content prose prose-invert max-w-none h-[196px] overflow-hidden text-[20px] font-semibold break-words"
        data-news-text
      >
        [[+content]]
      </div>
      <!-- Кнопка на новой строке под текстом -->
      <button
        type="button"
        data-toggle-news
        class="self-start hover:underline font-light cursor-pointer text-xl"
      >
        <span data-toggle-collapsed>Читать полностью</span>
        <span data-toggle-expanded class="hidden">Скрыть</span>
      </button>
    </div>

  </div>

  <!-- Декоративные треугольники справа -->
  <img
    src="/assets/images/news/triangles.png"
    alt=""
    aria-hidden="true"
    class="absolute right-0 top-0 h-[344px] w-auto pointer-events-none select-none"
  >
</article>
