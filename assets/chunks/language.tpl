<div class="flex flex-col mx-4 xl:mx-30 mb-20 mt-4 xl:mt-10 pb-24 xl:pb-0">
  <div class="grid grid-cols-1 xl:grid-cols-12 text-white items-start gap-4 xl:gap-0">
    <div class="flex col-span-1 xl:col-span-5 justify-start xl:justify-end items-start flex-shrink-0">
      <img class="h-[80px] w-[18px] xl:h-[151px] xl:w-[30px]" src="/assets/images/red-arrow-down.png" alt="">
      <div class="flex flex-col ml-4 xl:ml-10">
        <h1 class="uppercase font-bold text-[22px] xl:text-[35px] leading-tight">[[*pagetitle]]</h1>
        <h2 class="text-[16px] xl:text-[30px] font-light leading-none">сказки</h2>
      </div>
    </div>

    <div class="hidden xl:block xl:col-span-2"></div>

    <div class="col-span-1 xl:col-span-5 mt-2 xl:ml-10">
      <span class="text-[13px] xl:text-[17px] font-light leading-tight text-justify">[[*content:striptags]]</span>
    </div>
  </div>

  <div class="mt-8 xl:mt-20 flex flex-col gap-y-6 xl:gap-y-20">
    [[getImageList?
      &tvname=`audio_stories`
      &tpl=`audioStory`
    ]]
  </div>
</div>

<!-- Мобильный нижний плеер: всегда виден внизу, обновляется по активному аудио -->
<div
  id="mobile-bottom-player"
  class="xl:hidden fixed bottom-0 left-0 right-0 z-30 bg-[#1F384E] text-white border-t border-white/10"
>
  <!-- Полоса прогресса в верхней части плеера -->
  <div id="bp-progress-area" class="relative h-1 w-full bg-white/20 cursor-pointer">
    <div
      id="bp-progress"
      class="absolute top-0 left-0 h-full bg-[#FFB35B] pointer-events-none transition-all duration-100"
      style="width: 0%"
    ></div>
  </div>

  <div class="px-4 py-3 max-w-[1440px] mx-auto">
    <!-- Ряд 1: название + кнопки -->
    <div class="flex items-center gap-3 mb-3">
      <div class="flex-grow min-w-0">
        <div id="bp-title" class="text-base font-semibold text-[#FFB35B] truncate">—</div>
        <div id="bp-label" class="text-xs lowercase opacity-70 truncate"></div>
      </div>
      <div class="flex items-center gap-2 shrink-0">
        <button type="button" id="bp-prev" aria-label="Назад" class="w-9 h-9 flex items-center justify-center text-white/80 hover:text-white cursor-pointer">
          <svg width="22" height="22" viewBox="0 0 24 24" fill="currentColor"><path d="M6 6h2v12H6zM9 12l9 6V6z"/></svg>
        </button>
        <button type="button" id="bp-play" aria-label="Воспроизведение" class="w-11 h-11 rounded-full bg-[#FFB35B] flex items-center justify-center cursor-pointer shrink-0">
          <div id="bp-play-icon" class="border-l-[12px] border-l-[#0F212F] border-y-[8px] border-y-transparent ml-1"></div>
          <div id="bp-pause-icon" class="hidden gap-1">
            <div class="w-1.5 h-4 bg-[#0F212F]"></div>
            <div class="w-1.5 h-4 bg-[#0F212F]"></div>
          </div>
        </button>
        <button type="button" id="bp-next" aria-label="Вперёд" class="w-9 h-9 flex items-center justify-center text-white/80 hover:text-white cursor-pointer">
          <svg width="22" height="22" viewBox="0 0 24 24" fill="currentColor"><path d="M16 6h2v12h-2zM6 6v12l9-6z"/></svg>
        </button>
      </div>
    </div>

    <!-- Ряд 2: регулятор громкости -->
    <div class="flex items-center gap-3">
      <img class="h-5 w-5 shrink-0" src="/assets/images/volume-bar.png" alt="">
      <div
        id="bp-volume-bar"
        class="relative flex-grow h-1 bg-white/20 rounded-full overflow-hidden cursor-pointer touch-none"
      >
        <div
          id="bp-volume-progress"
          class="absolute top-0 left-0 h-full bg-white pointer-events-none"
          style="width: 100%"
        ></div>
      </div>
    </div>
  </div>
</div>

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
                                    otherBtn.classList.replace(otherBase.replace('/70', ''), otherBase);
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
                playBtn.classList.replace(baseColor, darkBaseColor);
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

    if (document.readyState === 'loading') {
        document.addEventListener('DOMContentLoaded', initAudioSystem);
    } else {
        initAudioSystem();
    }
})();
</script>
