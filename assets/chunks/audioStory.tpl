<div class="flex gap-3 xl:gap-0" data-audio-story>
    <!-- КАРТИНКА -->
    <div class="flex justify-center items-start xl:mr-4 shrink-0">
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
            class="audio-container w-full flex flex-row flex-wrap items-center gap-3 xl:gap-0 xl:flex-col xl:items-stretch"
            data-audio-root
            data-story-title="[[+original_story_name]]"
            data-story-label="оригинальная сказка"
        >
            <div class="flex flex-col flex-grow min-w-0 xl:mb-2 order-2 xl:order-1 ml-0 xl:ml-25">
                <h3 class="text-[13px] xl:text-[17px] font-semibold text-[#FFB35B] xl:truncate">[[+original_story_name]]</h3>
                <span class="text-[10px] xl:text-[13px] lowercase font-light text-[#FFB35B]">
                    Оригинальная сказка
                </span>
            </div>
            <div class="flex items-start w-auto xl:w-full transition-all duration-500 ease-in-out gap-4 shrink-0 order-1 xl:order-2">
                [[+original_story_description:striptags:strip:len:gt=`0`:then=`
                <button
                    type="button"
                    class="hidden xl:flex items-center justify-center w-9 h-9 rounded-full shrink-0 mt-0.5 transition-colors duration-300"
                    data-menu-btn
                    aria-label="Подробнее об аудиозаписи"
                >
                    <svg width="4" height="18" viewBox="0 0 4 18" fill="none" xmlns="http://www.w3.org/2000/svg">
                        <circle cx="2" cy="2" r="2" fill="#EFEADE"/>
                        <circle cx="2" cy="9" r="2" fill="#EFEADE"/>
                        <circle cx="2" cy="16" r="2" fill="#EFEADE"/>
                    </svg>
                </button>
                `:else=``]]
                <div class="flex flex-col xl:flex-grow min-w-0 gap-0 xl:relative">
                    [[+original_story_description:striptags:strip:len:gt=`0`:then=`
                    <div
                        class="hidden max-xl:hidden absolute inset-0 z-0 rounded-3xl pointer-events-none bg-[#EFEADE]/20"
                        data-info-backing
                    ></div>
                    `:else=``]]
                    <div
                        class="relative z-10 flex items-center w-7 h-7 xl:w-full xl:h-10 rounded-full transition-all duration-500 overflow-hidden"
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
                    [[+original_story_description:striptags:strip:len:gt=`0`:then=`
                    <div
                        class="hidden max-xl:hidden relative z-10 px-5 py-4 text-[17px] text-white font-light text-justify"
                        data-info-panel
                    >
                        [[+original_story_description:striptags]]
                    </div>
                    `:else=``]]
                </div>
                <div class="hidden items-center gap-2 w-32 xl:mt-2.5 animate-fade-in" data-volume-cont>
                    <img class="h-5 w-5" src="/assets/images/volume-bar.png" alt="">
                    <div class="relative w-full h-1 bg-[#EFEADE80]/50 rounded-full overflow-hidden cursor-pointer touch-none flex" data-volume-bar>
                        <div class="absolute top-0 left-0 h-full bg-white pointer-events-none" data-volume-progress style="width: 100%"></div>
                    </div>
                </div>
            </div>
            [[+original_story_description:striptags:strip:len:gt=`0`:then=`
            <button
                type="button"
                class="flex xl:hidden items-center justify-center w-9 h-9 rounded-full shrink-0 order-3 transition-colors duration-300"
                data-menu-btn
                aria-label="Подробнее об аудиозаписи"
            >
                <svg width="4" height="18" viewBox="0 0 4 18" fill="none" xmlns="http://www.w3.org/2000/svg">
                    <circle cx="2" cy="2" r="2" fill="#EFEADE"/>
                    <circle cx="2" cy="9" r="2" fill="#EFEADE"/>
                    <circle cx="2" cy="16" r="2" fill="#EFEADE"/>
                </svg>
            </button>
            <div
                class="hidden xl:hidden order-4 w-full mt-1 rounded-2xl bg-[#EFEADE]/20 px-4 py-3 text-[12px] text-white font-light text-justify"
                data-info-panel
            >
                [[+original_story_description:striptags]]
            </div>
            `:else=``]]
        </div>

        <!-- ВТОРОЕ АУДИО (file_2) -->
        <div
            class="audio-container w-full flex flex-row flex-wrap items-center gap-3 xl:gap-0 xl:flex-col xl:items-stretch"
            data-audio-root
            data-story-title="[[+translated_story_name]]"
            data-story-label="сказка в переводе"
        >
            <div class="flex flex-col flex-grow min-w-0 xl:mb-2 order-2 xl:order-1 ml-0 xl:ml-25">
                <h3 class="text-[13px] xl:text-[17px] font-semibold text-white xl:truncate">[[+translated_story_name]]</h3>
                <span class="text-[10px] xl:text-[13px] lowercase text-white font-light">
                    сказка в переводе
                </span>
            </div>
            <div class="flex items-start w-auto xl:w-full transition-all duration-500 ease-in-out gap-4 shrink-0 order-1 xl:order-2">
                [[+translated_story_description:striptags:strip:len:gt=`0`:then=`
                <button
                    type="button"
                    class="hidden xl:flex items-center justify-center w-9 h-9 rounded-full shrink-0 mt-0.5 transition-colors duration-300"
                    data-menu-btn
                    aria-label="Подробнее об аудиозаписи"
                >
                    <svg width="4" height="18" viewBox="0 0 4 18" fill="none" xmlns="http://www.w3.org/2000/svg">
                        <circle cx="2" cy="2" r="2" fill="#EFEADE"/>
                        <circle cx="2" cy="9" r="2" fill="#EFEADE"/>
                        <circle cx="2" cy="16" r="2" fill="#EFEADE"/>
                    </svg>
                </button>
                `:else=``]]
                <div class="flex flex-col xl:flex-grow min-w-0 gap-0 xl:relative">
                    [[+translated_story_description:striptags:strip:len:gt=`0`:then=`
                    <div
                        class="hidden max-xl:hidden absolute inset-0 z-0 rounded-3xl pointer-events-none bg-[#EFEADE]/20"
                        data-info-backing
                    ></div>
                    `:else=``]]
                    <div
                        class="relative z-10 flex items-center w-7 h-7 xl:w-full xl:h-10 rounded-full transition-all duration-500 overflow-hidden"
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
                                    <div class="w-1 xl:w-1.5 h-3 xl:h-4 bg-[#0F212F]"></div>
                                    <div class="w-1 xl:w-1.5 h-3 xl:h-4 bg-[#0F212F]"></div>
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
                    [[+translated_story_description:striptags:strip:len:gt=`0`:then=`
                    <div
                        class="hidden max-xl:hidden relative z-10 px-5 py-4 text-[17px] text-white font-light text-justify"
                        data-info-panel
                    >
                        [[+translated_story_description:striptags]]
                    </div>
                    `:else=``]]
                </div>
                <div class="hidden items-center gap-2 w-32 xl:mt-2.5 animate-fade-in" data-volume-cont>
                    <img class="h-5 w-5" src="/assets/images/volume-bar.png" alt="">
                    <div class="relative w-full h-1 bg-[#EFEADE80]/50 rounded-full overflow-hidden cursor-pointer touch-none flex" data-volume-bar>
                        <div class="absolute top-0 left-0 h-full bg-white pointer-events-none" data-volume-progress style="width: 100%"></div>
                    </div>
                </div>
            </div>
            [[+translated_story_description:striptags:strip:len:gt=`0`:then=`
            <button
                type="button"
                class="flex xl:hidden items-center justify-center w-9 h-9 rounded-full shrink-0 order-3 transition-colors duration-300"
                data-menu-btn
                aria-label="Подробнее об аудиозаписи"
            >
                <svg width="4" height="18" viewBox="0 0 4 18" fill="none" xmlns="http://www.w3.org/2000/svg">
                    <circle cx="2" cy="2" r="2" fill="#EFEADE"/>
                    <circle cx="2" cy="9" r="2" fill="#EFEADE"/>
                    <circle cx="2" cy="16" r="2" fill="#EFEADE"/>
                </svg>
            </button>
            <div
                class="hidden xl:hidden order-4 w-full mt-1 rounded-2xl bg-[#EFEADE]/20 px-4 py-3 text-[12px] text-white font-light text-justify"
                data-info-panel
            >
                [[+translated_story_description:striptags]]
            </div>
            `:else=``]]
        </div>
    </div>
</div>
