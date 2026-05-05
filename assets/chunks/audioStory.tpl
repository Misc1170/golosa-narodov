<div class="flex gap-x-8">
    <!-- КАРТИНКА -->
     <div class="flex justify-center items-end">
        <div class="w-[149px] h-[149px]">
            [[+image:striptags:strip:len:gt=`0`:then=`
                <img src="[[+image]]" alt="[[+original_story_name]]" class="w-full h-full rounded-2xl object-cover">
            `:else=`
                <div class="w-full h-full rounded-2xl bg-gray-200 flex items-center justify-center">
                    <span class="text-gray-400 text-xs">обложка отсутствует</span>
                </div>
            `]]
        </div>
     </div>

    <div class="flex flex-col gap-6 flex-grow">
        <!-- ОРИГИНАЛЬНОЕ АУДИО -->
        <div class="audio-container w-full" data-audio-root>
            <div class="flex flex-col justify-between mb-2">
                <h3 class="text-[17px] font-semibold text-[#FFB35B]">[[+original_story_name]]</h3>
                <span class="text-[13px] lowercase font-light text-[#FFB35B]">
                    Оригинальная сказка
                </span>
            </div>
            <div class="flex items-center w-full transition-all duration-500 ease-in-out gap-4">
                <div class="relative flex items-center h-9 bg-orange-200 rounded-full flex-grow transition-all duration-500 overflow-hidden" data-player-bar>
                    <div class="relative z-20 flex items-center h-full">
                        <button class="pl-4 pr-3 h-full flex items-center justify-center cursor-pointer hover:opacity-80" data-play-btn>
                            <div class="play-icon border-l-[12px] border-l-[#0F212F] border-y-[8px] border-y-transparent ml-1"></div>
                            <div class="pause-icon hidden flex gap-1"><div class="w-1.5 h-4 bg-[#0F212F]"></div><div class="w-1.5 h-4 bg-[#0F212F]"></div></div>
                        </button>
                        <div class="w-[1px] h-full bg-[#0F212F80]" data-divider></div>
                    </div>
                    <div class="relative flex-grow h-full cursor-pointer flex items-center px-3 bg-[#FFB35B]/70" data-progress-area>
                        <span class="relative z-10 text-sm font-mono text-[#0F212F]" data-duration>00:00</span>
                        <div class="absolute top-0 left-0 h-full bg-[#FFB35B] pointer-events-none transition-all duration-100" data-progress style="width: 0%"></div>
                    </div>
                    <audio src="[[+original_story_file]]" data-main-audio preload="metadata"></audio>
                </div>
                <div class="hidden items-center gap-2 w-32 animate-fade-in" data-volume-cont>
                    <div class="relative w-full h-1.5 bg-gray-300 rounded-full overflow-hidden cursor-pointer touch-none" data-volume-bar>
                        <div class="absolute top-0 left-0 h-full bg-gray-600 pointer-events-none" data-volume-progress style="width: 100%"></div>
                    </div>
                </div>
            </div>
        </div>

        <!-- ВТОРОЕ АУДИО (file_2) -->
        <div class="audio-container w-full" data-audio-root>
            <div class="flex flex-col justify-between mb-2">
                <h3 class="text-[17px] font-bold text-white">[[+translated_story_name]]</h3>
                <span class="text-[13px] lowercase tracking-widest text-white font-light">
                    сказка в переводе
                </span>
            </div>
            <div class="flex items-center w-full transition-all duration-500 ease-in-out gap-4">
                <div class="relative flex items-center h-10 bg-orange-200 rounded-full flex-grow transition-all duration-500 overflow-hidden" data-player-bar>
                    <div class="relative z-20 flex items-center h-full">
                        <button class="pl-4 pr-3 h-full flex items-center justify-center cursor-pointer hover:opacity-80" data-play-btn>
                            <div class="play-icon border-l-[12px] border-l-orange-600 border-y-[8px] border-y-transparent ml-1"></div>
                            <div class="pause-icon hidden flex gap-1"><div class="w-1.5 h-4 bg-orange-600"></div><div class="w-1.5 h-4 bg-orange-600"></div></div>
                        </button>
                        <div class="w-[1px] h-full bg-[#0F212F80]" data-divider></div>
                    </div>
                    <div class="relative flex-grow h-full cursor-pointer flex items-center px-3" data-progress-area>
                        <span class="relative z-10 text-sm font-mono text-orange-700" data-duration>00:00</span>
                        <div class="absolute top-0 left-0 h-full bg-orange-500/30 pointer-events-none transition-all duration-100" data-progress style="width: 0%"></div>
                    </div>
                    <audio src="[[+translated_story_file]]" data-main-audio preload="metadata"></audio>
                </div>
                <div class="hidden items-center gap-2 w-32 animate-fade-in" data-volume-cont>
                    <div class="relative w-full h-1.5 bg-gray-300 rounded-full overflow-hidden cursor-pointer touch-none" data-volume-bar>
                        <div class="absolute top-0 left-0 h-full bg-gray-600 pointer-events-none" data-volume-progress style="width: 100%"></div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>