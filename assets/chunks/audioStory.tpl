<div class="flex gap-3 xl:gap-0" data-audio-story>
    <!-- КАРТИНКА -->
    <div class="flex justify-center items-start xl:items-end xl:mr-20 shrink-0">
        <div class="w-[59px] h-[59px] xl:w-[60px] xl:h-[140px] xl:w-[149px] xl:h-[149px] rounded-lg xl:rounded-2xl overflow-hidden bg-[#FFB35B]/70">
            [[+image:striptags:strip:len:gt=`0`:then=`
                <img src="[[+image]]" alt="[[+original_story_name]]" class="w-full h-full xl:rounded-2xl object-cover">
            `:else=`
                <div class="w-full h-full xl:rounded-2xl bg-gray-200 flex items-center justify-center">
                    <span class="text-gray-400 text-[10px] text-center">обложка отсутствует</span>
                </div>
            `]]
        </div>
    </div>

    <div class="flex flex-col ml-0 min-[420px]:ml-10 xl:ml-0 gap-1 xl:gap-6 flex-grow min-w-0">
        <!-- ОРИГИНАЛЬНОЕ АУДИО -->
        <div
            class="audio-container w-full flex flex-row items-center gap-3 xl:gap-0 xl:flex-col xl:items-stretch"
            data-audio-root
            data-story-title="[[+original_story_name]]"
            data-story-label="оригинальная сказка"
        >
            <div class="flex flex-col flex-grow min-w-0 xl:mb-2 order-2 xl:order-1">
                <h3 class="text-[13px] xl:text-[17px] font-semibold text-[#FFB35B] xl:truncate">[[+original_story_name]]</h3>
                <span class="text-[10px] xl:text-[13px] lowercase font-light text-[#FFB35B]">
                    Оригинальная сказка
                </span>
            </div>
            <div class="flex items-center w-auto xl:w-full transition-all duration-500 ease-in-out gap-4 shrink-0 order-1 xl:order-2">
                <div
                    class="relative flex items-center w-7 h-7 xl:w-10 xl:h-10 rounded-full transition-all duration-500 overflow-hidden xl:flex-grow"
                    data-player-bar
                >
                    <div class="relative z-20 flex items-center h-full w-full xl:w-auto">
                        <button
                            class="w-full xl:w-auto h-full px-0 xl:pl-4 xl:pr-3 flex items-center justify-center cursor-pointer bg-[#FFB35B] xl:bg-[#FFB35B]/70"
                            data-base-color="bg-[#FFB35B]/70"
                            data-play-btn
                        >
                            <div class="play-icon border-l-[10px] xl:border-l-[12px] border-l-[#0F212F] border-y-[7px] xl:border-y-[8px] border-y-transparent ml-0.5 xl:ml-1"></div>
                            <div class="pause-icon hidden gap-1">
                                <div class="w-1 xl:w-1.5 h-3 xl:h-4 bg-[#0F212F]"></div>
                                <div class="w-1 xl:w-1.5 h-3 xl:h-4 bg-[#0F212F]"></div>
                            </div>
                        </button>
                        <div class="w-[1px] h-full bg-[#0F212F]/50 hidden xl:block" data-divider></div>
                    </div>
                    <div
                        class="hidden xl:flex relative flex-grow h-full cursor-pointer items-center px-3 bg-[#FFB35B]/70"
                        data-progress-area
                    >
                        <span class="relative z-10 text-sm font-mono text-[#0F212F]" data-duration>00:00</span>
                        <div
                            class="absolute top-0 left-0 h-full bg-[#FFB35B] pointer-events-none transition-all duration-100"
                            data-progress
                            style="width: 0%"
                        ></div>
                    </div>
                    <audio src="[[+original_story_file]]" data-main-audio preload="metadata"></audio>
                </div>
                <div class="hidden items-center gap-2 w-32 animate-fade-in" data-volume-cont>
                    <img class="h-5 w-5" src="/assets/images/volume-bar.png" alt="">
                    <div class="relative w-full h-1 bg-[#EFEADE80]/50 rounded-full overflow-hidden cursor-pointer touch-none flex" data-volume-bar>
                        <div class="absolute top-0 left-0 h-full bg-white pointer-events-none" data-volume-progress style="width: 100%"></div>
                    </div>
                </div>
            </div>
        </div>

        <!-- ВТОРОЕ АУДИО (file_2) -->
        <div
            class="audio-container w-full flex flex-row items-center gap-3 xl:gap-0 xl:flex-col xl:items-stretch"
            data-audio-root
            data-story-title="[[+translated_story_name]]"
            data-story-label="сказка в переводе"
        >
            <div class="flex flex-col flex-grow min-w-0 xl:mb-2 order-2 xl:order-1">
                <h3 class="text-[13px] xl:text-[17px] font-semibold text-white xl:truncate">[[+translated_story_name]]</h3>
                <span class="text-[10px] xl:text-[13px] lowercase tracking-wide xl:tracking-widest text-white font-light">
                    сказка в переводе
                </span>
            </div>
            <div class="flex items-start xl:items-center h-full xl:h-auto w-auto xl:w-full transition-all duration-500 ease-in-out gap-4 shrink-0 order-1 xl:order-2">
                <div
                    class="relative flex items-center w-7 h-7 xl:w-auto xl:h-10 rounded-full transition-all duration-500 overflow-hidden xl:flex-grow"
                    data-player-bar
                >
                    <div class="relative z-20 flex items-center h-full w-full xl:w-auto">
                        <button
                            class="w-full xl:w-auto h-full px-0 xl:pl-4 xl:pr-3 flex items-center justify-center cursor-pointer bg-[#EFEADE] xl:bg-[#EFEADE]/70"
                            data-base-color="bg-[#EFEADE]/70"
                            data-play-btn
                        >
                            <div class="play-icon border-l-[10px] xl:border-l-[12px] border-l-[#0F212F] border-y-[7px] xl:border-y-[8px] border-y-transparent ml-0.5 xl:ml-1"></div>
                            <div class="pause-icon hidden gap-1">
                                <div class="w-1.5 h-3.5 xl:h-4 bg-[#0F212F]"></div>
                                <div class="w-1.5 h-3.5 xl:h-4 bg-[#0F212F]"></div>
                            </div>
                        </button>
                        <div class="w-[1px] h-full bg-[#0F212F]/50 hidden xl:block" data-divider></div>
                    </div>
                    <div
                        class="hidden xl:flex relative flex-grow h-full cursor-pointer items-center px-3 bg-[#EFEADE]/70"
                        data-progress-area
                    >
                        <span class="relative z-10 text-sm font-mono text-[#0F212F]" data-duration>00:00</span>
                        <div
                            class="absolute top-0 left-0 h-full bg-[#EFEADE] pointer-events-none transition-all duration-100"
                            data-progress
                            style="width: 0%"
                        ></div>
                    </div>
                    <audio src="[[+translated_story_file]]" data-main-audio preload="metadata"></audio>
                </div>
                <div class="hidden items-center gap-2 w-32 animate-fade-in" data-volume-cont>
                    <img class="h-5 w-5" src="/assets/images/volume-bar.png" alt="">
                    <div class="relative w-full h-1 bg-[#EFEADE80]/50 rounded-full overflow-hidden cursor-pointer touch-none flex" data-volume-bar>
                        <div class="absolute top-0 left-0 h-full bg-white pointer-events-none" data-volume-progress style="width: 100%"></div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
