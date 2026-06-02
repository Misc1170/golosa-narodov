<div class="flex flex-col mx-4 xl:mx-30 mb-10 mt-4 xl:mt-10">
  <!-- Мобильный заголовок: стрелка слева охватывает название, "сказки" и описание -->
  <div class="xl:hidden flex items-start gap-3 text-white">
    <div class="xl:hidden flex flex-col">
        <img
        class="h-[85px] w-[23px] shrink-0 object-contain"
        src="/assets/images/red-arrow-down.png"
        alt=""
        >
        <img
        class="h-[85px] w-[23px] shrink-0 object-contain"
        src="/assets/images/red-arrow-down.png"
        alt=""
        >
    </div>
    <div class="flex flex-col gap-2 flex-1 min-w-0">
      <h1 class="uppercase font-bold text-[25px] leading-tight">[[*pagetitle]]</h1>
      <h2 class="italic text-[22px] leading-none">сказки</h2>
      <span class="text-[13px] font-light leading-tight text-justify mt-2">[[*content:striptags]]</span>
    </div>
  </div>

  <!-- Десктопный заголовок: стрелка + (название/сказки) | описание в правой колонке -->
  <div class="hidden xl:grid grid-cols-12 text-white items-start">
    <div class="flex col-span-5 justify-end items-start flex-shrink-0">
      <img class="h-[151px] w-[30px]" src="/assets/images/red-arrow-down.png" alt="">
      <div class="flex flex-col ml-10">
        <h1 class="uppercase font-bold text-[35px]">[[*pagetitle]]</h1>
        <h2 class="text-[30px] italic leading-none">сказки</h2>
      </div>
    </div>

    <div class="col-span-2"></div>

    <div class="col-span-5 ml-10 mt-2">
      <span class="text-[17px] font-light leading-tight text-justify">[[*content:striptags]]</span>
    </div>
  </div>

  <div class="mt-8 xl:mt-20 flex flex-col gap-y-10 xl:gap-y-6 xl:gap-y-20">
    [[getImageList?
      &tvname=`audio_stories`
      &tpl=`audioStory`
    ]]
  </div>
</div>

<!-- Мобильный нижний плеер: всегда виден внизу, обновляется по активному аудио -->
<div
  id="mobile-bottom-player"
  class="hidden xl:hidden fixed bottom-0 left-0 right-0 z-30 bg-white text-white"
>
  <!-- Полоса прогресса в верхней части плеера -->
  <div id="bp-progress-area" class="relative h-4 w-full bg-[#D9D9D9] cursor-pointer">
    <div
      id="bp-progress"
      class="absolute top-0 left-0 h-full bg-[#0F212F] pointer-events-none transition-all duration-100"
      style="width: 0%"
    ></div>
  </div>

  <div class="px-4 py-3 max-w-[1440px] mx-auto">
    <div class="flex items-center justify-between">
      <div>
        <div id="bp-title" class="text-base font-semibold text-black truncate">—</div>
        <div id="bp-label" class="text-xs lowercase text-[#0F212F] truncate"></div>
      </div>
      <div class="flex items-center gap-2 shrink-0">
        <button type="button" id="bp-prev" aria-label="Назад" class="w-9 h-9 flex items-center justify-center cursor-pointer">
          <svg class="text-[#0F212F]" width="22" height="22" viewBox="0 0 24 24" fill="currentColor"><path d="M6 6h2v12H6zM9 12l9 6V6z"/></svg>
        </button>
        <button type="button" id="bp-play" aria-label="Воспроизведение" class="w-11 h-11 rounded-full flex items-center justify-center cursor-pointer shrink-0">
          <div id="bp-play-icon" class="border-l-[12px] border-l-[#0F212F] border-y-[8px] border-y-transparent ml-1"></div>
          <div id="bp-pause-icon" class="hidden gap-1">
            <div class="w-1.5 h-4 bg-[#0F212F]"></div>
            <div class="w-1.5 h-4 bg-[#0F212F]"></div>
          </div>
        </button>
        <button type="button" id="bp-next" aria-label="Вперёд" class="w-9 h-9 flex items-center justify-center text-white/80 hover:text-white cursor-pointer">
          <svg class="text-[#0F212F]" width="22" height="22" viewBox="0 0 24 24" fill="currentColor"><path d="M16 6h2v12h-2zM6 6v12l9-6z"/></svg>
        </button>
      </div>
        
    <div class="flex items-center gap-2 shrink-0 w-[80px]">
      <img class="h-5 w-5 shrink-0" src="/assets/images/volume-bar-black.png" alt="">
      <div
        id="bp-volume-bar"
        class="relative flex-grow h-1 bg-[#0F212F]/50 rounded-full overflow-hidden cursor-pointer touch-none"
      >
        <div
          id="bp-volume-progress"
          class="absolute top-0 left-0 h-full bg-[#0F212F] pointer-events-none"
          style="width: 100%"
        ></div>
      </div>
    </div>
    </div>
  </div>
</div>

<style>
  /* На мобильной/планшетной версии регулятор громкости рядом с кнопкой воспроизведения скрыт */
  @media (max-width: 1279px) {
    [data-volume-cont] { display: none !important; }
  }
</style>

<script>
(function() {
    // Глобальная переменная для хранения уровня громкости (от 0 до 1)
    let globalVolume = 1;
    let activeAudio = null; // последнее проигрываемое аудио для нижнего плеера

    const initAudioSystem = () => {
        const allPlayers = Array.from(document.querySelectorAll('[data-audio-root]'));

        allPlayers.forEach((player, index) => {
            const audio = player.querySelector('[data-main-audio]');
            const playBtn = player.querySelector('[data-play-btn]');
            const playIcon = player.querySelector('.play-icon');
            const pauseIcon = player.querySelector('.pause-icon');
            const progress = player.querySelector('[data-progress]');
            const progressArea = player.querySelector('[data-progress-area]');
            const durationEl = player.querySelector('[data-duration]');
            const playerBar = player.querySelector('[data-player-bar]');
            const volumeCont = player.querySelector('[data-volume-cont]');
            const volumeBar = player.querySelector('[data-volume-bar]');
            const volumeProgress = player.querySelector('[data-volume-progress]');
            const baseColor = playBtn.getAttribute('data-base-color');
            const darkBaseColor = baseColor.replace('/70', '');

            let isDraggingVolume = false;

            const formatTime = (s) => {
                if (!s || isNaN(s)) return '00:00';
                const min = Math.floor(s / 60);
                const sec = Math.floor(s % 60);
                return `${min.toString().padStart(2, '0')}:${sec.toString().padStart(2, '0')}`;
            };

            const updateTimeDisplay = () => {
                if (!durationEl) return;
                if (audio.currentTime > 0) {
                    durationEl.textContent = formatTime(audio.currentTime);
                } else {
                    durationEl.textContent = formatTime(audio.duration);
                }
            };

            // Функция синхронизации громкости во всех плеерах
            const syncGlobalVolume = (newVolume) => {
                globalVolume = newVolume;
                document.querySelectorAll('[data-audio-root]').forEach(p => {
                    const a = p.querySelector('[data-main-audio]');
                    const vProg = p.querySelector('[data-volume-progress]');
                    if (a) a.volume = globalVolume;
                    if (vProg) vProg.style.width = `${globalVolume * 100}%`;
                });
            };

            audio.addEventListener('loadedmetadata', updateTimeDisplay);
            if (audio.readyState >= 1) updateTimeDisplay();

            // Устанавливаем начальную громкость при загрузке
            syncGlobalVolume(globalVolume);

            playBtn.addEventListener('click', (e) => {
                e.stopPropagation();
                if (audio.paused) {
                    document.querySelectorAll('audio').forEach(otherAudio => {
                        if (otherAudio !== audio) {
                            otherAudio.pause();
                            otherAudio.currentTime = 0;
                            const otherPlayer = otherAudio.closest('[data-audio-root]');
                            if (otherPlayer) {
                                const otherBtn = otherPlayer.querySelector('[data-play-btn]');
                                const otherDuration = otherPlayer.querySelector('[data-duration]');
                                if (otherBtn) {
                                    const otherBase = otherBtn.getAttribute('data-base-color');
                                    if (window.matchMedia('(min-width: 1280px)').matches) {
                                        otherBtn.classList.replace(otherBase.replace('/70', ''), otherBase);
                                    }
                                }
                                if (otherDuration && otherAudio.duration) otherDuration.textContent = formatTime(otherAudio.duration);
                            }
                        }
                    });
                    audio.play().catch(err => console.log("Ошибка запуска:", err));
                } else {
                    audio.pause();
                }
            });

            audio.onended = () => {
                const next = allPlayers[index + 1];
                if (next) {
                    const nextBtn = next.querySelector('[data-play-btn]');
                    if (nextBtn) nextBtn.click();
                }
            };

            if (progressArea) {
                progressArea.addEventListener('click', (e) => {
                    if (!audio.paused || audio.currentTime > 0) {
                        const rect = progressArea.getBoundingClientRect();
                        const x = e.clientX - rect.left;
                        audio.currentTime = (x / rect.width) * audio.duration;
                        updateTimeDisplay();
                    }
                });
            }

            const moveVolume = (clientX) => {
                if (!volumeBar) return;
                const rect = volumeBar.getBoundingClientRect();
                let vol = Math.max(0, Math.min(1, (clientX - rect.left) / rect.width));
                syncGlobalVolume(vol);
            };

            if (volumeBar) {
                volumeBar.addEventListener('mousedown', (e) => {
                    isDraggingVolume = true;
                    moveVolume(e.clientX);
                    document.body.style.userSelect = 'none';
                });
            }

            window.addEventListener('mousemove', (e) => { if (isDraggingVolume) moveVolume(e.clientX); });
            window.addEventListener('mouseup', () => {
                isDraggingVolume = false;
                document.body.style.userSelect = '';
            });

            audio.onplay = () => {
                playIcon.classList.add('hidden');
                pauseIcon.classList.remove('hidden');
                pauseIcon.classList.add('flex');
                if (playerBar && playerBar.parentElement) {
                    playerBar.parentElement.classList.replace('flex-grow', 'w-[60%]');
                }
                if (volumeCont) volumeCont.classList.replace('hidden', 'flex');
                if (progressArea) progressArea.style.cursor = 'pointer';
                if (window.matchMedia('(min-width: 1280px)').matches) {
                    playBtn.classList.replace(baseColor, darkBaseColor);
                }
                if (window.matchMedia('(min-width: 1280px)').matches) {
                    const hexColor = darkBaseColor.match(/#[0-9A-Fa-f]{6}/)?.[0];
                    if (hexColor && playBtn.parentElement) playBtn.parentElement.style.backgroundColor = hexColor;
                }
                audio.volume = globalVolume;

                // Обновляем нижний мобильный плеер
                activeAudio = audio;
                updateBottomPlayer(player, true);
            };

            audio.onpause = () => {
                playIcon.classList.remove('hidden');
                pauseIcon.classList.add('hidden');
                pauseIcon.classList.remove('flex');
                if (playerBar && playerBar.parentElement) {
                    playerBar.parentElement.classList.replace('w-[60%]', 'flex-grow');
                }
                if (volumeCont) volumeCont.classList.replace('flex', 'hidden');

                if (audio.currentTime === 0) {
                    if (progress) progress.style.width = '0%';
                    if (progressArea) progressArea.style.cursor = 'default';
                    if (durationEl) durationEl.textContent = formatTime(audio.duration);
                } else {
                    if (progressArea) progressArea.style.cursor = 'pointer';
                    if (durationEl) durationEl.textContent = formatTime(audio.currentTime);
                }

                if (window.matchMedia('(min-width: 1280px)').matches) {
                    if (playBtn.parentElement) playBtn.parentElement.style.backgroundColor = '';
                }
                // Обновляем нижний мобильный плеер только если это активная запись
                if (audio === activeAudio) updateBottomPlayer(player, false);
            };

            audio.ontimeupdate = () => {
                if (audio.duration) {
                    if (progress) progress.style.width = `${(audio.currentTime / audio.duration) * 100}%`;
                    if (audio.currentTime > 0 && durationEl) durationEl.textContent = formatTime(audio.currentTime);
                    // Обновляем прогресс в нижнем плеере если это активная запись
                    if (audio === activeAudio) {
                        const bpProgress = document.getElementById('bp-progress');
                        if (bpProgress) bpProgress.style.width = `${(audio.currentTime / audio.duration) * 100}%`;
                    }
                }
            };
        });

        initBottomPlayer(allPlayers);
    };

    // ==== НИЖНИЙ МОБИЛЬНЫЙ ПЛЕЕР ====
    function updateBottomPlayer(player, playing) {
        const bp = document.getElementById('mobile-bottom-player');
        if (!bp) return;
        if (playing) {
            bp.classList.remove('hidden');
            // Чтобы плеер не перекрывал футер — добавляем body отступ снизу равный высоте плеера
            // (только на мобиле; на десктопе плеер скрыт через xl:hidden)
            if (window.matchMedia('(max-width: 1279px)').matches) {
                document.body.style.paddingBottom = bp.offsetHeight + 'px';
            }
        }
        const titleEl = document.getElementById('bp-title');
        const labelEl = document.getElementById('bp-label');
        const playIc = document.getElementById('bp-play-icon');
        const pauseIc = document.getElementById('bp-pause-icon');
        const bpProgress = document.getElementById('bp-progress');
        if (titleEl) titleEl.textContent = player.dataset.storyTitle || '—';
        if (labelEl) labelEl.textContent = player.dataset.storyLabel || '';
        // Если переключили запись (или начало воспроизведения) — обнулим прогресс, если currentTime = 0
        if (bpProgress && activeAudio && activeAudio.duration) {
            bpProgress.style.width = `${(activeAudio.currentTime / activeAudio.duration) * 100}%`;
        } else if (bpProgress) {
            bpProgress.style.width = '0%';
        }
        if (playing) {
            if (playIc) playIc.classList.add('hidden');
            if (pauseIc) { pauseIc.classList.remove('hidden'); pauseIc.classList.add('flex'); }
        } else {
            if (playIc) playIc.classList.remove('hidden');
            if (pauseIc) { pauseIc.classList.add('hidden'); pauseIc.classList.remove('flex'); }
        }
    }

    function initBottomPlayer(allPlayers) {
        const bp = document.getElementById('mobile-bottom-player');
        if (!bp) return;
        const playBtn = document.getElementById('bp-play');
        const prevBtn = document.getElementById('bp-prev');
        const nextBtn = document.getElementById('bp-next');
        const progressArea = document.getElementById('bp-progress-area');
        const volumeBar = document.getElementById('bp-volume-bar');
        const volumeProgress = document.getElementById('bp-volume-progress');

        // Клик по полосе прогресса в нижнем плеере → перемотка активной записи
        if (progressArea) {
            progressArea.addEventListener('click', (e) => {
                if (!activeAudio || !activeAudio.duration) return;
                const rect = progressArea.getBoundingClientRect();
                const x = e.clientX - rect.left;
                activeAudio.currentTime = (x / rect.width) * activeAudio.duration;
            });
        }

        // Регулятор громкости в нижнем плеере
        if (volumeBar) {
            let isDraggingBpVolume = false;
            const moveBpVolume = (clientX) => {
                const rect = volumeBar.getBoundingClientRect();
                let vol = Math.max(0, Math.min(1, (clientX - rect.left) / rect.width));
                globalVolume = vol;
                document.querySelectorAll('[data-audio-root]').forEach(p => {
                    const a = p.querySelector('[data-main-audio]');
                    const vProg = p.querySelector('[data-volume-progress]');
                    if (a) a.volume = globalVolume;
                    if (vProg) vProg.style.width = `${globalVolume * 100}%`;
                });
                if (volumeProgress) volumeProgress.style.width = `${globalVolume * 100}%`;
            };
            volumeBar.addEventListener('mousedown', (e) => {
                isDraggingBpVolume = true;
                moveBpVolume(e.clientX);
                document.body.style.userSelect = 'none';
            });
            volumeBar.addEventListener('touchstart', (e) => {
                isDraggingBpVolume = true;
                moveBpVolume(e.touches[0].clientX);
            }, { passive: true });
            window.addEventListener('mousemove', (e) => { if (isDraggingBpVolume) moveBpVolume(e.clientX); });
            window.addEventListener('touchmove', (e) => { if (isDraggingBpVolume && e.touches[0]) moveBpVolume(e.touches[0].clientX); }, { passive: true });
            window.addEventListener('mouseup', () => { isDraggingBpVolume = false; document.body.style.userSelect = ''; });
            window.addEventListener('touchend', () => { isDraggingBpVolume = false; });
        }

        function currentIndex() {
            return allPlayers.findIndex(p => p.querySelector('[data-main-audio]') === activeAudio);
        }

        if (playBtn) {
            playBtn.addEventListener('click', () => {
                if (!activeAudio) {
                    // Стартуем с первой записи
                    const firstBtn = allPlayers[0] && allPlayers[0].querySelector('[data-play-btn]');
                    if (firstBtn) firstBtn.click();
                    return;
                }
                if (activeAudio.paused) activeAudio.play();
                else activeAudio.pause();
            });
        }

        if (prevBtn) {
            prevBtn.addEventListener('click', () => {
                const idx = currentIndex();
                const target = allPlayers[Math.max(0, idx - 1)];
                if (target) {
                    const btn = target.querySelector('[data-play-btn]');
                    if (btn) btn.click();
                }
            });
        }

        if (nextBtn) {
            nextBtn.addEventListener('click', () => {
                const idx = currentIndex();
                const target = allPlayers[Math.min(allPlayers.length - 1, idx + 1)];
                if (target) {
                    const btn = target.querySelector('[data-play-btn]');
                    if (btn) btn.click();
                }
            });
        }
    }

    // Пересчёт отступа body при ресайзе окна (если плеер виден)
    window.addEventListener('resize', () => {
        const bp = document.getElementById('mobile-bottom-player');
        if (!bp) return;
        if (window.matchMedia('(max-width: 1279px)').matches && !bp.classList.contains('hidden')) {
            document.body.style.paddingBottom = bp.offsetHeight + 'px';
        } else {
            document.body.style.paddingBottom = '';
        }
    });

    if (document.readyState === 'loading') {
        document.addEventListener('DOMContentLoaded', initAudioSystem);
    } else {
        initAudioSystem();
    }
})();
</script>
   