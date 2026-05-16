<div class="news-card border p-6 mb-8 rounded-xl bg-white/5 text-white">
    <h2 class="text-2xl font-bold mb-4">[[+news_title]]</h2>
    
    <!-- Текст новости из TinyMCE -->
    <div class="news-content prose prose-invert mb-6">
        [[+news_text]]
    </div>
    
    <!-- Вложенный вывод картинок галереи -->
    <div class="news-images-grid flex gap-4 flex-wrap">
        [[getImageList?
          &value=`[[+news_gallery]]`
          &tpl=`tpl.newsGalleryItem`
        ]]
    </div>
</div>