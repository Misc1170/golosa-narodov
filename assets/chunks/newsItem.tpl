<article
  class="news-card relative bg-white/5 text-white rounded-xl px-6 pt-6 pb-12 overflow-hidden transition-[max-height] duration-300 ease-in-out"
  data-news-card
  style="max-height: 344px;"
>
  <div class="flex gap-x-6">
    <!-- Галерея слева -->
    <div
      class="relative shrink-0 w-[280px] h-[280px] rounded-lg overflow-hidden bg-black/20"
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

    <!-- Текст справа -->
    <div class="flex-1 flex flex-col min-w-0">
      <h2 class="text-2xl font-bold mb-4">[[+title]]</h2>
      <div class="news-content prose prose-invert max-w-none" data-news-text>
        [[+content]]
      </div>
    </div>
  </div>

  <!-- Градиент-затухание над свёрнутым текстом -->
  <div
    class="absolute bottom-0 left-0 right-0 h-20 bg-gradient-to-t from-[#021b3a] via-[#021b3a]/85 to-transparent pointer-events-none rounded-b-xl"
    data-fade
  ></div>

  <!-- Кнопка раскрытия/сворачивания -->
  <button
    type="button"
    data-toggle-news
    class="absolute bottom-3 right-6 z-10 text-[#FFB35B] hover:underline font-semibold text-sm cursor-pointer"
  >
    <span data-toggle-collapsed>Читать полностью</span>
    <span data-toggle-expanded class="hidden">Свернуть</span>
  </button>
</article>
